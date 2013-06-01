{-# OPTIONS_GHC -F -pgmF htfpp #-}
module Main where

import Test.Framework
import Test.Framework.BlackBoxTest
import {-@ HTF_TESTS @-} TestWordCounting
import {-@ HTF_TESTS @-} TestWordCountingSTMonad

main :: IO ()
main = htfMain htf_importedTests