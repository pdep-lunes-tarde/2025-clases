{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
module Library where
import PdePreludat

-- Ejercicio de ejemplo para ver usos de composición.

-- Tenemos una caja registradora de un negocio, sabemos que cajero la atiende y cuanto
-- dinero tiene la caja.

data CajaRegistradora = UnaCaja{
  cajero::String,
  dinero::Number
} deriving (Show, Eq)

-- Y una función cobrar, que aumenta el dinero de la caja.

cobrar :: Number -> CajaRegistradora -> CajaRegistradora
cobrar dineroACobrar (UnaCaja unCajero unDinero) = UnaCaja unCajero (unDinero+dineroACobrar)

-- Punto 1: cobrar dos veces a una persona por pagar en dos cuotas

cobrarDosCuotas :: Number -> CajaRegistradora -> CajaRegistradora
-- Usamos aplicación parcial para obtener una función de tipo
-- (CajaRegistradora -> CajaRegistradora) a partir de la función cobrar.
cobrarDosCuotas dineroPorCuota = cobrar dineroPorCuota . cobrar dineroPorCuota

-- Punto 2: saber si la longitud del nombre del cajero es par

nombreCajeroPar :: CajaRegistradora -> Bool
                    --  even (length (cajero caja)) <- así quedaria sin composición
nombreCajeroPar caja = (even . length . cajero) caja
                    -- even . length . cajero $ caja
                    -- ^ también se puede usar $ para no poner los paréntesis

caja1 :: CajaRegistradora
caja1 = UnaCaja "Tomi" 75
caja2 :: CajaRegistradora
caja2 = UnaCaja "JuanFds" 120
caja3 :: CajaRegistradora
caja3 = UnaCaja "Dante" 225
caja4 :: CajaRegistradora
caja4 = UnaCaja "Manu" 25
caja5 :: CajaRegistradora
caja5 = UnaCaja "Juani" 95

cajasDelSuper :: [CajaRegistradora]
cajasDelSuper = [caja1, caja2, caja3, caja4, caja5]

-- Punto 3: dada una lista de cajas del supermercado, queremos saber cuales tienen mas de 100
-- pesos disponibles

cajasConMasDeCienPesos :: [CajaRegistradora] -> [CajaRegistradora]
cajasConMasDeCienPesos cajas = filter ((> 100) . dinero) cajas

-- Punto 4: queremos saber si la sumatoria de la plata en cajas es superior a
-- cierto numero.
sumatoriaEnCajasMayorA :: Number -> [CajaRegistradora] -> Bool
sumatoriaEnCajasMayorA valorMinimo cajas = ((> valorMinimo) . sum . map dinero) cajas

-- Punto 5: Por ultimo, queremos quedarnos con la primer letra del nombre
-- del cajero que tiene el nombre mas largo

primeraLetraDeCajeroConNombreMasLargo :: [CajaRegistradora] -> Char
primeraLetraDeCajeroConNombreMasLargo cajas =
  (head . maximoSegun length . map cajero) cajas

maximoSegun :: Ord b => (a -> b) -> [a] -> a
maximoSegun funcion lista = foldl1 (mayorSegun funcion) lista

mayorSegun :: Ord b => (a->b) -> a -> a -> a
mayorSegun funcion valor1 valor2
    | funcion valor1 > funcion valor2 = valor1
    | otherwise = valor2
