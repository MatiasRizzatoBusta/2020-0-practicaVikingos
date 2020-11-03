class Vikingo {
	var casta
	var rol
	var cantHijos = 0
	var cantArmas = 0
	var vidasCobradas = 0
	var hectareasDesignadas = 0  //se requieren 2 x hijo
	var botin
	
	method rol() = rol
	method casta() = casta
	method armasQueTiene() = cantArmas
	method hijosQueTiene() = cantHijos
	method vidasCobradas() = vidasCobradas
	method hectareasDesignadas() = hectareasDesignadas
	method botin() = botin
	
	method cambiarRol(nuevoRol){
		rol = nuevoRol
	}
	
	method esJarl() = casta.esUnJarl()
	
	method cambiarCasta(nuevaCasta){
		casta = nuevaCasta
	}
	
	method agregarHijos(cant) {
		cantHijos += cant
	}
	
	method agregarArmas(cant){
		cantArmas += cant
	}
	
	method esProductivo() = rol.cumpleCondicionesProductivas(self) and casta.cumpleCondicionCasta(self)
	
	method ascender(){
		casta.ascender(self)		
	}
	
	method darBotin(nuevoBotin){
		botin += nuevoBotin
	}
	
}

class Casta{
	
	method ascender(vikingo)
	method cumpleCondicionCasta(vikingo)
	method esUnJarl() = false
	
} //es una interfaz


object jarl inherits Casta{
	
	override method cumpleCondicionCasta(vikingo) = vikingo.armasQueTiene() == 0
	
	method acitvarBeneficios(rol,vikingo){
		rol.beneficiosSubidaDeCasta(vikingo)
	}
	
	override method ascender(vikingo){
		vikingo.cambiarCasta(karl)
		vikingo.rol().beneficiosSubidaDeCasta(vikingo)
	}
	
	override method esUnJarl() = true
}

object karl inherits Casta{
	
	override method cumpleCondicionCasta(vikingo) = true
	
	override method ascender(vikingo){
		vikingo.cambiarCasta(thrall)
	}
}


object thrall inherits Casta{
	
	override method cumpleCondicionCasta(vikingo) = true
	
	override method ascender(vikingo){}
	
}

class Rol{
	
	method cumpleCondicionesProductivas(vikingo) 
	method beneficiosSubidaDeCasta(vikingo)
} //es una interfaz

object granjero inherits Rol{
	
	override method cumpleCondicionesProductivas(vikingo) = vikingo.hijosQueTiene()  <= (vikingo.hectareasDesignadas() /2)
	
	override method beneficiosSubidaDeCasta(vikingo){
		vikingo.agregarHijos(2)
	}
	
}

object soldado inherits Rol{

	override method cumpleCondicionesProductivas(vikingo){
		if(vikingo.esJarl()){
			return vikingo.armasQueTiene() == 0
		}else{
			return vikingo.vidasCobradas() >20 and vikingo.armasQueTiene() >= 1
			}
	} 
	
	override method beneficiosSubidaDeCasta(vikingo){
		vikingo.agregarArmas(10)
	}

}

