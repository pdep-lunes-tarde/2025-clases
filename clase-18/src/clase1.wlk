// 1
// Pepita es una golondrina que puede volar y comer.
// Nos interesará consultar cuál es su energía antes y después de volar y comer (o en cualquier otro momento que querramos).

object pepita {
    var energia = 100
    method energia() {
        return energia
    }
    method come(gramosDeAlpiste) {
        energia = energia + gramosDeAlpiste * 2
    }
    method vola(kilometrosAVolar) {
        energia = energia - 40 - 5 * kilometrosAVolar
    }
}
// Al volar gasta 5 joules de energía por cada kilómetro volado, más 40 joules para comenzar a volar.

// Sabemos que:
// Al volar gasta 5 joules de energía por cada kilómetro volado, más 40 joules para comenzar a volar.
// Por cada gramo que come gana 2 joules de energía.
// Inicialmente su energía es 100 joules.













// 2
// Josefa es una paloma que también puede volar y comer, sólo que distinto.
// Nos interesará consultar cuál es su energía, que se calcula en base a su energía inicial (80), cuántos kilómetros voló y cuántos gramos comió.

object josefa {
    // La energia de josefa es igual a: su energia inicial (80) + 3 por cada gramo comido - 5 por cada kilometro volado
    var gramosComidos = 0
    var kilometrosVolados = 0
    const energiaInicial = 80

    method energia() {
        return energiaInicial + 3 * gramosComidos - 5 * kilometrosVolados
    }

    method vola(kilometrosAVolar) {
        kilometrosVolados = kilometrosVolados + kilometrosAVolar
    }

    method come(gramosDeAlpiste) {
        gramosComidos = gramosComidos + gramosDeAlpiste
    }

    method animo() {
        if(gramosComidos > kilometrosVolados) {
            return "Bonita y gordita"
        }

        if(self.energia() > energiaInicial) {
            return "Energica"
        }

        return "Indiferente"
    }
}

// Además a Josefa le podremos preguntar cómo se siente. Ampliaremos… 


// Queremos poder preguntarle a Josefa cómo se siente, y debe respondernos:
// "Bonita y gordita" si le dimos más de comer de lo que la hicimos volar
// "Enérgica" si su energía es mayor a su energía inicial
// "Indiferente" en cualquier otro caso



// 3
// Agregamos a nuestro sistema a un entrenador. Su rutina de entrenamiento para un pajarito es la siguiente:

object entrenador {
    method entrena(unAve) {
        unAve.come(10)
        unAve.vola(20)
        if(unAve.energia() < 20) {
            unAve.come(10)
        } else {
            unAve.come(2)
        }
    }
}

// Darle de comer 10 gramos de alpiste
// Mandarlo a volar 20 kilómetros
// Si luego de volar la energía del pajarito es menor a 20, darle de comer 10 gramos de alpiste, de lo contrario darle de comer 2 gramos.

// 4
// Vamos a agregar un ave que tiene una compañera, su nombre es beti y se va a comportar así: su energía va a ser la misma que la de su compañera, cuando come x cantidad, le da de comer la mitad a su compañera, y cuando vuela x kms, su compañera también.
// Queremos que pueda cambiar de compañera
// Y su compañera inicial es pepita
object beti {
    var companiera = pepita
    method energia() {
        return companiera.energia()
    }
    method come(gramos) {
        companiera.come(gramos / 2)
    }
    method vola(kilometros) {
        companiera.vola(kilometros)
    }
    method companiera(nuevaCompaniera) {
        companiera = nuevaCompaniera
    }
}
