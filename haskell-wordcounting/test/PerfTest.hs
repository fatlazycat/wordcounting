module Main (main) where

import           Criterion.Main
import           System.Directory (getCurrentDirectory)
import           WordCounting

main = do
 putStrLn =<< getCurrentDirectory
 fileWordsList <- obtainTextListFromFile "test/test.txt"
 defaultMain [
        bench "map of words text right" $ nf wordsTextMapRight fileWordsList,
        bench "map of words text right via strict hashmap" $ nf wordsTextHashMapRight fileWordsList
       ]

