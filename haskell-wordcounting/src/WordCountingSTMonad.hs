module WordCountingSTMonad where

import qualified Data.HashTable.IO as H
import qualified Data.Text           as T (Text, filter, length, split)
import qualified Data.Foldable       as FO (foldl')
import Control.Monad

type HashTable k v = H.BasicHashTable k v

wordsTextHashMapST :: [T.Text] -> IO (HashTable T.Text Int)
wordsTextHashMapST words = do 
  ht <- H.new :: IO (HashTable T.Text Int)
  forM_ words $ 
    \w -> do 
      countMaybe <- H.lookup ht w
      H.insert ht w (case countMaybe of Just count -> count+1 
                                        Nothing -> 1)
  return ht