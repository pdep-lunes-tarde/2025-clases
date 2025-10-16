import ave.*

class Bandada {
	const aves
	
	method descansar() {
		aves.forEach { unAve => unAve.descansar() }
	}
	
	// Si algún ave de la bandada no puede volar a la ciudad destino, ninguna debería hacerlo, porque siempre van juntas.
	method volarA(destino) {
		self.validarQueTodasPuedanVolarA(destino)
		aves.forEach { unAve => unAve.volarA(destino) }
	}

	method validarQueTodasPuedanVolarA(destino) {
		aves.forEach { unAve => unAve.validarQuePuedeVolarA(destino) }
	}
	
	// Si algún ave de la bandada no puede transportar algo a la ciudad destino, ninguna debería hacerlo, porque siempre van juntas.
	method transportarA(destino) {
		aves.forEach { unAve => unAve.transportarA(destino) }
	}
}

