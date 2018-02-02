{-# LANGUAGE OverloadedStrings, RankNTypes, StandaloneDeriving, FlexibleInstances, TupleSections #-}

import Hakyll

import Data.Monoid (Monoid(..), mconcat, (<>))
import Control.Monad (liftM, forM_, forM, (<=<), (>=>))
import Data.Char (toLower, isSpace, isAlphaNum)
import Data.Maybe (mapMaybe, fromMaybe, listToMaybe, catMaybes)
import Data.Map (Map)
import qualified Data.Map as Map
import qualified Data.Set as Set
import Data.List (take, reverse, nub, groupBy, concatMap, intersperse)
import Data.Function (on)
import Data.Default
import qualified Data.Text as T
import qualified Data.Text.Encoding as T
import Text.Pandoc
import Text.Pandoc.Walk (query, walkM, walk)
import Text.Pandoc.Error
import Control.Applicative (Alternative(..), Applicative(..))
import           Text.Blaze.Html                 (toHtml, toValue, (!))
import qualified Text.Blaze.Html5                as H
import qualified Text.Blaze.Html5.Attributes     as A
import           Text.Blaze.Html.Renderer.String (renderHtml)
import Text.Read (readMaybe)

import System.FilePath (takeBaseName, (</>), (<.>), (-<.>))

import System.Process.ByteString (readProcessWithExitCode)

import qualified Crypto.Hash.SHA256 as SHA256 (hash)
import qualified Data.ByteString.Char8 as CBS
import Data.Hex (hex)
import Data.Char (toLower)

import Tex (compileTex)
import Text.Printf (printf)

import Text.Regex.TDFA ((=~))

pandocWriterOptions :: Compiler WriterOptions
pandocWriterOptions = do
    id <- tagTranslation . toFilePath <$> getUnderlying
    pure $ defaultHakyllWriterOptions { writerIdentifierPrefix = id
                                      }

texCompiler texStr = do
    item <- makeItem texStr
            >>= loadAndApplyTemplate "templates/preview.tex" defaultContext
            >>= withItemBody (unsafeCompiler . compileTex)
    saveSnapshot "alignment" $ fmap snd item
    let
      match = (=~) :: String -> String -> (String, String, String, [String])
      xs = (\(_, _, _, xs) -> xs) . flip match "height='([-0-9\\.]+)pt' .* width='([-0-9\\.]+)pt'" . fst <$> item
    saveSnapshot "height" $ (!! 0) <$> xs
    saveSnapshot "width"  $ (!! 1) <$> xs
    return $ fmap fst item

postCompiler tags = do
    underlyingTags <- getUnderlying >>= getTags
    getResourceBody >>= saveSnapshot "content"
    let ctx = mconcat [ listField "tags" defaultContext $ loadSnapshotBody "rendered-tags" "rendered-tags"
                      , dateField "published" "%F"
                      , defaultContext
                      ]
        ctx' = tagsFieldWith getTags
                             (\tag _ -> Just . H.li $ H.a ! A.href (toValue . toUrl $ "tags" </> tagTranslation tag <.> "html") $ toHtml tag)
                             (mconcat . intersperse "\n")
                             "tagList"
                             tags
    wopt <- pandocWriterOptions
    pandocCompilerWithTransformM defaultHakyllReaderOptions wopt (texTransform >=> envTransform)
      >>= saveSnapshot "pandoc-content"
      >>= loadAndApplyTemplate "templates/default.html" (ctx <> (if null underlyingTags then mempty else ctx'))
      >>= relativizeUrls

main :: IO ()
main = hakyllWith config $ do
  match "templates/*" $ compile templateCompiler

  match "css/*" $ do
    route idRoute
    compile copyFileCompiler

  tex <- (++) <$> getTex "index.md" texTranslation' <*> getTex "posts/**" texTranslation'
  forM_ tex $ \(_, texStr) -> create [texTranslation' texStr] $ do
    route idRoute
    compile $ texCompiler texStr

  tags <- buildTags "posts/**" tagTranslation' >>= addTag "All Posts" "posts/**"

  create ["rendered-tags"] $
    compile $ do
        mapM (\(k, _) -> renderTag k tags) (tagsMap tags) >>= makeItem >>= saveSnapshot "rendered-tags"
        makeItem ("" :: String)

  match "posts/**" $ do
    route $ setExtension ".html"
    compile $ postCompiler tags

  tagsRules tags $ \tag pattern -> do
    route idRoute
    compile $ do
      let ctx = mconcat [ constField "title" tag
                        , constField "rss" $ "/rss" </> tagTranslation tag <.> "rss"
                        , listField "tags" defaultContext $ loadSnapshotBody "rendered-tags" "rendered-tags"
                        , defaultContext
                        ]
      renderTagPostList tag tags
        >>= loadAndApplyTemplate "templates/default.html" ctx
        >>= relativizeUrls

  let
    tags' = tags { tagsMakeId = fromFilePath . (\b -> "rss" </> b <.> "rss") . takeBaseName . toFilePath . tagsMakeId tags}

  tagsRules tags' $ \tag pattern -> do
    route idRoute
    compile $ do
      let
        feedCtx = mconcat [ bodyField "description"
                          , defaultContext
                          ]
      renderRss (feedConfig tag) feedCtx =<< loadAllSnapshots pattern "content"

  match "index.md" $ rulesExtraDependencies [tagsDependency tags] $ do
    route $ setExtension ".html"
    compile $ do
      posts <- recentFirst =<< loadAllSnapshots "posts/**" "pandoc-content"
      let ctx = mconcat [ listField "tags" defaultContext $ loadSnapshotBody "rendered-tags" "rendered-tags"
                        , boolField "indexPage" (const True)
                        , constField "rss" "/rss/all-posts.rss"
                        , listField "posts" defaultContext $ pure $ take 3 posts
                        , defaultContext
                        ]
      wopt <- pandocWriterOptions
      pandocCompilerWithTransformM defaultHakyllReaderOptions wopt (texTransform >=> envTransform)
        >>= loadAndApplyTemplate "templates/index.html" ctx
        >>= loadAndApplyTemplate "templates/default.html" ctx
        >>= relativizeUrls

deriving instance Eq (Item String)

feedConfig :: String -> FeedConfiguration
feedConfig tagName = FeedConfiguration { feedTitle = "math.kleen.org: " ++ tagName
                                       , feedDescription = "math.kleen.org — A Blog."
                                       , feedAuthorName = "V. Kleen"
                                       , feedAuthorEmail = "blog@kleen.org"
                                       , feedRoot = "http://math.kleen.org"
                                       }

renderTagPostList :: String
                  -> Tags
                  -> Compiler (Item String)
renderTagPostList tag tags = do
  ids' <- sortChronological ids
  titleRoutes <- fmap catMaybes $ forM ids' $ \id -> do
    route <- getRoute id
    title <- getMetadataField id "title"
    return $ (,) <$> title <*> route
  makeItem $ renderHtml $ H.ul $ (mconcat . intersperse "\n") $ map generateLink $ withEllipsis Nothing $ map Just titleRoutes

  where
    generateLink Nothing = toHtml ("…" :: String)
    generateLink (Just (title,route)) = H.li $ H.a ! A.href (toValue . toUrl $ route) $ toHtml title

    ids = fromMaybe [] $ lookup tag $ tagsMap tags

    withEllipsis ellipsisItem xs
      | length xs > max = ellipsisItem : takeEnd (max - 1) xs
      | otherwise = xs
    takeEnd i = reverse . take i . reverse
    max = 4
renderTag :: String -- ^ Tag name
          -> Tags
          -> Compiler (Item String)
renderTag tag tags = do
  let
    postCtx = mconcat [ constField "title" tag
                      , constField "rss" ("rss" </> tagTranslation tag <.> "rss")
                      , constField "url" ("tags" </> tagTranslation tag <.> "html")
                      , defaultContext
                      ]
  renderTagPostList tag tags
    >>= loadAndApplyTemplate "templates/tag.html" postCtx

tagTranslation' :: String -> Identifier
tagTranslation' = fromCapture "tags/*.html" . tagTranslation

tagTranslation :: String -> String
tagTranslation = mapMaybe charTrans
  where
    charTrans c
      | isSpace c = Just '-'
      | isAlphaNum c = Just $ toLower c
      | otherwise = Nothing

addTag :: MonadMetadata m => String -> Pattern -> Tags -> m Tags
addTag name pattern tags = do
  ids <- getMatches pattern
  return $ tags { tagsMap = tagsMap tags ++ [(name, ids)] }

texTranslation' :: String -> Identifier
texTranslation' = fromCapture "tex/*.svg" . map toLower . CBS.unpack . hex . SHA256.hash . CBS.pack

getTex :: Pattern -> (String -> Identifier) -> Rules [([Identifier], String)]
getTex pattern makeId = do
  ids <- getMatches pattern
  texStrs <- concat `liftM` mapM (\id -> map ((,) [id]) `liftM` getTex' (toFilePath' id)) ids
  return $ mergeGroups $ groupBy ((==) `on` snd) $ texStrs
    where
      getTex' :: FilePath -> Rules [String]
      getTex' path = preprocess . fmap concat $ (\x -> [query extractTex, query extractTex'] <*> pure x) `liftM` readPandoc' path
      extractTex :: Inline -> [String]
      extractTex (Math _ str) = [wrapMath str]
      extractTex (RawInline "latex" str) = [str]
      extractTex _ = []
      extractTex' :: Block -> [String]
      extractTex' (RawBlock "latex" str) = [str]
      extractTex' _ = []
      mergeGroups :: [[([Identifier], String)]] -> [([Identifier], String)]
      mergeGroups = map mergeGroups' . filter (not . null)
      mergeGroups' :: [([Identifier], String)] -> ([Identifier], String)
      mergeGroups' xs@((_, str):_) = (concatMap fst xs, str)

wrapMath :: String -> String
wrapMath str = "\\(" ++ str ++ "\\)"

readPandoc' :: FilePath -> IO Pandoc
readPandoc' path = CBS.readFile path >>= either fail return . result' . T.decodeUtf8
  where
    result' str = case runPure (result str) of
        Left err    -> Left $ "parse failed: " ++ (show err)
        Right item' -> Right item'
    result str = reader defaultHakyllReaderOptions (fileType path) str
    reader ro t = case t of
        DocBook            -> readDocBook ro
        Html               -> readHtml ro
        LaTeX              -> readLaTeX ro
        LiterateHaskell t' -> reader (addExt ro Ext_literate_haskell) t'
        Markdown           -> readMarkdown ro
        MediaWiki          -> readMediaWiki ro
        OrgMode            -> readOrg ro
        Rst                -> readRST ro
        Textile            -> readTextile ro
        _                  -> error $
            "I don't know how to read a file of " ++
            "the type " ++ show t ++ " for: " ++ path

    addExt ro e = ro {readerExtensions = enableExtension e $ readerExtensions ro}

envTransform :: Pandoc -> Compiler Pandoc
envTransform = pure . walk replaceProof . walk envTransform'
    where
        envs = [ ("Definition", "definition")
               , ("Theorem", "theorem")
               , ("Lemma", "lemma")
               , ("Proposition", "proposition")
               ]
        envTransform' :: Block -> Block
        envTransform' x = foldr ($) x (map replaceEnv envs)

        makeEnv :: String -> Maybe [Inline] -> Maybe String -> [Block] -> Block
        makeEnv env name label p = Div ("", [env], []) p

        replaceEnv :: (String, String) -> Block -> Block
        replaceEnv (txt, cl) p@(Para (Str x : xs))
            | x == txt ++ "." = makeEnv cl Nothing Nothing [Para xs]
            | otherwise = p
        replaceEnv _ p = p

        replaceProof :: [Block] -> [Block]
        replaceProof (p@(Para ((Str "Proof.") : xs)) : ps) = let (proof, rest) = findQED ps
                                                             in makeEnv "proof" Nothing Nothing (Para xs : proof) : replaceProof rest
        replaceProof (p : ps) = p : replaceProof ps
        replaceProof [] = []

        findQED :: [Block] -> ([Block], [Block])
        findQED ps = let (proof, rest) = findQED' ps []
                     in (reverse proof, rest)

        findQED' :: [Block] -> [Block] -> ([Block], [Block])
        findQED' (p@(Para [Str "QED."]) : ps) s = (s, ps)
        findQED' (p : ps) s = findQED' ps (p : s)


texTransform :: Pandoc -> Compiler Pandoc
texTransform = walkM texTransformInline <=< walkM texTransformBlock
  where
    texTransformInline :: Inline -> Compiler Inline
    texTransformInline (Math mathType tex) = (\html -> Span ("", [classOf mathType], []) [RawInline "html" html]) <$> texTransform' wrapMath tex
    texTransformInline (RawInline "latex" tex) = (\html -> Span ("", [], []) [RawInline "html" html]) <$> texTransform' id tex
    texTransformInline x = return x
    texTransformBlock :: Block -> Compiler Block
    texTransformBlock (RawBlock "latex" tex) = (\html -> Div ("", [], []) [RawBlock "html" html]) <$> texTransform' id tex
    texTransformBlock x = return x
    texTransform' :: (String -> String) -> String -> Compiler String
    texTransform' texT tex = do
      let
        texId = texTranslation' $ texT tex
        svgPath = toUrl $ toFilePath texId
        latexFontSize :: Double
        latexFontSize = 12 / 1.25
        size :: String -> Maybe Double
        size = fmap (/ latexFontSize) . (readMaybe :: String -> Maybe Double)
      alignment <- size <$> (loadSnapshotBody texId "alignment" :: Compiler String)
      width <- size <$> (loadSnapshotBody texId "width" :: Compiler String)
      height <- size <$> (loadSnapshotBody texId "height" :: Compiler String)
      let
        style :: [Maybe String]
        style = [ printf "vertical-align:-%.2fem;" <$> alignment
                , printf "width:%.2fem;" <$> width
                , printf "height:%.2fem;" <$> height
                ]
      return . renderHtml $ H.img
          ! A.src (toValue svgPath)
          ! A.alt (toValue tex)
          ! A.style (toValue . concat $ catMaybes style)
    classOf DisplayMath = "display-math"
    classOf InlineMath  = "inline-math"

toFilePath' :: Identifier -> FilePath
toFilePath' = (providerDirectory config </>) . toFilePath

config :: Configuration
config = defaultConfiguration { providerDirectory = "provider"
                              , deployCommand = "rsync -v --progress -ac --no-p --no-g --chmod=ugo=rX --delete-delay -m  _site/ amy:/sites/beta.math/"
                              }
