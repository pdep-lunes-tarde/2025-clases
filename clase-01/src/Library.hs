module Library where
import PdePreludat

esPar :: Number  -> Bool
esPar unNumero = mod unNumero 2 == 0

-- Ejercicio: año bisiesto

-- Un año es bisiesto si es divisible por 400
-- o si es divisible por 4 pero no por 100.

bisiesto :: Number -> Bool
bisiesto anio =
    divisiblePor anio 400 ||
    (divisiblePor anio 4 &&
        not (divisiblePor anio 100))

divisiblePor :: Number -> Number -> Bool
divisiblePor dividendo divisor =
    mod dividendo divisor == 0

cuantosPares :: [Number] -> Number
cuantosPares = count even

count :: (a -> Bool) -> [a] -> Number
count condicion = length . filter condicion 

-- Declaratividad y expresividad

-- int f(int a[], int b) {
--   int i, j = 0;

--   for (i=0; i < b; i++) {
--     if(a[i] % 2 == 0){
--       j = j + 1;
--     }
--   }

--   return j;
-- }
