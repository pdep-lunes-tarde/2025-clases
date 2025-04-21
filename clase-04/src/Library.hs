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

-- primero [1,2,3] deberia ser 1
primero = implementame

-- ultimo ["hola", "que", "tal"] deberia ser "tal"
ultimo = implementame

-- cantidad ["hola", "que", "tal"] deberia ser 3
cantidad = implementame

-- tiene 3 [1,2,3] deberia ser True
-- tiene 4 [1,2,3] deberia ser False
tiene = implementame

-- agregar 1 [1,2,3] deberia ser [1,1,2,3]
agregar = implementame

-- agregarAlFinal 1 [1,2,3] deberia ser [1,2,3,1]
agregarAlFinal = implementame

-- agregarTodos [1,2,3] [4,5,6] = [1,2,3,4,5,6]
agregarTodos = implementame