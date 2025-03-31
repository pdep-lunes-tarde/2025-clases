module Spec where
import PdePreludat
import Library
import Test.Hspec

correrTests :: IO ()
correrTests = hspec $ do
    it "test de prueba" $ do
        2 + 2 `shouldBe` 4
