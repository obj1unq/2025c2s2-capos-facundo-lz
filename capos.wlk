object rolando{
    var capacidad = 2
    const objetos = #{}
    const objetosVistos = []
    var morada = castilloDePiedra
    var property poderBase = 5

    method morada(_morada){
        morada = _morada
    }

    method recogerObjeto (objeto){
        if (objetos.size() < capacidad) {
            objetos.add(objeto)
        }
        objetosVistos.add(objeto)
    }

    method capacidad (_capacidad){
        capacidad = _capacidad
    }

    method objetos (){
        return objetos
    }

    method irAMorada(){
        morada.guardarObjetos(objetos)
        objetos.clear()
    }

    method tieneArtefacto(artefacto){
        return self.objetosEnPosesion().contains(artefacto)
    }

    method objetosEnPosesion(){
        return objetos + self.objetosAlmacenados()
    }

    method objetosAlmacenados (){
        return morada.objetos()
    }

    method objetosVistos (){
        return objetosVistos
    }

    method luchar(){
        poderBase += 1
        objetos.forEach({objeto => objeto.sumarBatalla()})
    }

    method poderDePelea (){
        return poderBase + objetos.sum({objeto => objeto.poderAportado(self)})
    }

    method esPoderosoEn (tierra){
        return tierra.enemigos().all({enemigo => self.leGanaAEnemigo(enemigo)})
    }

    method moradasConquistables (tierra){
        return self.enemigosALosQueLesGana(tierra).map({enemigo => enemigo.morada()})
    }

    method enemigosALosQueLesGana (tierra){
        return tierra.enemigos().filter({enemigo => self.leGanaAEnemigo(enemigo)})
    }

    method leGanaAEnemigo (enemigo){
        return self.poderDePelea() > enemigo.poderDePelea()
    }

    method poseeArtefactoFatal (enemigo){
        return !objetos.isEmpty() and self.objetoMasPoderoso().poderAportado(self) + poderBase > enemigo.poderDePelea()
    }

    method objetoMasPoderoso(){
        return objetos.max({objeto => objeto.poderAportado(self)})
    }

    method objetoMasPoderosoAlmacenado(){
        return self.objetosAlmacenados().max({objeto => objeto.poderAportado(self)})
    }
}

object castilloDePiedra{
    const objetos = #{}

    method guardarObjetos(_objetos){
        objetos.addAll(_objetos)
    }

    method objetos(){
        return objetos
    }

    method tieneArtefacto(artefacto){
        return objetos.contains(artefacto)
    }
}

object espadaDelDestino{
    var cantidadDeBatallas = 0

    method poderAportado (personaje){
        if (cantidadDeBatallas == 0){
            return personaje.poderBase()
        } else {
            return personaje.poderBase() / 2
        }
    }

    method sumarBatalla(){
        cantidadDeBatallas += 1
    }
}

object collarDivino{
    var cantidadDeBatallas = 0

    method poderAportado(personaje){
        if (personaje.poderBase() > 6){
            return 3 + cantidadDeBatallas
        } else {
            return 3
        }
    }

    method sumarBatalla(){
        cantidadDeBatallas += 1
    }
}

object armaduraValkyria{

    method poderAportado (personaje){
        return 6
    }

    method sumarBatalla(){
    }
}

object libroDeHechizos{
    var hechizos = [invocacion]

    method poderAportado(personaje){
        if (hechizos.isEmpty()){
            return 0
        } else {
            return hechizos.head().poderAportado(personaje)
        }
    }

    method sumarBatalla(){
        if (!hechizos.isEmpty()){
            hechizos = hechizos.drop(1)
        }
    }

    method hechizos (_hechizos){
        hechizos = _hechizos
    }
}

object bendicion{
    method poderAportado(personaje){
        return 4
    }
}

object invisibilidad{
    method poderAportado(personaje){
        return personaje.poderBase()
    }
}

object invocacion{
    method poderAportado(personaje){
        if (personaje.objetosAlmacenados().isEmpty()){
            return 0
        } else {
            return personaje.objetoMasPoderosoAlmacenado().poderAportado(personaje)
        }
    }
}

object erethia{
    var property enemigos = [caterina, archibaldo, astra]
}

object caterina{
    const morada = fortalezaDeAcero

    method poderDePelea(){
        return 28
    }

    method morada(){
        return morada
    }
}

object archibaldo{
    const morada = palacioDeMarmol

    method poderDePelea(){
        return 16
    }

    method morada(){
        return morada
    }
}

object astra{
    const morada = torreDeMarfil

    method poderDePelea(){
        return 16
    }

    method morada(){
        return morada
    }
}

object fortalezaDeAcero{
}

object palacioDeMarmol{
}

object torreDeMarfil{
}
