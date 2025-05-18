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


-- calculo lambda
aHaskell = \b -> b True False

verdadero = \x -> \y -> x
            -- λx . λy . x

falso = \x -> \y -> y

no = \b -> b falso verdadero

o = \b1 -> \b2 ->
    b1 verdadero b2

sumar :: Number -> Number -> Number
sumar x y = x + y
sumar' :: Number -> Number -> Number
sumar' x = \y -> x + y
sumar'' :: Number -> Number -> Number
sumar'' = \x -> \y -> x + y 
-- \x -> x + 2

-- no = \b -> b verdadero falso

-- -- y true false = false
-- -- y false false = false
-- -- y false true = false
-- -- y true true = true

-- y = \b1 -> \b2 -> b1 b2 falso

-- -- o true false = true
-- -- o false false = false
-- -- o false true = false
-- -- o true true = true

-- o = \b1 -> \b2 -> b1 verdadero b2 verdadero falso

-- si = \b -> b

-- -- true == false = false
-- -- true == true = true
-- -- false == true = false
-- -- false == false = true


-- sonIguales = \b1 -> \b2 -> b1 b2 (no b2) verdadero falso


-- sonDistintos = \b1 -> \b2 -> no (sonIguales b1 b2)


-- esVerdadero = \b1 -> sonIguales b1 verdadero


-- esFalso = \b1 -> sonIguales b1 falso

-- -- true > false = true
-- -- false > true = false
-- -- true > true = false
-- -- false > false = false

-- (.>) = \b1 -> \b2 -> esVerdadero b1 `y` esFalso b2

-- (.<) = \b1 -> \b2 -> esFalso b1 `y` esVerdadero b2

-- aHaskell = \b -> b True False
