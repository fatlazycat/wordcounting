{-# OPTIONS -fno-warn-missing-signatures #-}

module Main (main) where

import Criterion.Main    (bench, defaultMain, nf)
import WordCounting      (obtainTextListFromFile, wordsTextHashMapRight, wordsTextMapRight)
import WordCountingSTMonad

main = do
 fileWordsList <- obtainTextListFromFile "test/test.txt"
 defaultMain [
        bench "map of words text right" $ nf wordsTextMapRight fileWordsList,
        bench "map of words text right via strict hashmap" $ nf wordsTextHashMapRight fileWordsList,
        bench "map of words in st monad" $ wordsTextHashMapST fileWordsList
       ]

