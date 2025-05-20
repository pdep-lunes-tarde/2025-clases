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
      it "la primera silaba de una palabra CVC es la misma palabra" $ do
        primeraSilaba "tan" `shouldBe` "tan"
      it "la primera silaba de una palabra VCV es la primera letra" $ do
        primeraSilaba "oro" `shouldBe` "o"
      it "la primera silaba de una palabra vCV es la primera letra" $ do
        primeraSilaba "uva" `shouldBe` "u"
      it "la primera silaba de una palabra que comienza en VVCV es solo la primera letra porque hay hiato" $ do
        primeraSilaba "aéreo" `shouldBe` "a"
      it "la primera silaba de una palabra CVVC son las primeras 2 letras porque hay hiato" $ do
        primeraSilaba "baúl" `shouldBe` "ba"
      it "la primera silaba de una palabra CVCV son las primeras 2 letras" $ do
        primeraSilaba "gato" `shouldBe` "ga"
      it "la primera silaba de una palabra VCCV son las primeras 2 letras" $ do
        primeraSilaba "arco" `shouldBe` "ar"
      it "la primera silaba de una palabra CvVC es la misma palabra porque hay diptongo" $ do
        primeraSilaba "cual" `shouldBe` "cual"
      it "la primera silaba de una palabra CCVCC es la misma palabra" $ do
        primeraSilaba "trans" `shouldBe` "trans"
      it "la primera silaba de una palabra CCVCV son las primeras 3 letras" $ do
        primeraSilaba "plato" `shouldBe` "pla"
      it "la primera silaba de una palabra CVCCV son las primeras 3 letras" $ do
        primeraSilaba "carta" `shouldBe` "car"
      it "la primera silaba de una palabra CvVCV son las primeras 3 letras porque hay diptongo" $ do
        primeraSilaba "hueso" `shouldBe` "hue"
      it "la primera silaba de una palabra CVvCVC son las primeras 3 letras porque hay diptongo" $ do
        primeraSilaba "caimán" `shouldBe` "cai"
      it "la primera silaba de una palabra CVvCCV son las primeras 4 letras" $ do
        primeraSilaba "cuenta" `shouldBe` "cuen"
      it "la primera silaba de una palabra VCCVC si CC es un grupo consonantico es solo la primera letra" $ do
        primeraSilaba "atrás" `shouldBe` "a"
      it "la primera silaba de una palabra CVCCV si CC es un grupo consonantico es solo las primera 2 letras" $ do
        primeraSilaba "catre" `shouldBe` "ca"
      it "la primera silaba de una palabra CvVCCV si CC es un grupo consonantico son solo las primeras 3 letras" $ do
        primeraSilaba "guerra" `shouldBe` "gue"
      it "'ll' tiene un solo fonema, por lo que se comporta como grupo consonántico" $ do
        primeraSilaba "allanamiento" `shouldBe` "a"
      it "'ch' tiene un solo fonema, por lo que se comporta como grupo consonántico" $ do
        primeraSilaba "achatado" `shouldBe` "a"
      it "'sh' tiene un solo fonema, por lo que se comporta como grupo consonántico" $ do
        primeraSilaba "Mushu" `shouldBe` "Mu"
  describe "enSilabas" $ do
    it "una palabra separada en silabas devuelve una lista con cada una de las silabas de la palabra" $ do
      enSilabas "aeroplano" `shouldBe` ["a", "e", "ro", "pla", "no"]
    it "la ü se comporta siempre como vocal débil" $ do
        enSilabas "paragüero" `shouldBe` ["pa", "ra", "güe", "ro"]
    it "un caracter que no es una letra nunca forma parte de una silaba" $ do
        enSilabas "El bonsái es pequeño" `shouldBe` ["El", "bon", "sái", "es", "pe", "que", "ño"]
  describe "entrenamientos" $ do
    describe "dar alas" $ do
      it "dada una criatura de tipo aereo queda igual" $ do
        darAlas pepitaObjetoObjetina `shouldBeCriatura` pepitaObjetoObjetina
      it "dada una criatura cambia su tipo a aereo" $ do
        darAlas haskellinoCurrino `shouldBeCriatura` haskellinoCurrino { tipo = Aereo }
    describe "descansar" $ do
      it "aumenta la resistencia de una criatura en la cantidad de horas dormidas" $ do
        descansar 5 haskellinoCurrino `shouldBeCriatura` haskellinoCurrino { resistencia = 15 }
    describe "levantarMancuernas" $ do
      it "si la resistencia de la criatura es al menos el doble que el peso de las mancuernas, aumenta la fuerza de la criatura en ese peso" $ do
        levantarMancuernas 4 haskellinoCurrino `shouldBeCriatura` haskellinoCurrino { fuerza = 7 }
      it "si la resistencia de la criatura es menos que el doble del peso de las mancuernas, aumenta fuerza en 1 y pierde resistencia en 1" $ do
        levantarMancuernas 8 haskellinoCurrino `shouldBeCriatura` haskellinoCurrino { fuerza = 4, resistencia = 9 }
    describe "obtenerHabilidad" $ do
      it "agrega una nueva habilidad a una criatura" $ do
        let pepita = obtenerHabilidad (aumentarFuerza 1) pepitaObjetoObjetina
        habilidad pepita haskellinoCurrino `shouldBeCriatura` haskellinoCurrino { tipo = Aereo, fuerza = 4 }
    describe "combatir otra criatura" $ do
      it "queda la criatura resultante luego de recibir la habilidad y ataque del oponente" $ do
        combatir lambidiniCalculini haskellinoCurrino `shouldBeCriatura` haskellinoCurrino { resistencia = -5, fuerza = 1.5 }
      it "si la criatura resultante tiene mas resistencia que su oponente, obtiene su habilidad" $ do
        let nuevoLambidiniCalculini = combatir pepitaObjetoObjetina lambidiniCalculini
        -- cambia su tipo y disminuye fuerza y resistencia a la mitad
        habilidad nuevoLambidiniCalculini haskellinoCurrino `shouldBeCriatura` haskellinoCurrino { tipo = Aereo, resistencia = 5, fuerza = 1.5 }
    describe "quien gana" $ do
      it "si solo una criatura pasa el filtro, esa es la que gana" $ do
         let juradoSoloAereos = Jurado esAerea fuerza
         ganadorDeConcurso juradoSoloAereos [lambidiniCalculini, pepitaObjetoObjetina, haskellinoCurrino] `shouldBeCriatura` pepitaObjetoObjetina
      it "si ninguno pasa el filtro, es de todas la que mejor puntua segun el criterio" $ do
         let juradoImposible = Jurado (\criatura -> False) fuerza
         ganadorDeConcurso juradoImposible [lambidiniCalculini, pepitaObjetoObjetina, haskellinoCurrino] `shouldBeCriatura` lambidiniCalculini
      it "si algunos pasan el filtro, es de aquellos el que mejor puntua" $ do
         let jurado = Jurado (\criatura -> fuerza criatura < 10) fuerza
         ganadorDeConcurso jurado [lambidiniCalculini, pepitaObjetoObjetina, haskellinoCurrino] `shouldBeCriatura` pepitaObjetoObjetina
    describe "fabrica de criaturas" $ do
      describe "creando nombres de criaturas" $ do
        it "Si es una palabra de al menos 3 silabas, y la unica vocal en la silaba final es la o, se reemplazan las últimas 2 silabas por nino" $ do
          aNombreDeCriatura "domingo" `shouldBe` "donino"
        it "Si una palabra tiene solo una sílaba, se le agrega -lalerX al final, donde X es la ultima vocal que se encuentre en la silaba" $ do
          aNombreDeCriatura "tra" `shouldBe` "tralalera"
        it "Si la palabra tiene 2 silabas, se reemplazan todas las vocales de la segunda silaba por i y se agrega una ultima silaba 'ni' al final" $ do
          aNombreDeCriatura "taza" `shouldBe` "tazini"
        it "Si una palabra tiene al menos 3 silabas pero no tiene O como unica vocal en su ultima silaba, se agrega pedepe al final de la palabra" $ do
          aNombreDeCriatura "lunesde" `shouldBe` "lunesdepedepe"
      describe "Creando criaturas" $ do
        context "cuando hay una sola criatura posible" $ do
          let juradoQueApruebaSiempre = Jurado (\_ -> True) fuerza
              habilidadNula = id
              carninoTazini = fabricarCriatura ["carpincho", "taza"] [] habilidadNula juradoQueApruebaSiempre
          it "el nombre de la criatura se forma convirtiendo a nombre de criaturas los nombres dados" $ do
            nombre carninoTazini `shouldBe` "carnino tazini"
          it "la fuerza inicial de la criatura es la cantidad de vocales fuertes en el nombre" $ do
            fuerza carninoTazini `shouldBe` 3
          it "la resistencia inicial de la criatura es la cantidad de silabas en el nombre" $ do
            resistencia carninoTazini `shouldBe` 6
          it "la habilidad de la criatura es la pasada al fabricar" $ do
            -- en este caso es la habilidad nula, deja a quien se pasa por parametro igual
            habilidad carninoTazini pepitaObjetoObjetina `shouldBeCriatura` pepitaObjetoObjetina
          it "si la cantidad de letras del nombre modulo 3 es 0, tiene tipo submarino" $ do
              let tralaleraPalalera = fabricarCriatura ["tra", "pa"] [] habilidadNula juradoQueApruebaSiempre
              nombre tralaleraPalalera `shouldBe` "tralalera palalera"
              tipo tralaleraPalalera `shouldBe` Submarino
          it "si la cantidad de letras del nombre modulo 3 es 1, tiene tipo aereo" $ do
              let tralaleraPallalera = fabricarCriatura ["tra", "pal"] [] habilidadNula juradoQueApruebaSiempre
              nombre tralaleraPallalera `shouldBe` "tralalera pallalera"
              tipo tralaleraPallalera `shouldBe` Aereo
          it "si la cantidad de letras del nombre modulo 3 es 2, tiene tipo terrestre" $ do
              let trallaleraPallalera = fabricarCriatura ["tral", "pal"] [] habilidadNula juradoQueApruebaSiempre
              nombre trallaleraPallalera `shouldBe` "trallalera pallalera"
              tipo trallaleraPallalera `shouldBe` Terrestre
          it "si se pasan entrenamientos, se realizan esos entrenamientos a la criatura creada" $ do
            let trallaleraPallalera = fabricarCriatura ["tral", "pal"] [] habilidadNula juradoQueApruebaSiempre
                trallaleraPallaleraConEntrenamiento = fabricarCriatura ["tral", "pal"] [darAlas, descansar 5] habilidadNula juradoQueApruebaSiempre

            trallaleraPallaleraConEntrenamiento `shouldBeCriatura`
                trallaleraPallalera { resistencia = 13, tipo = Aereo }

        context "cuando se pueden crear varias criaturas" $ do
          it "se elige de entre ellas la que de gane el concurso segun el jurado" $ do
            let jurado = Jurado ((>5) . cantidadDeSilabas . nombre) (length . nombre)
            fabricarCriatura ["carpincho", "taza", "pala", "carnotauro"] [] id jurado
            `shouldBeCriatura` Criatura {
              nombre = "palini carnonino",
              resistencia = 7,
              fuerza = 4,
              habilidad = id,
              tipo = Aereo
            }

shouldBeCriatura :: Criatura -> Criatura -> Expectation
shouldBeCriatura unaCriatura otraCriatura =
  (nombre unaCriatura, tipo unaCriatura, resistencia unaCriatura, fuerza unaCriatura)
  `shouldBe`
  (nombre otraCriatura, tipo otraCriatura, resistencia otraCriatura, fuerza otraCriatura)
