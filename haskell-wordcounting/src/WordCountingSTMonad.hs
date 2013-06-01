module WordCountingSTMonad where

import qualified Data.HashTable.IO as H
import qualified Data.Text           as T (Text, filter, length, split)
import qualified Data.Foldable       as FO (foldl')
import Control.Monad

type HashTable k v = H.BasicHashTable k v

wordsTextHashMapST :: [T.Text] -> IO (HashTable T.Text Int)
wordsTextHashMapST words = do 
  ht <- H.new :: IO (HashTable T.Text Int)
  forM_ words $ \w -> H.insert ht w 1 
  return ht

  
--  let result = H.foldM (\ x acc -> insertElement x acc) H.new words
--  let result = foldM (\ acc x -> H.insert acc x 1 ) H.new words
--  return result
    
insertElement :: T.Text -> IO (HashTable T.Text Int) -> IO (HashTable T.Text Int)
insertElement text htio = 
  do
    ht <- htio
    countMaybe <- H.lookup ht text
    let updatedCount = case countMaybe of
                          Just count -> count+1
                          Nothing -> 1
    H.insert ht text (updatedCount + 1)                       
    return ht
