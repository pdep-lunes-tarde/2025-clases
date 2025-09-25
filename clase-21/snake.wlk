import wollok.game.*
import juegoSnake.*

class Muro {
    const position
    method image() {
        return "pared.png"
    }
    method position() {
        return position
    }
    method chocasteConSnake(unaSnake) {
        juegoSnake.restart()
    }
}

class Manzana {
    const position
    method image() {
        return "manzana.png"
    }
    method position() {
        return position
    }
    method chocasteConSnake(unaSnake) {
        game.sound("grabCoin.wav").play()
        game.removeVisual(self)
    }
}

object indicadorDeVelocidad {
    method position() {
        return game.at(game.width() - 5, game.height() - 1)
    }

    method text() {
        return "Intervalo de tiempo: " + juegoSnake.intervaloDeTiempo() + " ms"
    }
}

object snake {
    var direccion = sinDireccion
    var posicion = new Position(x=10, y=10)

    method image() {
        return "viborita_segmento.png"
    }

    method position() {
        return posicion
    }

    method position(nuevaPosicion) {
        posicion = nuevaPosicion
    }

    method direccion(nuevaDireccion) {
        direccion = nuevaDireccion
    }

    method move() {
        const nuevaPosicion = direccion.siguientePosicion(posicion)

        posicion = self.posicionCorregida(nuevaPosicion)
    }

    method posicionCorregida(posicionACorregir) {
        const nuevaY = wraparound.aplicarA(posicionACorregir.y(), 0, juegoSnake.alto())
        const nuevaX = wraparound.aplicarA(posicionACorregir.x(), 0, juegoSnake.ancho())

        return new Position(x=nuevaX, y=nuevaY)
    }
}


object izquierda {
    method siguientePosicion(posicion) {
        return posicion.left(1)
    }
}
object abajo {
    method siguientePosicion(posicion) {
        return posicion.down(1)
    }
}
object arriba {
    method siguientePosicion(posicion) {
        return posicion.up(1)
    }
}
object derecha {
    method siguientePosicion(posicion) {
        return posicion.right(1)
    }
}

object sinDireccion {
    method siguientePosicion(posicion) {
        return posicion
    }
}

object wraparound {
    method aplicarA(numero, topeInferior, topeSuperior) {
        if(numero < topeInferior) {
            return topeSuperior
        } else if(numero > topeSuperior) {
            return topeInferior
        } else {
            return numero
        }
    }
}