module Spec where
import PdePreludat
import Library
import Test.Hspec
import Control.Exception (evaluate)

correrTests :: IO ()
correrTests = hspec $ do
  describe "Tests de clase 7" $ do
    it "And con evaluación ansiosa falla si se le pasa False y una expresión que falla" $ do
      deberiaFallar (andEager False (error "estoy siendo evaluado"))
    it "And con evaluación perezosa retorna False si se le pasa False y una expresión que falla" $ do
      andLazy False (error "no estoy siendo evaluado") `shouldBe` False

deberiaFallar :: a -> Expectation
deberiaFallar a = evaluate a `shouldThrow` anyException