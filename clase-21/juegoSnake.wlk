import snake.*
import wollok.game.*

object juegoSnake {
    const intervaloDeTiempoInicial = 100
    var intervaloDeTiempo = intervaloDeTiempoInicial

    method intervaloDeTiempo() {
        return intervaloDeTiempo
    }
    method ancho() {
        return 20
    }
    method alto() {
        return 20
    }
    method configurar() {
        game.width(self.ancho())
        game.height(self.alto())
        game.cellSize(32)

                game.addVisual(snake)
        game.addVisual(indicadorDeVelocidad)
        game.addVisual(new Muro(position=new Position(x=3, y=3)))

        game.onCollideDo(snake, { otro =>
            otro.chocasteConSnake(snake)
        })

        game.onTick(1000, "aparecerManzana", {
            const nuevaManzana = new Manzana(position=new Position(
                x=0.randomUpTo(self.ancho()),
                y=0.randomUpTo(self.alto())
                )
            )

            game.addVisual(nuevaManzana)
        })

        game.onTick(intervaloDeTiempo, "movimiento", { snake.move() })

        keyboard.space().onPressDo {
            intervaloDeTiempo -= 5
            game.removeTickEvent("movimiento")
            game.onTick(intervaloDeTiempo, "movimiento", { snake.move() })

        }

        keyboard.right().onPressDo {
            snake.direccion(derecha)
        }
        keyboard.d().onPressDo {
            snake.direccion(derecha)
        }
        keyboard.left().onPressDo {
            snake.direccion(izquierda)
        }
        keyboard.a().onPressDo {
            snake.direccion(izquierda)
        }
        keyboard.up().onPressDo {
            snake.direccion(arriba)
        }
        keyboard.w().onPressDo {
            snake.direccion(arriba)
        }
        keyboard.down().onPressDo {
            snake.direccion(abajo)
        }
        keyboard.s().onPressDo {
            snake.direccion(abajo)
        }
    }

    method restart() {
        intervaloDeTiempo = intervaloDeTiempoInicial
        game.clear()
        self.configurar()
    }

    method jugar() {
        self.configurar()

        game.start()
    }
}