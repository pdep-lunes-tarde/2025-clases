module Spec where
import PdePreludat
import Library
import Test.Hspec

crearCartaNormal :: Number -> Color -> Carta
crearCartaNormal unNumero unColor =
  CartaNumerica unNumero unColor

ceroAzul :: Carta
ceroAzul = crearCartaNormal 0 Azul

ceroVerde :: Carta
ceroVerde = crearCartaNormal 0 Verde

sieteAzul :: Carta
sieteAzul = crearCartaNormal 7 Azul

mas4Azul :: Carta
mas4Azul = Mas4 Azul

correrTests :: IO ()
correrTests = hspec $ do
  describe "sePuedeJugarEncimaDe" $ do
    it "Una carta se puede jugar encima de otra que tiene su mismo numero" $ do
      sePuedeJugarEncimaDe ceroAzul ceroVerde `shouldBe` True
    it "Una carta se puede jugar encima de otra que tiene su mismo color" $ do
      sePuedeJugarEncimaDe ceroAzul sieteAzul `shouldBe` True
    it "Una carta no se puede jugar encima de otra si tiene distinto color y numero" $ do
      sePuedeJugarEncimaDe sieteAzul ceroVerde `shouldBe` False
    it "Una carta se puede jugar encima de un mas 4 si tiene el mismo color" $ do
      sePuedeJugarEncimaDe mas4Azul sieteAzul `shouldBe` True
    it "Una carta no se puede jugar encima de un mas 4 si tiene color distinto" $ do
      sePuedeJugarEncimaDe mas4Azul ceroVerde `shouldBe` False
    it "Un mas4 se puede jugar encima de cualquier carta" $ do
      sePuedeJugarEncimaDe ceroVerde mas4Azul `shouldBe` True