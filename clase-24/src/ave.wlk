class NotEnoughEnergyException inherits DomainException {}
class CityIsClosedException inherits DomainException {}

class Ave {
	var energia // La energía de un ave nunca va a superar 100.
	var ciudad // Un ave siempre se encuentra en una ciudad.

	// Un ave no debería poder volar a una ciudad si no le alcanza la energía para hacerlo.
	// Siempre luego de volar, el ave está en la ciudad destino y con menos energía por el viaje realizado
	method volarA(otraCiudad) {
		self.validarQuePuedeVolarA(otraCiudad)
		energia -= self.energiaRequeridaParaVolarA(otraCiudad)
		ciudad = otraCiudad
	}

	// Un ave no debería poder transportar algo a una ciudad si no le alcanza la energía para hacerlo.
	// Siempre después de transportar, el ave está en la ciudad destino y con menos energía por el viaje realizado.
	// Siempre después de transportar, la ciudad destino recibió la producción de la ciudad en la que se encontraba
	// el ave.
	method transportarA(otraCiudad) {
		const productoATransportar = ciudad.produccion()
		self.volarA(otraCiudad)
		ciudad.dar(productoATransportar)
	}

	method validarQuePuedeVolarA(otraCiudad) {
		const energiaNecesariaParaVolar = self.energiaRequeridaParaVolarA(otraCiudad)
		if(energia < energiaNecesariaParaVolar) {
			throw new NotEnoughEnergyException(message="Energia insuficiente")
		}
	}

	method energiaRequeridaParaVolarA(otraCiudad) = ciudad.distanciaHasta(otraCiudad)
	method energia() = energia
	method ciudad() = ciudad
	method descansar() {
		energia = (energia + 20).min(100)
	}
}

// 
