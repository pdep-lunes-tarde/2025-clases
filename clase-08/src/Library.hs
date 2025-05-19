module Library where
import PdePreludat
import Data.Char (toUpper, isAlpha)
import Data.List (isPrefixOf)


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
esGrupoConsonantico unaConsonante otraConsonante
    | unaConsonante == 'b' && otraConsonante == 'l' = True
    | unaConsonante == 'b' && otraConsonante == 'r' = True
    | unaConsonante == 'c' && otraConsonante == 'l' = True
    | unaConsonante == 'c' && otraConsonante == 'r' = True
    | unaConsonante == 'd' && otraConsonante == 'r' = True
    | unaConsonante == 'f' && otraConsonante == 'l' = True
    | unaConsonante == 'f' && otraConsonante == 'r' = True
    | unaConsonante == 'g' && otraConsonante == 'l' = True
    | unaConsonante == 'p' && otraConsonante == 'l' = True
    | unaConsonante == 'p' && otraConsonante == 'r' = True
    | unaConsonante == 't' && otraConsonante == 'l' = True
    | unaConsonante == 't' && otraConsonante == 'r' = True
    | unaConsonante == 'r' && otraConsonante == 'r' = True
    | unaConsonante == 'l' && otraConsonante == 'l' = True
    | unaConsonante == 'c' && otraConsonante == 'h' = True
    | unaConsonante == 's' && otraConsonante == 'h' = True
    | otherwise = False

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

