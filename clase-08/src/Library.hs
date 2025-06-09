module Library where
import PdePreludat
import Data.Char (toUpper, isAlpha)
import Data.List (isPrefixOf, isSuffixOf, sortOn)

esVocal :: Char -> Bool
esVocal letra = toUpper letra `elem` "AEIOUÁÉÍÓÚÜ"

esVocalDebil :: Char -> Bool
esVocalDebil letra = toUpper letra `elem` "IUÜ"

esVocalFuerte :: Char -> Bool
esVocalFuerte letra = esVocal letra && not (esVocalDebil letra)

esConsonante :: Char -> Bool
esConsonante letra = not (esVocal letra)

esDiptongo :: Char -> Char -> Bool
esDiptongo unaLetra otraLetra = all esVocal [unaLetra, otraLetra] && any esVocalDebil [unaLetra, otraLetra]

esHiato :: Char -> Char -> Bool
esHiato unaLetra otraLetra = all esVocalFuerte [unaLetra, otraLetra]

primeraSilaba :: String -> String
primeraSilaba [l] = [l]
primeraSilaba (c:resto)           | esConsonante c                                  = c : primeraSilaba resto
primeraSilaba (v: cs)             | all esConsonante cs && esVocal v                = v : cs
primeraSilaba (v1:v2:resto)       | esHiato v1 v2                                   = [v1]
primeraSilaba (v1:v2:resto)       | esDiptongo v1 v2                                = v1 : primeraSilaba (v2 : resto)
primeraSilaba (v:c1:c2:resto)     | esGrupoConsonantico c1 c2 && esVocal v          = [v]
primeraSilaba (v:c1:c2:resto)     | all esConsonante [c1,c2] && esVocal v           = [v, c1]
primeraSilaba (v:c:resto)         | esVocal v && esConsonante c                     = [v]

eliminarPrefijo :: String -> String -> String
eliminarPrefijo prefijo palabra
    | prefijo `isPrefixOf` palabra = drop (length prefijo) palabra
    | otherwise = palabra

palabraEnSilabas :: String -> [String]
palabraEnSilabas "" = []
palabraEnSilabas palabra = primeraSilaba palabra : enSilabas (eliminarPrefijo (primeraSilaba palabra) palabra)

enSilabas :: String -> [String]
enSilabas = concatMap palabraEnSilabas . words

-- Punto 1
esGrupoConsonantico :: Char -> Char -> Bool
esGrupoConsonantico unaConsonante otraConsonante =
    [unaConsonante, otraConsonante] `elem` [
        "bl", "br", "cl", "cr", "dr", "fl", "fr", "gl", "pl", "pr", "tl", "tr", "rr", "ll", "ch", "sh"
    ]

-- Punto 2
data Criatura = Criatura {
    nombre :: String,
    tipo :: TipoCriatura,
    resistencia :: Number,
    fuerza :: Number,
    habilidad :: Habilidad
} deriving Show

data TipoCriatura = Aereo | Terrestre | Submarino deriving (Eq, Show)

type Habilidad = Criatura -> Criatura

lambidiniCalculini :: Criatura
lambidiniCalculini = Criatura "Lambdini Calculini" Terrestre 6 10 reduccionEta

reduccionEta :: Habilidad
reduccionEta = transformarFuerza (/2) . transformarResistencia (/2)

transformarFuerza :: (Number -> Number) -> Criatura -> Criatura
transformarFuerza cambio criatura = criatura { fuerza = cambio (fuerza criatura) }

aumentarFuerza :: Number -> Criatura -> Criatura
aumentarFuerza cantidad = transformarFuerza (+cantidad)

transformarResistencia :: (Number -> Number) -> Criatura -> Criatura
transformarResistencia cambio criatura = criatura { resistencia = cambio (resistencia criatura) }

aumentarResistencia :: Number -> Criatura -> Criatura
aumentarResistencia cantidad = transformarResistencia (+cantidad)

disminuirResistencia :: Number -> Criatura -> Criatura
disminuirResistencia cantidad = transformarResistencia (cantidad `subtract`)

pepitaObjetoObjetina :: Criatura
pepitaObjetoObjetina = Criatura "Pepita Objeto Objetina" Aereo 7 6 polimorfismo

polimorfismo :: Habilidad
polimorfismo criatura = cambiarTipoA (tipoSiguientePorPolimorfismo (tipo criatura)) criatura

cambiarTipoA :: TipoCriatura -> Criatura -> Criatura
cambiarTipoA nuevoTipo criatura = criatura { tipo = nuevoTipo }

tipoSiguientePorPolimorfismo :: TipoCriatura -> TipoCriatura
tipoSiguientePorPolimorfismo Aereo = Terrestre
tipoSiguientePorPolimorfismo Terrestre = Submarino
tipoSiguientePorPolimorfismo Submarino = Aereo

haskellinoCurrino :: Criatura
haskellinoCurrino = Criatura "Haskellino Currino" Submarino 10 3 lazyEvaluation

lazyEvaluation :: Habilidad
lazyEvaluation criatura = criatura { habilidad = id }

-- Punto 3
type Entrenamiento = Criatura -> Criatura

-- a
darAlas :: Entrenamiento
darAlas = cambiarTipoA Aereo

-- b
descansar :: Number -> Entrenamiento
descansar horas = transformarResistencia (+horas)

-- c
levantarMancuernas :: Number -> Entrenamiento
levantarMancuernas peso criatura
    | peso * 2 < resistencia criatura = aumentarFuerza peso criatura
    | otherwise = aumentarFuerza 1 . disminuirResistencia 1 $ criatura

