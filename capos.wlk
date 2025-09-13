object rolando {
    var capacidad = 2
    const objetos = #{}

    method recogerObjeto (objeto){
        if (objetos.size() < capacidad) {
            objetos.add(objeto)
        }
    }

    method capacidad (_capacidad){
        capacidad = _capacidad
    }

    method objetos (){
        return objetos
    }
}