	import vikingos.*

class Expedicion {
	var objetivos = []
	var vikingosEnLaExpedicion = []
	var botinTotal = 0
	
	method agregarVikingo(vikingo){
		if(vikingo.esProductivo()){
			vikingosEnLaExpedicion.add(vikingo)
		}else{
			self.error("No se puede subir a la expedicion")
		}
	}
	
	method mostrarVikingosEnLaExpedicion() = vikingosEnLaExpedicion
	
	method tamanioExpedicion() = vikingosEnLaExpedicion.size()
	
	method valeLaPena() = objetivos.all({objetivo => objetivo.loVale(self)})
	
	method salirEnExpedicion(){
		objetivos.forEach({objetivo => objetivo.esInvadido(self)})
		const porcion = botinTotal / self.tamanioExpedicion()
		vikingosEnLaExpedicion.forEach({vikingo => vikingo.darBotin(porcion)})
	}
	
	method agregarABotin(botin){
		botinTotal += botin
	}
	
}

class Destino{
	method loVale(expedicion)
	method esInvadido(expedicion)
}

class Aldea inherits Destino{
	var cantCrucifijosEnIglesias
	
	method lograSasear() = cantCrucifijosEnIglesias >= 15
	
	override method loVale(expedicion) = self.lograSasear() 
	
	override method esInvadido(expedicion) = expedicion.agregarABotin(cantCrucifijosEnIglesias)
}

class AldeaAmurallada inherits Aldea{
	var cantMinimaRequerida
	
	override method loVale(expedicion) {
		return self.lograSasear() and cantMinimaRequerida <= expedicion.tamanioExpedicion()
		}		
}

class Capital inherits Destino{
	var cantDerrotados = 0
	var potenciadorTierra
	
	method invadida(expedicion){
		cantDerrotados = expedicion.tamanioExpedicion() //todos matan a 1
		}
		
	method botin() = cantDerrotados + potenciadorTierra
	
	override method loVale(expedicion){
		self.invadida(expedicion)
		return (self.botin()/expedicion.tamanioExpedicion()) >= 3 
	}
	
	override method esInvadido(expedicion){
		self.invadida(expedicion)
		expedicion.agregarABotin(self.botin())
		
		}
		
}