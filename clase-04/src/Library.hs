module Library where
import PdePreludat

-- Recursividad
-- https://pbv.github.io/haskelite/site/index.html

factorial :: Number -> Number
factorial 0 = 1
factorial n = n * factorial (n - 1)

-- multiplicar 2 por 3 deberia ser equivalente a 2 + 2 + 2, o sea 6
multiplicar :: Number -> Number -> Number
multiplicar _ 0 = 0
multiplicar unNumero otroNumero
    | otroNumero > 0 = unNumero + multiplicar unNumero (otroNumero - 1)
    | otroNumero < 0 = negate (multiplicar unNumero (negate otroNumero))

-- Listas

xs :: [Number]
xs = [1,2,3,4,5]

data Carta = Carta Color Number deriving (Eq, Show)
data Color = Azul | Rojo | Verde | Amarillo deriving (Eq, Show)

color :: Carta -> Color
color (Carta unColor _) = unColor

-- 'H' : 'o' : 'l' : 'a' : []
-- ['H', 'o', 'l', 'a']
-- ==
-- "Hola"
-- ^ esto es un syntax sugar

-- estaVacia
-- estaVacia ListaVacia =
--     implementame
-- estaVacia (ListaCon cabeza cola) =
--     implementame

-- [1,2,3]
-- ==
-- 1 : 2 : 3 : []

estaVacia :: [a] -> Bool
estaVacia [] = True
estaVacia (cabeza : cola) = False

-- primero [1,2,3] deberia ser 1
primero :: [a] -> a
primero [] = error "La lista estaba vacía"
primero (cabeza:cola) = cabeza

resto :: [a] -> [a]
resto (cabeza:cola) = cola
------  (  1 : [] )
-- resto [1]    ---> []

-- ultimo ["hola", "que", "tal"] deberia ser "tal"
ultimo :: [a] -> a
ultimo (cabeza : []) = cabeza
ultimo (cabeza : cola) = ultimo cola

ultimo' :: Eq a => [a] -> a
ultimo' (cabeza : cola)
    | cola == [] = cabeza
    | otherwise = ultimo' cola

ultimo'' :: [a] -> a
ultimo'' (cabeza:cola)
    | estaVacia cola = cabeza
    | otherwise = ultimo'' cola

-- cantidad ["hola", "que", "tal"] deberia ser 3
cantidad :: [a] -> Number
cantidad [] = 0
cantidad (cabeza : cola) = 1 + cantidad cola

-- contiene 3 [1,2,3] deberia ser True
-- contiene 4 [1,2,3] deberia ser False
contiene :: Eq a => a -> [a] -> Bool 
contiene _ [] = False
contiene elemento (cabeza: cola) =
    elemento == cabeza ||
    contiene elemento cola

-- agregar 1 [1,2,3] deberia ser [1,1,2,3]
agregar :: a -> [a] -> [a]
agregar cabeza lista = cabeza : lista

-- agregarAlFinal 1 [1,2,3] deberia ser [1,2,3,1]
agregarAlFinal :: a -> [a] -> [a]
agregarAlFinal elemento [] = [elemento]
agregarAlFinal elemento (cabeza:cola) =
    cabeza : agregarAlFinal elemento cola

agregarAlFinal' :: a -> [a] -> [a]
agregarAlFinal' elemento lista =
    agregarTodos lista [elemento]

-- agregarTodos [1,2,3] [4,5,6] = [1,2,3,4,5,6]
agregarTodos :: [a] -> [a] -> [a]
agregarTodos [] lista = lista
agregarTodos (cabeza:cola) lista =
    cabeza : agregarTodos cola lista
