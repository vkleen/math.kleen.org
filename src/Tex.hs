module Tex
       ( compileTex
       ) where

import System.IO (stdout, stderr, hPutStrLn, writeFile, readFile, hClose)
import System.IO.Temp (withSystemTempDirectory, openTempFile)
import System.Process (callProcess, readProcessWithExitCode)
import System.Directory (copyFile, getCurrentDirectory, setCurrentDirectory, getTemporaryDirectory)
import System.FilePath (takeFileName, FilePath(..), (</>))
import System.Exit (ExitCode(..))

import Control.Monad (when)
import Control.Exception (bracket, throwIO)
import Data.Maybe (fromMaybe, listToMaybe)

import Control.Monad.Writer.Strict (WriterT(..), execWriterT, tell)
import Control.Monad.Trans (liftIO)

import Control.DeepSeq (($!!))

import Text.Regex.TDFA ((=~))

instance Semigroup ExitCode where
  (ExitFailure a) <> _ = ExitFailure a
  ExitSuccess <> x@(ExitFailure _) = x
  ExitSuccess <> ExitSuccess = ExitSuccess

instance Monoid ExitCode where
  mempty = ExitSuccess

compileTex :: String -> IO (String, String)
compileTex = withSystemTempDirectory "tex" . compileTex'

compileTex' :: String -> FilePath -> IO (String, String)
compileTex' input tmpDir = do
  mapM_ (copyToTmp . ("provider/tex" </>)) [ "preview.dtx"
                                           , "preview.ins"
                                           ]
  (exitCode, out, err) <- withCurrentDirectory tmpDir $ execWriterT $ do
    run "latex" [ "-interaction=batchmode"
                , "preview.ins"
                ] ""
    liftIO $ writeFile (tmpDir </> "image.tex") input
    run "latex" [ {- "-interaction=batchmode"
                , -} "image.tex"
                ] ""
    run "dvisvgm" [ "--exact"
                  , "--no-fonts"
                  , tmpDir </> "image.dvi"
                  ] ""
  when (exitCode /= ExitSuccess) $ do
    hPutStrLn stdout out
    hPutStrLn stderr err
    (srcF, srcH) <- flip openTempFile "source.tex" =<< getTemporaryDirectory
    hPutStrLn srcH input
    hClose srcH
    hPutStrLn stdout $ "Tex source saved to " ++ srcF
    throwIO exitCode
  (\x -> return $!! (x, extractAlignment err)) =<< (readFile $ tmpDir </> "image.svg")
  where
    copyToTmp fp = copyFile fp (tmpDir </> takeFileName fp)
    run :: String -> [String] -> String -> WriterT (ExitCode, String, String) IO ()
    run bin args stdin = tell =<< liftIO (readProcessWithExitCode bin args stdin)

withCurrentDirectory :: FilePath  -- ^ Directory to execute in
                     -> IO a      -- ^ Action to be executed
                     -> IO a
withCurrentDirectory dir action =
  bracket getCurrentDirectory setCurrentDirectory $ \ _ -> do
    setCurrentDirectory dir
    action

extractAlignment :: String -> String
extractAlignment = fromMaybe "0" . extract . (=~ "depth=([^\\s]+)pt")
  where
    extract :: (String, String, String, [String]) -> Maybe String
    extract (_, _, _, xs) = listToMaybe xs
