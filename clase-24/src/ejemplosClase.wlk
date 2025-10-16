import ciudad.*
import ave.*

const puebloPaleta = new Ciudad(ubicacion=new Position(x=1, y=1), produccion='alfajores')
const pepita = new Ave(energia=2, ciudad=puebloPaleta)
const ciudadAzafran = new Ciudad(ubicacion=new Position(x=5, y=5), produccion='tecnologia')
const ciudadCeleste = new Ciudad(ubicacion=new Position(x=0, y=0), produccion='nuggets')

object tour {
    method realizar(ave) {
        ave.volarA(ciudadAzafran)
        ave.volarA(ciudadCeleste)
        ave.volarA(puebloPaleta)
    }
}

