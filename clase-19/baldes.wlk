// Queremos modelar el comportamiento de un balde al que se le cargan/descargan autitos de juguete.
// Lo que ya sabemos:
// - El peso de los autitos
// - El peso máximo que soporta el balde
// Queremos:
// - Que se pueda ingresar una cantidad N de autitos
//   sin que se supere el peso máximo que puede cargar
//   nuestro balde.
// - Poder sacar M cantidad de autitos, sin que quede
//   menor a 0.
// - Saber el peso total almacenado.

// object baldeDeAutitos {
//   const pesoMaximo = 500
//   const pesoUnitario = 20
//   var unidades = 0

//   method agregarAutitos(cantidad) {
//     const pesoPotencial = self.pesoAlmacenado() + cantidad * pesoUnitario
//     if (pesoPotencial <= pesoMaximo) {
//       unidades = unidades + cantidad
//     }
//   }

//   method sacarAutitos(cantidad) {
//     const unidadesPotenciales = unidades - cantidad
//     if (unidadesPotenciales >= 0) {
//       unidades = unidadesPotenciales
//     }
//   }

//   method pesoAlmacenado() {
//     return pesoUnitario * unidades
//   }
// }

// Juan y Manu quieren tener sus propios baldes para
// guardar autitos,por lo que vamos a necesitar tener
// baldes separados que guarden los juguetes de cada uno.

// object baldeDeAutitos2 {
//   const pesoMaximo = 500
//   const pesoUnitario = 20
//   var unidades = 0

//   method agregarAutitos(cantidad) {
//     const pesoPotencial = self.pesoAlmacenado() + cantidad * pesoUnitario
//     if (pesoPotencial <= pesoMaximo) {
//       unidades = unidades + cantidad
//     }
//   }

//   method sacarAutitos(cantidad) {
//     const unidadesPotenciales = unidades - cantidad
//     if (unidadesPotenciales >= 0) {
//       unidades = unidadesPotenciales
//     }
//   }

//   method pesoAlmacenado() {
//     return pesoUnitario * unidades
//   }
// }

// ¿Y si queremos baldes para 100 personas?

class Balde {
  const pesoMaximo = 500
  const pesoUnitario
  var unidades = 0

  method agregarUnidades(cantidad) {
    const pesoPotencial = self.pesoAlmacenado() + cantidad * pesoUnitario
    if (pesoPotencial <= pesoMaximo) {
      unidades = unidades + cantidad
    }
  }

  method sacarUnidades(cantidad) {
    const unidadesPotenciales = unidades - cantidad
    if (unidadesPotenciales >= 0) {
      unidades = unidadesPotenciales
    }
  }

  method pesoAlmacenado() {
    return pesoUnitario * unidades
  }
}

object juan {
  var balde = new Balde(pesoUnitario = 40)

  method pesoTotal() {
    return 70 + balde.pesoAlmacenado()
  }

  method cambiarBalde() {
    balde = new Balde(pesoUnitario = 40)
    balde.agregarUnidades(4)
  }

  method cambiarBaldePorUnString() {
    balde = "soy un balde"
    // la instancia de Balde es
    // eliminada por el Garbage Collector
  }
}

object manu {
  const balde = new Balde(pesoUnitario = 30)

  method pesoTotal() {
    return 70 + balde.pesoAlmacenado()
  }

  method agregarAutitosASuBalde(cantidad) {
    balde.agregarUnidades(cantidad)
  }
}

// Podríamos crear 100 baldes con:
// 100.times { _i => new Balde() }
// ...pero perdemos inmediatamente la referencia
// a ellos.

// ¿Cómo podemos hacer para generar baldes que nos
// permitan guardar otras cosas?

const baldeDeCuadernos = new Balde(
  pesoMaximo = 100,
  pesoUnitario = 10,
  unidades = 5
)

const baldeDeBotellas = new Balde(
  pesoUnitario = 15,
  unidades = 5,
  pesoMaximo = 200
)
