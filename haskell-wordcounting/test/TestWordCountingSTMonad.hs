{-# OPTIONS_GHC -F -pgmF htfpp #-}
{-# LANGUAGE OverloadedStrings #-}

module TestWordCountingSTMonad where

import           Test.Framework      (assertEqual_, makeLoc, makeTestSuite, makeUnitTest, TestSuite)
import qualified Data.Text      as T 
import Control.Monad.ST
import Data.STRef
import Control.Monad
import qualified Data.HashTable.IO as H
import qualified WordCountingSTMonad as WCST 
import WordCounting    (obtainTextListFromFile)

type HashTable k v = H.BasicHashTable k v

test_OK = assertEqual True True

test_createText = assertEqual "Hi" (T.pack "Hi")

test_printMap = do
  ht <- WCST.wordsTextHashMapST ["hi", "there", "hi"]
  l <- H.toList ht
  forM_ l $ \x -> print x
  assertEqual 1 1

test_the277InStMonad = do
  fileWordsList <- obtainTextListFromFile "test/test.txt" 
  fileWordsHashMap <- WCST.wordsTextHashMapST fileWordsList
  found <- H.lookup fileWordsHashMap "the" 
  assertEqual (Just 277) found
  assertEqual 6077 (Prelude.length fileWordsList)   
 
--sumST :: Num a => [a] -> a
--sumST xs = runST $ do           -- runST takes out stateful code and makes it pure again.
-- 
--    n <- newSTRef 0             -- Create an STRef (place in memory to store values)
-- 
--    forM_ xs $ \x -> do         -- For each element of xs ..
--        modifySTRef n (+x)      -- add it to what we have in n.
-- 
--    readSTRef n                 -- read the value of n, and return it.
