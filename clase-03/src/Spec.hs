module Spec where
import PdePreludat
import Library
import Test.Hspec

crearCarta :: Number -> String -> Carta
crearCarta unNumero unColor = (unNumero, unColor)

ceroAzul :: Carta
ceroAzul = crearCarta 0 "Azul"

ceroVerde :: Carta
ceroVerde = crearCarta 0 "Verde"

sieteAzul :: Carta
sieteAzul = crearCarta 7 "Azul"

correrTests :: IO ()
correrTests = hspec $ do
  describe "sePuedeJugarEncimaDe" $ do
    it "Una carta se puede jugar encima de otra que tiene su mismo numero" $ do
      sePuedeJugarEncimaDe ceroAzul ceroVerde `shouldBe` True
    it "Una carta se puede jugar encima de otra que tiene su mismo color" $ do
      sePuedeJugarEncimaDe ceroAzul sieteAzul `shouldBe` True
    it "Una carta no se puede jugar encima de otra si tiene distinto color y numero" $ do
      sePuedeJugarEncimaDe sieteAzul ceroVerde `shouldBe` False