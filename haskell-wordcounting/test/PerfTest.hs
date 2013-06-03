module Main (main) where

import Criterion.Main    (bench, defaultMain, nf)
import System.Directory  (getCurrentDirectory)
import WordCounting      (obtainTextListFromFile, wordsTextHashMapRight, wordsTextMapRight)
import WordCountingSTMonad

main = do
 putStrLn =<< getCurrentDirectory
 fileWordsList <- obtainTextListFromFile "test/test.txt"
 defaultMain [
        bench "map of words text right" $ nf wordsTextMapRight fileWordsList,
        bench "map of words text right via strict hashmap" $ nf wordsTextHashMapRight fileWordsList,
        bench "map of words in st monad" $ wordsTextHashMapST fileWordsList
       ]

