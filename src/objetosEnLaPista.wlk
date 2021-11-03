import wollok.game.*
import autos.*
import puntaje.*
import Fondo.*
import juegoYConfiguraciones.*



class ObjetoEnLaPista inherits ElementoMovil{
	var imagen 
	var valorXDesaparecer 
	
	const todosLosEnemigos = [] 
	
	method soyPlayer() = false
	method image() = imagen
	
	override method caer(){
		super()
		self.desaparece()
	}
	
	method desaparece(){
		if(self.position().y() <= 0){
			self.removerObjeto()
			puntaje.sumarPuntos(valorXDesaparecer)
		}
	}
	
	method removerObjeto(){
		game.removeVisual(self)
		todosLosEnemigos.remove(self)
	}
	
	method choqueConTanque(){
		self.removerObjeto()
	}
	
	method choqueConPlayer(){
		self.removerObjeto()	
	}	
}

class ManchaAceite inherits ObjetoEnLaPista(imagen = "aceite.png", valorXDesaparecer = 0){	
//	override method chocarCon(unAuto){
//		 
//	}
	
	override method choqueConPlayer(){
		self.desplazamientoAleatorio(auto)
	}
	
	method desplazamientoAleatorio(unAuto){
		const desplazamiento = 1.randomUpTo(10).truncate(0)
		if(desplazamiento.even()){
			unAuto.position(unAuto.position().right(3))
		}
		else{
			unAuto.position(unAuto.position().left(3))
		}
		
	}
}

class Reparador inherits ObjetoEnLaPista(imagen = "llave.png", valorXDesaparecer = 0){
	override method choqueConPlayer(){
		if (auto.vida() < 100){			
			auto.vida(100)
			super()
		}
	}	
}

class Bala inherits ObjetoEnLaPista(imagen = "balaTanque.png", valorXDesaparecer = 0){
	override method choqueConPlayer(){
		auto.vida(auto.vida()-50)
		super()
	}
}
