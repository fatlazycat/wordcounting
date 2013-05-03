{-# OPTIONS_GHC -F -pgmF htfpp #-}

module TestWordCounting where

import Test.Framework  (assertEqual_, makeLoc, makeTestSuite, makeUnitTest, TestSuite)
import Text.Regex      (mkRegex, splitRegex)
import WordCounting    (obtainTextListFromFile, wordsTextMapRight, wordsTextHashMapRight)
import Data.HashMap.Strict as HMS
import Data.Text as T

wordsString = "Hi there Luce."
wordsList = Prelude.words wordsString

--"""([\.,\-– \t\"\':;\?…]+)"""
splitChars = ".,– \t\"\':;?…\n-"
wordsRegex = mkRegex "([.,– \t\"\':;?…\n-]+)"
wordsListViaRegex = splitRegex wordsRegex wordsString

test_SplitWordsString = assertEqual (Prelude.words wordsString) ["Hi", "there", "Luce."]

test_6123WordsInFile = do
  fileWordsList <- obtainTextListFromFile "test/test.txt" 
  let fileWordsMap = wordsTextMapRight fileWordsList
  let fileWordsHashMap = wordsTextHashMapRight fileWordsList
  print $ "words = " ++ show fileWordsList
  print $ "mapped words 1 = " ++ show fileWordsMap
  assertEqual (Just 277) (HMS.lookup (T.pack "the") fileWordsHashMap)
  assertEqual 6077 (Prelude.length fileWordsList)