-- d
obtenerHabilidad :: Habilidad -> Entrenamiento
obtenerHabilidad nuevaHabilidad criatura = criatura { habilidad = nuevaHabilidad . habilidad criatura }

-- e
type Combatientes = (Criatura, Criatura)

tirarseHabilidades :: Combatientes -> Combatientes
tirarseHabilidades (criatura, otraCriatura) = (habilidad otraCriatura criatura, habilidad criatura otraCriatura)

atacarse :: Combatientes -> Combatientes
atacarse (criatura, otraCriatura) = (criatura `recibirAtaqueDe` otraCriatura, otraCriatura `recibirAtaqueDe` criatura)

recibirAtaqueDe :: Criatura -> Criatura -> Criatura
recibirAtaqueDe defensor atacante = disminuirResistencia (fuerza atacante) defensor

resolverCombate :: Combatientes -> Criatura
resolverCombate (criaturaCombatida, criatura)
    | resistencia criatura > resistencia criaturaCombatida = obtenerHabilidad (habilidad criaturaCombatida) criatura
    | otherwise = criatura

combatir :: Criatura -> Entrenamiento
combatir criaturaACombatir criatura = resolverCombate . atacarse . tirarseHabilidades $ (criaturaACombatir, criatura)

-- Punto 4
-- a)
data Jurado = Jurado {
    criterioDeAprobacion :: Criatura -> Bool,
    puntuacion :: Criatura -> Number
}

ganadorDeConcurso :: Jurado -> [Criatura] -> Criatura
ganadorDeConcurso jurado = last . sortOn (puntuacion jurado) . filtrarPorCriterio jurado

filtrarPorCriterio :: Jurado -> [Criatura] -> [Criatura]
filtrarPorCriterio jurado criaturas
    | none (criterioDeAprobacion jurado) criaturas = criaturas
    | otherwise = filter (criterioDeAprobacion jurado) criaturas

none :: (a -> Bool) -> [a] -> Bool
none condition list = not . any condition $ list

--b)
esAerea :: Criatura -> Bool
esAerea criatura = tipo criatura == Aereo

juanino :: Jurado
juanino = Jurado {
    criterioDeAprobacion = \criatura -> resistencia criatura > 30 || esAerea criatura,
    puntuacion = \criatura -> fuerza criatura + bonusPorCriaturaAereaParaJuanino criatura
}

bonusPorCriaturaAereaParaJuanino :: Criatura -> Number
bonusPorCriaturaAereaParaJuanino criatura
    | esAerea criatura = 50
    | otherwise = 0

dantelero :: Jurado
dantelero = Jurado {
    criterioDeAprobacion = all (terminaConAlguno ["ero", "era", "ino", "ina"]) . words . nombre,
    puntuacion = (2*) . cantidadDeSilabas . nombre
}

eminini :: Jurado -> Jurado
eminini referencia = Jurado {
    criterioDeAprobacion = not . criterioDeAprobacion referencia,
    puntuacion = negate . puntuacion referencia
}

terminaConAlguno :: [String] -> String -> Bool
terminaConAlguno sufijos palabra = any (`isSuffixOf` palabra) sufijos

-- Punto 5
-- a)
dropEnd :: Number -> [a] -> [a]
dropEnd n = reverse . drop n . reverse

vocales :: [Char] -> [Char]
vocales = filter esVocal

cantidadDeSilabas :: String -> Number
cantidadDeSilabas = length . enSilabas

cantidadDeSilabasCumple :: (Number -> Bool) -> String -> Bool
cantidadDeSilabasCumple condicion palabra = condicion . cantidadDeSilabas $ palabra

reemplazarSi :: (a -> Bool) -> a -> a -> a
reemplazarSi condicion nuevo viejo
    | condicion viejo = nuevo
    | otherwise = viejo

aNombreDeCriatura :: String -> String
aNombreDeCriatura palabra
    | cantidadDeSilabasCumple (>=3) palabra && (all (=='o') . vocales . last . enSilabas $ palabra) =
        (++ "nino") . concat . dropEnd 2 . enSilabas $ palabra
    | cantidadDeSilabasCumple (==1) palabra =
        concat [palabra, "laler", [last . vocales $ palabra]]
    | cantidadDeSilabasCumple (==2) palabra =
        concat [
            head (enSilabas palabra),
            map (reemplazarSi esVocal 'i') (enSilabas palabra !! 1),
            "ni"
        ]
    | otherwise = palabra ++ "pedepe"

-- b)
fabricarCriatura :: [String] -> [Entrenamiento] -> Habilidad -> Jurado -> Criatura
fabricarCriatura palabras entrenamientos habilidad jurado =
    ganadorDeConcurso jurado
    . map (\criatura -> foldr ($) criatura entrenamientos)
    . map (\nombre -> Criatura {
        nombre = nombre,
        fuerza = length . filter esVocalFuerte $ nombre,
        resistencia = cantidadDeSilabas nombre,
        habilidad = habilidad,
        tipo = cycle [Submarino, Aereo, Terrestre] !! length nombre
    })
    . map (\(unaPalabra, otraPalabra) -> aNombreDeCriatura unaPalabra ++ " " ++ aNombreDeCriatura otraPalabra)
    . combinacionesConSiguientes
    $ palabras

combinacionesConSiguientes :: [String] -> [(String, String)]
combinacionesConSiguientes palabras = zip palabras (tail palabras)