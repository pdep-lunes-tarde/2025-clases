{-# LANGUAGE BangPatterns #-}
module Library where
import PdePreludat
import Debug.Trace (traceShowId)

andEager :: Bool -> Bool -> Bool
andEager !x !y = x && y

andLazy :: Bool -> Bool -> Bool
andLazy x y = x && y

-- listas!

unos :: [Number]
unos = 1 : unos

-- unos
-- 1 : unos
-- 1 : 1 : unos
-- 1 : 1 : 1 : unos

naturales :: [Number]
naturales = 1 : map (+1) naturales
--          1 : map (+1) (1 : map (+1) naturales)
--          1 : (1 + 1) : map (+1) (map (+1) naturales)
--          1 : 2 : map (+1) (map (+1) naturales)

losNaturalesPares :: [Number]
losNaturalesPares = filter even naturales

losNaturalesPares' :: [Number]
losNaturalesPares' = map (*2) naturales

losNaturalesMenoresA5 :: [Number]
losNaturalesMenoresA5 = filter (\x -> traceShowId x < 5) naturales

hayAlgunNaturalMenorA0 :: Bool
hayAlgunNaturalMenorA0 = any (<0) naturales

hayAlgunMayorA1 :: Bool
hayAlgunMayorA1 = any (>1) naturales

sonTodosMayoresA2 :: Bool
sonTodosMayoresA2 = all (>2) naturales

sumatoria :: [Number] -> Number
sumatoria = foldr (+) 0

-- no termina :(
sumatoriaDeTodosLosN :: Number
sumatoriaDeTodosLosN = sumatoria naturales

serieDeFactoriales :: [Number]
-- serieDeFactoriales = 1 :
--   (1 * serieDeFactoriales !! 0) :
--   (2 * serieDeFactoriales !! 1) :
--   (3 * serieDeFactoriales !! 2) :
--   (4 * serieDeFactoriales !! 3) : []
serieDeFactoriales = 1 :
  zipWith (*) [1..] serieDeFactoriales
-- [1..] es equivalente a naturales


data Persona = Persona
  { nombre :: String
  , padres :: [Persona]
  } deriving Show
mildred :: Persona
mildred = Persona "Mildred Fry" []
sherri :: Persona
sherri = Persona "Sherri Fry" []
fry :: Persona
fry = Persona "Philip J Fry" [sherri, yancy]
yancy :: Persona
yancy = Persona "Yancy Fry" [mildred, fry]