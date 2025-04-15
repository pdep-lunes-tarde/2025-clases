module Library where

import PdePreludat

-- COMIENZO REPASO CLASE 2 --

-- Nota: a lo largo del código, se van a escribir funciones
-- con el mismo nombre, pero con ' al final. Los ' son
-- carácteres validos en haskell para nombres de constantes,
-- por lo que:
f x = x + x
-- y
f' x = x * 2
-- son 2 funciones diferentes.
-- Esto va a estar escrito así para hacer varias versiones de
-- una misma función sin tener que ponerle un nombre muy diferente
-- cada vez ni tener que comentarlas. 

-- Repaso de la clase pasada, errores comunes de tps anteriores:
-- "Miedo al booleano"
-- https://wiki.uqbar.org/wiki/articles/manejo-de-booleanos-en-haskell.html
esPositivo' :: Number -> Bool
esPositivo' numero
   | numero > 0 = True
   | otherwise = False

-- En esa implementación de la función, queremos retornar un
-- valor de tipo Bool. ¡Y funciona!
-- Pero... si miramos bien lo que hay en la guarda:
-- numero > 0
-- eso ya es un Bool, y cuando es verdadero devolvemos True,
-- y cuando es falso devolvemos False, entonces, en vez
-- de tener esa guarda, podemos escribir la función directamente
-- como:
esPositivo :: Number -> Bool
esPositivo numero = numero > 0
-- Corolario: si estamos usando guardas en una función cuyoo
-- retorno es un Bool, ¡es posible que esas guardas no sean
-- necesarias!

