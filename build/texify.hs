#!/usr/bin/env runhaskell
{-# LANGUAGE OverloadedStrings #-}

import Text.Pandoc.JSON
import Text.Pandoc.Builder

import Control.Monad
import Control.Applicative
import qualified Data.ByteString.Char8 as BS
import Crypto.Hash
import System.IO
import System.Directory
import System.FilePath
import Text.Printf

import qualified Data.Text

type TeX = String
type RawHTML = String

texToPath :: FilePath -> TeX -> FilePath
texToPath base s = base </> "tex" </> (show ( hash (BS.pack s) :: Digest SHA1))

texToSVGPath :: FilePath -> TeX -> FilePath
texToSVGPath b s = texToPath b s </> "image.svg"

texToAlignPath :: FilePath -> TeX -> FilePath
texToAlignPath b s = texToPath b s </> "vertical-align"

texToExprPath :: FilePath -> TeX -> FilePath
texToExprPath b s = texToPath b s </> "image.expr"

compileToSVG :: FilePath -> MathType -> TeX -> IO RawHTML
compileToSVG basepath t s = let tex = Data.Text.unpack $ Data.Text.strip $ Data.Text.pack s
                                path = texToPath basepath tex
                                svg_path = texToSVGPath basepath tex
                                svg_web_path = texToSVGPath "" tex
                                align_path = texToAlignPath basepath tex
                                expr_path = texToExprPath basepath tex

                                display DisplayMath = "\\displaystyle\n"
                                display InlineMath = ""
                            in do createDirectoryIfMissing True path
                                  any (/= True) <$> mapM doesFileExist [svg_path, align_path, expr_path] >>= (flip when)
                                    (do writeFile expr_path $ (display t) ++ tex
                                        writeFile align_path "0")
                                  alignment <- head.lines <$> readFile align_path
                                  hPutStrLn stderr path
                                  return $ printf "<object data=\"/%s\" type=\"image/svg+xml\" style=\"vertical-align:-%s\">%s</object>" svg_web_path alignment tex

texify :: [String] -> Inline -> IO Inline
texify [basepath] (Math t s) = do svg <- compileToSVG basepath t s
                                  return $ Span ("", [classOf t], []) [RawInline (Format "html") svg]
  where classOf DisplayMath = "display-math"
        classOf InlineMath  = "inline-math"
texify [_] x = return x

texify_thms :: Block -> Block
texify_thms (Div (id, [cl], _)  bs)
  | cl `elem` ["theorem", "proposition", "definition", "lemma"] =
      let begin_thm = rawBlock "tex" ("\\begin{" ++ cl ++ "}")
          end_thm = rawBlock "tex" ("\\end{" ++ cl ++ "}")
      in Div (id, [], []) . toList $ begin_thm <> (fromList bs) <> end_thm
  | cl == "proof" =
      let begin_thm = rawBlock "tex" ("\\begin{" ++ cl ++ "}")
          end_thm = rawBlock "tex" ("\\end{" ++ cl ++ "}")

          add_qed [Para ins] = [Para (ins ++ [RawInline "tex" "\\qedhere"])]
          add_qed [Plain ins] = [Plain (ins ++ [RawInline "tex" "\\qedhere"])]
          add_qed [b] = [b, Plain $ [RawInline "tex" "\\qedhere"]]
          add_qed [] = []
          add_qed (x:xs) = x:add_qed xs
      in Div (id, [], []) . toList $ begin_thm <> (fromList $ add_qed bs) <> end_thm
texify_thms x = x

main :: IO ()
main = toJSONFilter texify_thms