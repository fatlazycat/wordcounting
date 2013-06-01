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

type HashTable k v = H.BasicHashTable k v

test_OK = assertEqual True True

test_createText = assertEqual "Hi" (T.pack "Hi")

test_canLookup = do 
  ht <- expectedHashMap
  item <- H.lookup ht 1
  assertEqual (Just 2) item
  
test_printMap = do
  ht <- WCST.wordsTextHashMapST ["hi", "there"]
  l <- H.toList ht
  forM_ l $ \x -> print x
  assertEqual 1 1

expectedHashMap :: IO (HashTable Int Int)
expectedHashMap = do
    ht <- H.new
    H.insert ht 1 2
    return ht
    
--expectedHashMap :: IO (HashTable T.Text Int)
--expectedHashMap = do
--    ht <- H.new
--    H.insert ht "hi" 1
--    return ht    
 
--sumST :: Num a => [a] -> a
--sumST xs = runST $ do           -- runST takes out stateful code and makes it pure again.
-- 
--    n <- newSTRef 0             -- Create an STRef (place in memory to store values)
-- 
--    forM_ xs $ \x -> do         -- For each element of xs ..
--        modifySTRef n (+x)      -- add it to what we have in n.
-- 
--    readSTRef n                 -- read the value of n, and return it.
