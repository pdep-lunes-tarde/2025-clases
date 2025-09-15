// Los ingredientes de pociones que conocemos por ahora son:
// - Bigote de gato, cuya rareza es 1.
// - Trébol, que si tienen 4 hojas su rareza es de 20, si no, es de 1.
// - Hiedra venenosa, cuya rareza es igual a la concentración de veneno que poseen, la cual podemos representar con un número.


// 1. Conocer cuántos ingredientes tiene una poción.


// 2. Poder agregar un ingrediente a una poción.


// 3. Cuál es la rareza de una poción, que es el promedio de rarezas de sus ingredientes. Si no tiene ingredientes, la rareza es 0.


// 4. Cómo afecta una poción a un alquimista, que es aplicar los efectos de cada uno de sus ingredientes:
// - El bigote de gato aumenta la suerte del alquimista en 1 y la salud también en 1.
// - El trébol aumenta la suerte del alquimista en 20 pero solo si es de 4 hojas, si no, no hace nada.
// - La hiedra venenosa disminuye la salud del alquimista en 2 * la concentración de veneno que tiene.


// 5. Queremos destilar una poción, lo cual la deja solo con sus ingredientes de rareza mayor a 5.


// 6. Queremos hervir la poción, lo cual hierve cada uno de sus ingredientes
// - Al hervir el bigote de gato queda igual.
// - El trébol pierde una hoja.
// - La hiedra venenosa aumenta su concentración, la cual se multiplica por 2.


// 7. Queremos que una poción pueda ser ingrediente de otra poción.


// Venta de pociones
// 8. Queremos mantener un registro de las ventas de un alquimista.
// Cuando un alquimista vende una poción, queremos registrar:
// - A quién se la vendió (que va a ser otro alquimista).
// - Cuál fue la poción vendida.

// Esta información la queremos poder consultar para saber:
// - Cuántos clientes tiene.
// - Si es un alquimista gourmet, que se cumple si sólo vende pociones de rareza mayor a 5.
// - Cuál es su cliente favorito, que es aquel que compró más pociones.


// - Bigote de gato, cuya rareza es 1.
// - Trébol, que si tienen 4 hojas su rareza es de 20, si no, es de 1.
// - Hiedra venenosa, cuya rareza es igual a la concentración de veneno que poseen, la cual podemos representar con un número.

object bigoteDeGato {
    method rareza() {
        return 1
    }

    method afectar(alquimista) {
        // alquimista.aumentarSalud(1)
        alquimista.modificarSalud({
            salud => salud + 1
        })
        alquimista.aumentarSuerte(1)
    }
}

class Trebol {
    var hojas
    method rareza() {
        if (hojas == 4) {
            return 20
        }
        return 1
    }

    method afectar(alquimista) {
        if (hojas == 4) {
            alquimista.aumentarSuerte(20)
        }
    }
}

class HiedraVenenosa {
    var concentracionDeVeneno

    method rareza() {
        return concentracionDeVeneno
    }

    method afectar(alquimista) {
        alquimista.disminuirSalud(concentracionDeVeneno * 2)
    }
}

class Pocion {
    // var ingredientes = new List()
    var ingredientes = []

    method agregarIngrediente(ingrediente) {
        ingredientes.add(ingrediente)
    }

    method cantidadDeIngredientes() {
        return ingredientes.size()
    }

    method rareza() {
        const rarezas = ingredientes.map {
            ingrediente => ingrediente.rareza()
        }
        const rarezaTotal = rarezas.sum()
        return rarezaTotal / self.cantidadDeIngredientes()
    }

    method ingredientes() {
        return ingredientes
    }
}

class Alquimista {
    var salud
    var suerte

    method tomarPocion(pocion) {
        pocion.ingredientes()
    }
    method salud() {
        return salud
    }
    method suerte() {
        return suerte
    }
    method salud(nuevaSalud) {
        salud = nuevaSalud
    }
    method suerte(nuevaSuerte) {
        suerte = nuevaSuerte
    }
    method aumentarSalud(cantidad) {
        salud += cantidad
    }
    method aumentarSuerte(cantidad) {
        suerte += cantidad
    }
    method disminuirSalud(cantidad) {
        salud -= cantidad
    }
    method modificarSalud(bloque) {
        salud = bloque.apply(salud)
    }
}

object duplicador {
    method apply() {
        return 2
    }

    method saludar() {
        return "Hola mundo"
    }
}
