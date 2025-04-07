module Library (module Library, isPrefixOf, isSuffixOf) where

import PdePreludat
import Data.List (isPrefixOf, isSuffixOf)

celsiusAFahrenheit :: Number -> Number
celsiusAFahrenheit temperaturaEnCelsius =
    temperaturaEnCelsius * 1.8 + 32

fahrenheitACelsius :: Number -> Number
fahrenheitACelsius temperaturaEnFahrenheit =
    (temperaturaEnFahrenheit - 32) / 1.8

haceFrioCelsius :: Number -> Bool
haceFrioCelsius temperaturaEnCelsius =
    temperaturaEnCelsius <= 8

-- even 5 == odd 6

-- haceFrioFahrenheit :: Number -> Bool
-- haceFrioFahrenheit temperaturaEnFahrenheit =
--     temperaturaEnFahrenheit <= celsiusAFahrenheit 8

haceFrioFahrenheit' :: Number -> Bool
haceFrioFahrenheit' temperaturaEnFahrenheit =
    haceFrioCelsius (fahrenheitACelsius temperaturaEnFahrenheit)

-- haceFrioFahrenheit'' :: Number -> Bool
-- haceFrioFahrenheit'' temperaturaEnFahrenheit =
--     fahrenheitACelsius temperaturaEnFahrenheit <= 8


-- preguntar :: String -> String
-- preguntar oracion
--     | isPrefixOf "¿" oracion && isSuffixOf "?" oracion = oracion
--     | "¿" `isPrefixOf` oracion = oracion ++ "?"
--     | "?" `isSuffixOf` oracion = "¿" ++ oracion
--     | otherwise = "¿" ++ oracion ++ "?"

preguntar :: String -> String
preguntar oracion =
    agregarSiFaltaAlFinal "?" 
        (agregarSiFaltaAlPrincipio "¿" oracion)

agregarSiFaltaAlPrincipio :: String -> String -> String
agregarSiFaltaAlPrincipio prefijo oracion
    | prefijo `isPrefixOf` oracion = oracion
    | otherwise = prefijo ++ oracion

agregarSiFaltaAlFinal :: String -> String -> String
agregarSiFaltaAlFinal sufijo oracion
    | sufijo `isSuffixOf` oracion = oracion
    | otherwise = oracion ++ sufijo

-- isPrefixOf nos dice si un string empieza con otro string
-- isSuffixOf nos dice si un string termina con otro string
-- ++

-- >>> isSuffixOf "ojos" "anteojos"
-- True
--
-- >>> isPrefixOf "ante" "anteojos"
-- True
--
-- >>> "hola " ++ "mundo"
-- "hola mundo"

-- Queremos que funcione así:
-- >>> preguntar "hola"
-- "¿hola?"-- >>> preguntar "hola?"
-- "¿hola?"