-- Numeros mágicos
-- https://en.wikipedia.org/wiki/Magic_number_(programming) (primera acepción)
-- Un valor con un significado no explicado que podría
-- (preferiblemente) reemplazarse con una constante nombrada.
--
--     /\      |
--    /**\     |
--   /****\    | 2 kg/cm
--  /******\   | 
-- ----------  ┼  3 m
-- /********\  |
--     ||      | 3 kg/cm
--     ||      | 
--
-- En una plantación de pinos, de cada árbol se conoce la
-- altura expresada en metros. El peso de un pino se puede
-- calcular a partir de la altura así:
-- 3 kg por cada centímetro hasta 3 metros,
-- 2 kg por cada centímetro arriba de los 3 metros
-- Definir pesoPino, que recibe la altura de un pino en metros y
-- devuelve su peso.
-- 
-- Solución original:
-- 
pesoPino :: Number -> Number
pesoPino alturaPino
   | alturaPino > 3 = (alturaPino-3) * 100 * 2 + 900
   | alturaPino <= 3 = alturaPino * 100 * 3
-- 
-- Eso funciona pero tiene algunos problemas, por ejemplo,
-- que pasa si el requerimiento cambiase, y la altura "de corte"
-- según la cuál cambia el peso del pino pasa de ser 3 a ser 4,
-- es decir, el peso se calcula así:
--     /\      |
--    /**\     |
--   /****\    | 2 kg/cm
-- ----------  ┼  4 m
--  /******\   | 
-- /********\  |
--     ||      | 3 kg/cm
--     ||      |
-- 
-- Una cosa que podríamos pensar, es reemplazar todos los 3 por 4:
pesoPino' :: Number -> Number
pesoPino' alturaPino
   | alturaPino > 4 = (alturaPino-4) * 100 * 2 + 900
   | alturaPino <= 4 = alturaPino * 100 * 4
-- ¡Ah!, y el 900 también, porque venía de hacer 3 * 100 * 3:
pesoPino'' :: Number -> Number
pesoPino'' alturaPino
   | alturaPino > 4 = (alturaPino-4) * 100 * 2 + 1200
   | alturaPino <= 4 = alturaPino * 100 * 4
-- Si esa es la solución a la que llegamos.. está mal.
-- Uno de los 3 que reemplazamos por 4, no representaba la altura
-- de corte, si no que representaba cuantos kg por cm pesa un pino.
-- Lo que habría que haber hecho es:
pesoPino''' :: Number -> Number
pesoPino''' alturaPino
   | alturaPino > 4 = (alturaPino-4) * 100 * 2 + 1200
   | alturaPino <= 4 = alturaPino * 100 * 3
-- 
-- Pero, ¿podríamos escribir el código de otra manera para
-- que sea más difícil cometer este error?, veamos:
-- El problema surge porque se repite muchas veces un valor
-- sin que esté explicado que hace eso en el código.
--
-- Nosotros al momento de escribir la función original lo
-- tenemos en mente, pero una vez que pase tiempo o que otra
-- persona lea nuestro código, no va a tener ese contexto, y
-- esa información que está _implícita_ lo vuelve propenso
-- a errores.
--
-- Una primera cosa que podríamos hacer, es extraer el valor a
-- una constante:
alturaDeCorte :: Number
alturaDeCorte = 4
--
pesoPino'''' :: Number -> Number
pesoPino'''' alturaPino
   | alturaPino > alturaDeCorte =
      (alturaPino-alturaDeCorte) * 100 * 2 + 100 * 3 * alturaDeCorte
   | alturaPino <= alturaDeCorte = alturaPino * 100 * 3
-- De esta manera, si la altura de corte en el futuro cambia
-- a otro valor, solo deberíamos cambiar eso en UN lugar.
--
-- Otras mejoras que podríamos hacer, son:
-- Agregar una función que nos pase de metros a centimetros:
metrosACentimetros :: Number -> Number
metrosACentimetros metros = metros * 100
--
-- Agregar una función que dada una altura (en m) y
-- un peso por centimetro (kg x cm), nos calcule el peso
-- de un segmento del pino:
calcularPeso :: Number -> Number -> Number
calcularPeso alturaEnMetros
             kilosPorCentimetro =
               metrosACentimetros alturaEnMetros * kilosPorCentimetro

-- Usando eso, podemos reescribir pesoPino sin el problema
-- que existía previamente, y de manera un poco más
-- declarativa:
pesoPino''''' :: Number -> Number
pesoPino''''' alturaPino
   | alturaPino > alturaDeCorte =
      calcularPeso (alturaPino-alturaDeCorte) 2 + calcularPeso alturaDeCorte 3
   | otherwise =
      calcularPeso alturaPino 3

-- ¡Pero podemos ir un poco más lejos!, primero, una sugerencia
-- que salió en clase fue renombrar la función para que nos
-- de a entender la unidad de medida del peso:
pesoPinoEnKilos :: Number -> Number
pesoPinoEnKilos alturaPino
   | alturaPino > alturaDeCorte =
      calcularPeso (alturaPino-alturaDeCorte) 2 + calcularPeso alturaDeCorte 3
   | otherwise =
      calcularPeso alturaPino 3
-- Otra sugerencia, fue modificar la función para que ante
-- pinos inválidos, es decir, con altura negativa, falle con
-- un error:
pesoPinoEnKilos' :: Number -> Number
pesoPinoEnKilos' alturaPino
   | alturaPino < 0 = error "La altura del pino deberia ser positiva"
   | alturaPino > alturaDeCorte =
      calcularPeso (alturaPino-alturaDeCorte) 2 + calcularPeso alturaDeCorte 3
   | otherwise =
      calcularPeso alturaPino 3

-- Luego, en esa función se sigue repitiendo 2 veces la lógica
-- que calcula el peso por DEBAJO de la altura de corte, estamos
-- calculando eso en:
-- calcularPeso (alturaPino-alturaDeCorte) 2 + >>> calcularPeso alturaDeCorte 3 <<<
-- y en:                                                           ^
-- | otherwise =                                                   |
--    >>> calcularPeso alturaPino 3 <<<                            |
--                                                                 |
-- Sabemos que si pasamos como parámetro algo <= a alturaDeCorte,  |
-- se va a usar la guarda del otherwise, y si vemos acá -----------|
-- justamente estamos pasando por parámetro alturaDeCorte, que es == a alturaDeCorte,
-- entonces, podríamos reescribir esa función así:
pesoPinoEnKilos'' :: Number -> Number
pesoPinoEnKilos'' alturaPino
   | alturaPino < 0 = error "La altura del pino deberia ser positiva"
   | alturaPino > alturaDeCorte =
      calcularPeso (alturaPino-alturaDeCorte) 2 + pesoPinoEnKilos'' alturaDeCorte
   | otherwise =
      calcularPeso alturaPino 3
-- Con esa solución, ya solucionamos toda la repetición de 
-- lógica que teníamos.
--
-- Aun así, podríamos seguir trabajando en mejorar la declaratividad
-- de la función. Podemos partir el problema en 2 problemas más
-- chicos y decir que:
-- el peso del pino en kilos es igual a:
-- el peso por DEBAJO de la altura de corte +
-- el peso por ENCIMA de la altura de corte
-- de esta manera:
pesoPinoEnKilos'''' :: Number -> Number
pesoPinoEnKilos'''' alturaPino
   | alturaPino < 0 = error "La altura del pino deberia ser positiva"
   | otherwise =
      pesoPorEncimaDe alturaPino alturaDeCorte +
      pesoPorDebajoDe alturaPino alturaDeCorte
-- Y nos queda pendiente implementar esas 2 funciones auxiliares:
-- Para pesoPorDebajoDe, necesitamos calcular, dada la altura de
-- un pino, cuantos metros de altura quedan por debajo de
-- alturaDeCorte.
-- - Si el pino es más alto que alturaDeCorte,
-- la altura que vamos a tomar para calcular el peso es
-- exactamente alturaDeCorte.
-- - Si el pino es más bajo que alturaDeCorte,
-- entonces tenemos que usar la altura del pino, porque todo
-- el pino está por debajo de alturaDeCorte.
-- Esto lo podemos resolver usando la función `min`:
pesoPorDebajoDe :: Number -> Number -> Number
pesoPorDebajoDe alturaPino alturaDeCorte =
   metrosACentimetros (min alturaPino alturaDeCorte) * 3

-- De manera similar, para el pesoPorEncimaDe:
-- Si el pino es más alto que la altura de corte, entonces nos quedamos
-- con la altura del pino - la altura de corte.
-- Si el pino es más chico que la altura de corte, entonces nos
-- quedamos con 0 metros, y el peso por encima debería ser 0.
-- Así como antes usamos min, ahora podemos usar max:
pesoPorEncimaDe :: Number -> Number -> Number
pesoPorEncimaDe alturaPino alturaDeCorte =
   metrosACentimetros (max 0 (alturaPino - alturaDeCorte)) * 2
-- ¡Y listo!

-- FIN DEL REPASO DE CLASE ANTERIOR --


-- CLASE 3 --

-- Queremos representar cartas de Uno, por ahora, solamente
-- cartas con un número y un color, para esto, podemos usar
-- tuplas:

type Carta' = (Number, String)

-- Y si queremos hacer una función para obtener el color
-- de una carta, lo haríamos así:
color' :: Carta' -> String
color' (unNumero, unColor) = unColor
-- Y lo mismo para obtener el número:
numero' :: Carta' -> Number
numero' (unNumero, unColor) = unNumero
-- Con esto, ya podemos plantear una función que nos permita
-- saber si una carta se puede jugar sobre otra, lo cual ocurre
-- cuando comparte o el color o el número:
sePuedeJugarEncimaDe' :: Carta -> Carta -> Bool
sePuedeJugarEncimaDe' carta cartaAJugar =
   mismoColor carta cartaAJugar ||
   mismoNumero carta cartaAJugar

mismoColor' :: Carta' -> Carta' -> Bool
mismoColor' unaCarta otraCarta =
   color' unaCarta == color' otraCarta

mismoNumero' :: Carta' -> Carta' -> Bool
mismoNumero' unaCarta otraCarta =
   numero' unaCarta == numero' otraCarta

-- Hasta acá todo bien, pero, que pasa
-- si necesitamos modelar jugadores, con una
-- cantidad de partidas ganadas, ¿y su nombre?
type Jugador' = (Number, String)
tomi = (4, "Tomi")

-- Podemos crear todos los _sinónimos de tipo_ que querramos
-- usando type. Pero, ¡Ojo!, para haskell, esto no es más
-- que otro nombre para un tipo que ya existe.
-- Es decir, para haskell, Carta', Jugador' y (Number, String)
-- son exactamente el mismo tipo.
-- Y como son el mismo tipo, esto es una expresión válida:
-- color tomi
-- > "Tomi"
-- 
-- Es decir, podemos pasar cartas por parámetro como si fuesen
-- jugadores y viceversa, y no queremos eso.
-- 
-- Para poder decirle a haskell que las cartas y los jugadores
-- son tipos nuevos que nada tienen que ver entre sí o con
-- otras tuplas de forma (Number, String), tenemos que usar
-- la palabra clave data
-- (https://wiki.uqbar.org/wiki/articles/data--definiendo-nuestros-tipos-en-haskell.html)
-- como se crean datas y qué significa deriving está explicado acá arriba ^
data Carta'' = UnaCarta'' Number String deriving (Eq, Show)
data Jugador'' = UnJugador'' Number String deriving (Eq, Show)
-- Con esta definición, haskell ya no se va a confundir
-- cartas con jugadores.
-- Eso sí, la manera de definir color y numero cambia un poco:
color'' :: Carta'' -> String
color'' (UnaCarta'' unNumero unColor) = unColor

numero'' :: Carta'' -> Number
numero'' (UnaCarta'' unNumero unColor) = unNumero

-- Algo interesante a notar es que, a pesar de haber cambiado
-- cómo está definida y cómo se crea una carta, las funciones
-- mismoNumero, mismoColor y sePuedeJugarEncimaDe quedan iguales.
-- Esto ocurre porque esas funciones NO están usando pattern matching,
-- si no que están delegando parte de su definición en otras funciones
-- que sí hacen pattern matching (las funciones numero y color).

-- Otro cambio más que se puede hacer es limitar que colores son
-- válidos, creando un tipo Color en vez de usando String, que
-- es un tipo que contiene infinitos valores.
-- Podemos definir el tipo Color de la siguiente manera:
data Color''' = Azul''' | Rojo''' | Verde''' | Amarillo''' deriving (Eq, Show)
-- Esta función tiene más de un constructor, todos ellos de 0
-- parámetros.

-- y Carta debería definirse de esta manera:
data Carta''' = UnaCarta''' Number Color''' deriving (Eq, Show)

-- la función color se mantiene casi exactamente igual,
-- solo cambia el tipo:
color''' :: Carta''' -> Color'''
color''' (UnaCarta''' unNumero unColor) = unColor

-- NUEVO REQUERIMIENTO: Más 4
-- Queremos agregar un nuevo tipo de carta, el +4, que:
-- se puede jugar luego de cualquier carta.
-- Si la última carta jugada fue un +4, solo se puede jugar
-- una carta del mismo color que el +4.
-- Vamos a simplificar un poco el juego y asumir que el +4 tiene
-- siempre asociado un color, por más que en la realidad el color
-- se decide al momento de jugar la carta.

-- Para agregar el +4, necesitamos soportar un tipo de carta
-- que tiene color pero no tiene número, y necesitamos una forma
-- de distinguir ese tipo de cartas de las otras.
-- La solución propuesta en clase fue:
data Carta'''' = UnaCarta'''' Color'''' TipoDeCarta'''' deriving (Eq, Show)
data Color'''' = Azul'''' | Rojo'''' | Verde'''' | Amarillo'''' deriving (Eq, Show)
data TipoDeCarta'''' = CartaNormal'''' Number | Mas4'''' deriving (Eq, Show)

-- Lo cual nos permite definir cartas como un mas 4 azul así:
mas4Azul'''' = UnaCarta'''' Azul'''' Mas4''''
-- Y ahora cartas como un 7 rojo se deberían definir así:
sieteRojo'''' = UnaCarta'''' Rojo'''' (CartaNormal'''' 7)

-- Además, hay algunas funciones que cambian un poco, como por
-- ejemplo, numero. ¿Cuál es el número de un Mas 4? No tiene:
numero'''' :: Carta'''' -> Number
numero'''' (UnaCarta'''' unColor (CartaNormal'''' unNumero)) =
   unNumero
numero'''' (UnaCarta'''' unColor Mas4'''') =
   error "El mas 4 no tiene número"

-- mismoColor, y color quedan igual.
mismoColor'''' :: Carta'''' -> Carta'''' -> Bool
mismoColor'''' unaCarta otraCarta =
   color'''' unaCarta == color'''' otraCarta

color'''' (UnaCarta'''' unColor unTipoDeCarta) = unColor

-- Si usamos mismoNumero va a fallar con un mas 4, entonces,
-- podríamos decir que ninguna carta tiene el mismo número que
-- un mas 4, porque el mas 4 no tiene número:
mismoNumero'''' :: Carta'''' -> Carta'''' -> Bool
mismoNumero'''' (UnaCarta'''' _ Mas4'''') _ = False
mismoNumero'''' _ (UnaCarta'''' _ Mas4'''') = False
mismoNumero'''' unaCarta otraCarta =
   numero'''' unaCarta == numero'''' otraCarta
-- El pattern matching se va resolviendo en orden (como las guardas),
-- así que al poner en las primeras 2 cláusulas los casos en
-- los que nos llega un mas 4 como primera o segunda carta,
-- solo va a usarse la tercera cláusula de la función si
-- ninguna de las 2 cartas es un más 4.

-- También tenemos que cambiar sePuedeJugarEncimaDe para
-- soportar la lógica particular del más 4:
sePuedeJugarEncimaDe'''' :: Carta'''' -> Carta'''' -> Bool
-- un más 4 se puede jugar encima de cualquier carta
sePuedeJugarEncimaDe'''' _ (UnaCarta'''' _ Mas4'''') = True
-- una carta se puede jugar encima de un más 4 si tiene
-- el mismo color (esto ya está cubierto por mismoColor y
-- mismoNumero)
sePuedeJugarEncimaDe'''' carta cartaAJugar =
   mismoColor'''' carta cartaAJugar ||
   mismoNumero'''' carta cartaAJugar


-- JUNTANDO TODO --
-- Finalmente, dejo una solución alternativa aplicando
-- todo lo mencionado, con todo el código de las cartas.

data Carta =
   CartaNumerica Number Color
   | Mas4 Color
   deriving (Eq, Show)

data Color = Azul | Rojo | Verde | Amarillo deriving (Eq, Show)

color :: Carta -> Color
color (CartaNumerica _ unColor) = unColor
color (Mas4 unColor) = unColor

numero :: Carta -> Number
numero (CartaNumerica unNumero _) = unNumero
numero (Mas4 _) = error "El mas 4 no tiene número"

mismoColor :: Carta -> Carta -> Bool
mismoColor unaCarta otraCarta =
   color unaCarta == color otraCarta

mismoNumero :: Carta -> Carta -> Bool
mismoNumero (Mas4 _) _ = False
mismoNumero _ (Mas4 _) = False
mismoNumero unaCarta otraCarta =
   numero unaCarta == numero otraCarta

sePuedeJugarEncimaDe :: Carta -> Carta -> Bool
sePuedeJugarEncimaDe _ (Mas4 _) = True
sePuedeJugarEncimaDe carta cartaAJugar =
   mismoColor carta cartaAJugar ||
   mismoNumero carta cartaAJugar