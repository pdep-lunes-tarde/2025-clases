module Library where
import PdePreludat
import Data.Char (toUpper)
import Data.List (stripPrefix)


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

esGrupoConsonantico :: Char -> Char -> Bool
esGrupoConsonantico unaConsonante otraConsonante = [unaConsonante, otraConsonante] `elem` [
        "bl", "br", "cl", "cr", "dr", "fl", "fr", "gl", "gr", "pl", "pr", "tl", "tr", "rr", "ll", "ch", "sh"
    ]

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
eliminarPrefijo [] palabra = palabra
eliminarPrefijo (primeraLetraPrefijo:restoPrefijo) (primeraLetraPalabra:restoPalabra)
    | primeraLetraPrefijo /= primeraLetraPalabra = primeraLetraPalabra:restoPalabra
    | otherwise = eliminarPrefijo restoPrefijo restoPalabra

enSilabas :: String -> [String]
enSilabas "" = []
enSilabas palabra = primeraSilaba palabra : enSilabas (eliminarPrefijo (primeraSilaba palabra) palabra)

