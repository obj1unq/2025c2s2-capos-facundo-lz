object rolando {
    var capacidad = 2
    const objetos = #{}
    const objetosVistos = []
    var hogar = castilloDePiedra
    var property poderBase = 5

    method hogar(_hogar){
        hogar = _hogar
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

    method irAlCastillo(){
        hogar.guardarObjetos(objetos)
        objetos.clear()
    }

    method tieneArtefacto(artefacto){
        return self.objetosEnPosesion().contains(artefacto)
    }

    method objetosEnPosesion(){
        return objetos + hogar.objetos()
    }

    method objetosVistos (){
        return objetosVistos
    }

    method luchar(){
        poderBase += 1
        objetos.forEach({objeto => objeto.sumarBatalla()})
    }

    method poderDePelea (){
        var poderAportadoHastaAhora = 0
        objetos.forEach({objeto => poderAportadoHastaAhora += objeto.poderAportado(self)})
        return poderBase + poderAportadoHastaAhora
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
    var hechizos = [bendicion,invisibilidad,invocacion]

    method poderAportado(personaje){
        if (hechizos.isEmpty()){
            return 0
        } else {
            return hechizos.head().poderAportado(personaje)
        }
    }

    method sumarBatalla(){
        if (not hechizos.isEmpty()){
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
        return personaje.poderDePelea()
    }
}

object invocacion{
    method poderAportado(personaje){
        return personaje.objetos().max({objeto => objeto.poderAportado(personaje)})
    }
}
