module WordCountingSTMonad where

import           Control.Monad     (forM_)
import qualified Data.HashTable.IO as H
import           Data.Text         (Text)

type HashTable k v = H.BasicHashTable k v

wordsTextHashMapST :: [Text] -> IO (HashTable Text Int)
wordsTextHashMapST theWords = do
  ht <- H.new :: IO (HashTable Text Int)
  forM_ theWords $
    \w -> do
      countMaybe <- H.lookup ht w
      H.insert ht w (case countMaybe of Just count -> count+1
                                        Nothing -> 1)
  return ht
