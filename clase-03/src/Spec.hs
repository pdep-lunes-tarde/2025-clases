module Spec where
import PdePreludat
import Library
import Test.Hspec

primeraLinea = implementame

correrTests :: IO ()
correrTests = hspec $ do
  describe "Test de prueba" $ do
    it "dos mas dos es cuatro" $ do
      2 + 2 `shouldBe` 4
