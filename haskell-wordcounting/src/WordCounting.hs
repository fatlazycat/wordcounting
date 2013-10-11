module WordCounting where

import           Data.Char           (isAlphaNum)
import qualified Data.Foldable       as FO (foldl')
import           Data.HashMap.Strict as HMS
import qualified Data.Map.Strict     as Map (Map, empty, insertWith)
import qualified Data.Text           as T (Text, filter, length, split)
import qualified Data.Text.IO        as TIO (readFile)

splitChars :: String
splitChars = ".,– \t\"\':;?…\n-"

isCharContained :: Char -> Bool
isCharContained c = c `elem` splitChars

obtainTextListFromFile :: FilePath -> IO [T.Text]
obtainTextListFromFile fileName = do
  contents <- TIO.readFile fileName
  let fileWordsList = T.split isCharContained contents
  return (Prelude.filter (\x -> T.length (removeNonAlphaNumFromText x) > 0) fileWordsList)

removeNonAlphaNumFromText :: T.Text -> T.Text
removeNonAlphaNumFromText = T.filter isAlphaNum

wordsTextMapRight :: [T.Text] -> Map.Map T.Text Int
wordsTextMapRight
  = FO.foldl'
      (\ acc x -> Map.insertWith (+) x 1 acc)
      Map.empty

wordsTextHashMapRight :: [T.Text] -> HMS.HashMap T.Text Int
wordsTextHashMapRight
  = FO.foldl'
      (\ acc x -> HMS.insertWith (+) x 1 acc)
      HMS.empty
