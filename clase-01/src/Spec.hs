module Spec where
import PdePreludat
import Library
import Test.Hspec

correrTests :: IO ()
correrTests = hspec $ do
    it "un año es bisiesto si es divisible por 400" $ do
        shouldBe (bisiesto 800) True
    it "un año no es bisiesto si no es divisible por 400" $ do
        shouldBe (bisiesto 735) False
    it "un año es bisiesto si es divisible por 4 y no por 100" $ do
        shouldBe (bisiesto 2008) True
    it "un año NO es bisiesto si es divisible por 100 pero no por 400" $ do
        shouldBe (bisiesto 700) False
    it "un año deberia poder ser bisiesto aunque sea antes de cristo si es divisible por 400" $ do
        shouldBe (bisiesto (-400)) True
    it "un año deberia poder ser bisiesto aunque sea antes de cristo si es divisible por 100 y no por 4" $ do
        shouldBe (bisiesto (-2008)) True
    it "un año deberia NO deberia ser bisiesto aunque si es antes de cristo y no es divisible por 4" $ do
        shouldBe (bisiesto (-735)) False
