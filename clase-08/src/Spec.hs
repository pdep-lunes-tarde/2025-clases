module Spec where
import PdePreludat
import Library
import Test.Hspec

correrTests :: IO ()
correrTests = hspec $ do
  describe "primeraSilaba" $ do
    context "siendo V = vocal fuerte (A,E,O,I con acento,U con acento), v = vocal debil (i, u) y C = consonante" $ do
      it "la primera silaba de una palabra V es la misma palabra" $ do
        primeraSilaba "o" `shouldBe` "o"
      it "la primera silaba de una palabra CV es la misma palabra" $ do
        primeraSilaba "la" `shouldBe` "la"
      it "la primera silaba de una palabra que comienza en VVCV es solo la primera letra" $ do
        primeraSilaba "aéreo" `shouldBe` "a"
      it "la primera silaba de una palabra CVC es la misma palabra" $ do
        primeraSilaba "tan" `shouldBe` "tan"
      it "la primera silaba de una palabra VCV es la primera letra" $ do
        primeraSilaba "oro" `shouldBe` "o"
      it "la primera silaba de una palabra CVCV son las primeras 2 letras" $ do
        primeraSilaba "gato" `shouldBe` "ga"
      it "la primera silaba de una palabra CCVCV son las primeras 3 letras" $ do
        primeraSilaba "plato" `shouldBe` "pla"
      it "la primera silaba de una palabra vCV es la primera letra" $ do
        primeraSilaba "uva" `shouldBe` "u"
      it "la primera silaba de una palabra CvVCV son las primeras 3 letras" $ do
        primeraSilaba "hueso" `shouldBe` "hue"
      it "la primera silaba de una palabra CVVC son las primeras 2 letras" $ do
        primeraSilaba "baúl" `shouldBe` "ba"
      it "la primera silaba de una palabra CVCCV son las primeras 3 letras" $ do
        primeraSilaba "carta" `shouldBe` "car"
      it "la primera silaba de una palabra VCCV son las primeras 2 letras" $ do
        primeraSilaba "arco" `shouldBe` "ar"
      it "la primera silaba de una palabra CVvCVC son las primeras 3 letras" $ do
        primeraSilaba "caimán" `shouldBe` "cai"
      it "la primera silaba de una palabra CVvCCV son las primeras 4 letras" $ do
        primeraSilaba "cuenta" `shouldBe` "cuen"
      it "la primera silaba de una palabra CvVC es la misma palabra" $ do
        primeraSilaba "cual" `shouldBe` "cual"
      it "la primera silaba de una palabra VCCVC si CC es un grupo consonantico es solo la primera letra" $ do
        primeraSilaba "atrás" `shouldBe` "a"
      it "la primera silaba de una palabra CVCCV si CC es un grupo consonantico es solo las primera 2 letras" $ do
        primeraSilaba "catre" `shouldBe` "ca"
      it "la primera silaba de una palabra CvVCCV si CC es un grupo consonantico son solo las primeras 3 letras" $ do
        primeraSilaba "guerra" `shouldBe` "gue"
      it "la primera silaba de una palabra CVCC es la misma palabra" $ do
        primeraSilaba "trans" `shouldBe` "trans"
      it "'ll' tiene un solo fonema, por lo que se comporta como grupo consonántico" $ do
        primeraSilaba "allanamiento" `shouldBe` "a"
      it "'ch' tiene un solo fonema, por lo que se comporta como grupo consonántico" $ do
        primeraSilaba "achatado" `shouldBe` "a"
      it "'sh' tiene un solo fonema, por lo que se comporta como grupo consonántico" $ do
        primeraSilaba "Mushu" `shouldBe` "Mu"
      it "la ü se comporta siempre como vocal débil" $ do
        enSilabas "paragüero" `shouldBe` ["pa", "ra", "güe", "ro"]
      
