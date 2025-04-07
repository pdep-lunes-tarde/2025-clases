module Spec where
import PdePreludat
import Library
import Test.Hspec

primeraLinea = implementame

correrTests :: IO ()
correrTests = hspec $ do
  xdescribe "primeraLinea" $ do
    
    it "dado un texto sin saltos de linea, devuelve el mismo texto" $ do
      primeraLinea "hola mundo!" `shouldBe` "hola mundo!"

    it "dado un texto con saltos de linea, devuelve el mismo hasta antes del primer salto de linea" $ do
      primeraLinea "hola\nmundo!" `shouldBe` "hola"


  describe "preguntar" $ do
    it "si le paso una oracion que ya tiene signos de pregunta, la deja igual" $ do
      preguntar "¿como estas?" `shouldBe` "¿como estas?"
    it "si le paso una oracion que le falta el signo de pregunta que cierra, se lo agrega" $ do
      preguntar "¿como estas" `shouldBe` "¿como estas?"
    it "si le paso una oracion que le falta el signo de pregunta que abre, se lo agrega" $ do
      preguntar "como estas?" `shouldBe` "¿como estas?"
    it "si le paso una oracion sin ningun signo de pregunta, agrega ambos" $ do
      preguntar "hola" `shouldBe` "¿hola?"

