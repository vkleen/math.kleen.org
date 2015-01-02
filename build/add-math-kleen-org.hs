#!/usr/bin/env runhaskell

import Data.Map
import Text.Pandoc.Pretty
import Text.Pandoc.JSON
import System.IO

add_title :: Pandoc -> Pandoc
add_title (Pandoc m bs) = Pandoc (add_title' m) bs
  where add_title' m@(Meta map) = Meta $ insert "title" (MetaInlines $ [Link [Str "math.kleen.org:"] ("/","math.kleen.org"), Space] ++ docTitle m) map

main :: IO ()
main = toJSONFilter add_title
