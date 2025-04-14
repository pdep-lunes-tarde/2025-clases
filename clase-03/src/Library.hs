module Library where

import PdePreludat


-- Refactorizar esta función:
esPositivo :: Number -> Bool
-- esPositivo numero
--    | numero > 0 = True
--    | otherwise = False
esPositivo numero = numero > 0

haceFrioCelsius :: Number -> Bool
haceFrioCelsius grados = grados <= 8
                                                                                
--     /\      |
--    /**\     |
--   /****\    | 2 kg/cm
--  /******\   | 
-- ----------  ┼  3 m
-- /********\  |
--     ||      | 3 kg/cm
--     ||      | 

alturaDeCorte :: Number
alturaDeCorte = 4

metrosACentimetros :: Number -> Number
metrosACentimetros metros = metros * 100

calcularPeso :: Number -> Number -> Number
calcularPeso alturaEnMetros
             kilosPorCentimetro =
               metrosACentimetros alturaEnMetros * kilosPorCentimetro

pesoPinoEnKilos :: Number -> Number
pesoPinoEnKilos alturaPino
   | alturaPino < 0 = error "La altura del pino deberia ser positiva"
   | alturaPino > alturaDeCorte =
         calcularPeso (alturaPino-alturaDeCorte) 2 + pesoPinoEnKilos alturaDeCorte
   | otherwise =
      calcularPeso alturaPino 3

pesoPinoEnKilos' :: Number -> Number
pesoPinoEnKilos' alturaPino
   | alturaPino < 0 = error "La altura del pino deberia ser positiva"
   | otherwise =
      pesoPorEncimaDe alturaPino alturaDeCorte +
      pesoPorDebajoDe alturaPino alturaDeCorte

pesoPorDebajoDe :: Number -> Number -> Number
pesoPorDebajoDe alturaPino alturaDeCorte =
   metrosACentimetros (min alturaPino alturaDeCorte) * 3

pesoPorEncimaDe :: Number -> Number -> Number
pesoPorEncimaDe alturaPino alturaDeCorte =
   metrosACentimetros (max 0 (alturaPino - alturaDeCorte)) * 2
-- 2 guardas + 2 funciones auxiliares:
 -- una para calcular peso por debajo de la altura de corte
 -- otra para calcular peso por arriba de la altura de corte

-- ¿Qué pasa si ahora cambia el requerimiento a?:
--     /\      |
--    /**\     |
--   /****\    | 2 kg/cm
-- ----------  ┼  4 m
--  /******\   | 
-- /********\  |
--     ||      | 3 kg/cm
--     ||      |
pesoPino' :: Number -> Number
pesoPino' alturaPino = implementame









-- pesoPino :: Number -> Number
-- pesoPino alturaPino =
--    pesoParteInferior alturaPino + pesoParteSuperior alturaPino

-- type Carta = (Number, String)


color :: Carta -> Color
-- seria así si type Carta = (Number, String):
      -- color carta = snd carta
      -- Pattern matching:
      -- color (unNumero, unColor) = unColor
color (UnaCarta unColor unTipo) = unColor

numero :: Carta -> Number
numero (UnaCarta unColor (CartaNormal unNumero)) = unNumero
numero (UnaCarta unColor Mas4) = error "El mas 4 no tiene número"

mismoColor :: Carta -> Carta -> Bool
mismoColor unaCarta otraCarta =
   color unaCarta == color otraCarta

mismoNumero :: Carta -> Carta -> Bool
mismoNumero (UnaCarta _ Mas4) _ = False
mismoNumero _ (UnaCarta _ Mas4) = False
mismoNumero unaCarta otraCarta =
   numero unaCarta == numero otraCarta

sePuedeJugarEncimaDe :: Carta -> Carta -> Bool
sePuedeJugarEncimaDe _ (UnaCarta _ Mas4) = True
sePuedeJugarEncimaDe carta cartaAJugar =
   mismoColor carta cartaAJugar ||
   mismoNumero carta cartaAJugar

-- type Jugador = (Number, String)
-- juani = (3, "Juani")

juani :: Jugador
juani = UnJugador 3 "Juani"

data Jugador =
   UnJugador Number String deriving (Eq, Show)
data Carta =
   UnaCarta Color TipoDeCarta deriving (Eq, Show)
data TipoDeCarta =
   Mas4 | CartaNormal Number
   deriving (Eq, Show)
-- sieteAzul = UnaCarta Azul (CartaNormal 7)

data Color =
   Azul |
   Rojo |
   Verde |
   Amarillo deriving (Eq, Show)

-- Agregamos el +4
