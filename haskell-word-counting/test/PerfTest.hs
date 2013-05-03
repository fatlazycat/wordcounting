module Main (main) where

import           Criterion.Main
import           WordCounting

main = do
 fileWordsList <- obtainTextListFromFile "test/test.txt"
 defaultMain [
        bench "map of words text right" $ nf wordsTextMapRight fileWordsList,
        bench "map of words text right via strict hashmap" $ nf wordsTextHashMapRight fileWordsList
       ]

