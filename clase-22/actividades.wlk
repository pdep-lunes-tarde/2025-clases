class Estudiante {
  var tazas = 3
  var energia = 0
  var horasDeEstudio = 0
  var property estresado = false
  const rutinaDeEstudio = []

  method usarUnaTaza() {
    tazas = tazas - 1
  }

  method leQuedaAlgunaTaza() = tazas > 0

  method energia() = energia

  method sumarHorasDeEstudio(horas) {
    horasDeEstudio += horas
  }

  method cansarse(cantidad) {
    energia = (energia - cantidad).max(0)
  }
  method recuperarEnergia(cantidad) { energia += cantidad }

  method concentracion() {
    if(estresado) {
        return energia / 2
    } else {
        return energia
        }
  }

  method concentrado() = self.concentracion() > 50

  method hacerRutinaDeEstudio() {
    rutinaDeEstudio.forEach { actividad =>
        if(actividad.puedeHacerse(self)) {
            actividad.hacerse(self)
        }
    }
  }
}

class EscucharMusica {
    method puedeHacerse(estudiante) = true

    method hacerse(estudiante) {
        estudiante.estresado(false)
    }
}

object escucharCancionFavorita inherits EscucharMusica {
    override method hacerse(estudiante) {
        estudiante.recuperarEnergia(20)
        super(estudiante)
    }
}


class TomarInfusion {
    method hacerse(estudiante) {
        estudiante.usarUnaTaza()
        self.causarEfectoDeInfusion(estudiante)
    }

    method causarEfectoDeInfusion(estudiante)

    method puedeHacerse(estudiante) = estudiante.leQuedaAlgunaTaza()
}

class TomarCafe inherits TomarInfusion {
    const cafeina

    override method causarEfectoDeInfusion(estudiante) {
        estudiante.recuperarEnergia(30)
        if(cafeina > 200) {
            estudiante.estresado(true)
        }
    }
}
object tomarTe inherits TomarInfusion {
    override method causarEfectoDeInfusion(estudiante) {
        estudiante.estresado(false)
        estudiante.recuperarEnergia(5)
    }
}

// Alternativa usando super (se repite el uso de super en cada subclase):
// class TomarInfusion {
//     method hacerse(estudiante) {
//         estudiante.usarUnaTaza()
//     }
//
//     method puedeHacerse(estudiante) = estudiante.leQuedaAlgunaTaza()
// }

// class TomarCafe inherits TomarInfusion {
//     const cafeina

//     override method hacerse(estudiante) {
//         super(estudiante)
//         estudiante.recuperarEnergia(30)
//         if(cafeina > 200) {
//             estudiante.estresado(true)
//         }
//     }
// }
//
// object tomarTe inherits TomarInfusion {
//     override method hacerse(estudiante) {
//         super(estudiante)
//         estudiante.estresado(false)
//         estudiante.recuperarEnergia(5)
//     }
// }

class Estudiar {
    const dificultad
    const horas

    method puedeHacerse(estudiante) = estudiante.concentrado()

    method hacerse(estudiante) {
        estudiante.sumarHorasDeEstudio(horas)
        estudiante.cansarse(horas * dificultad.multiplicadorDeCansancio())
    }
}

object temaFacil {
    method multiplicadorDeCansancio() = 1
}
object temaRegular {
    method multiplicadorDeCansancio() = 5
}
object temaDificil {
    method multiplicadorDeCansancio() = 10
}


// Ejemplo que surgió en clase de super, no tiene que ver con el dominio de
// actividades de estudiante.
// class Hablador {
//     method decir(cosaADecir) {
//         console.println(cosaADecir)
//     }
// }

// class HabladorEfusivo inherits Hablador{
//     override method decir(cosaADecir) {
//         super("¡¡¡¡¡" + cosaADecir + "!!!!!")
//     }
// }