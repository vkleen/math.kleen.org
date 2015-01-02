#!/usr/bin/env runhaskell

import Text.Pandoc.Pretty
import Text.Pandoc.JSON
import System.IO

extract_title :: Pandoc -> IO Pandoc
extract_title d@(Pandoc m _) = do hPutStrLn stderr $ render Nothing $ cat $ map pretty (docTitle m)
                                  return d
  where pretty :: Inline -> Doc
        pretty (Str s) = text s
        pretty Space = space
        pretty _ = empty

main :: IO ()
main = toJSONFilter extract_title
