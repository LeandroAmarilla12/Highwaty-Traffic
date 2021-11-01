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
	
	method desaparece(){
		if(self.position().y() <= 0){
			game.removeVisual(self)
			todosLosEnemigos.remove(self)
			puntaje.sumarPuntos(valorXDesaparecer)
		}
	}
	
	method choqueConTanque(){
		game.removeVisual(self)
		todosLosEnemigos.remove(self)
	}
	
	method choqueConPlayer(){
		game.removeVisual(self)
		todosLosEnemigos.remove(self)
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
		const desplazamiento = 1.randomUpTo(99)
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
		auto.vida(100)
		super()
	}	
}

class Bala inherits ObjetoEnLaPista(imagen = "balaTanque.png", valorXDesaparecer = 0){
	override method choqueConPlayer(){
		auto.vida(auto.vida()-50)
		super()
	}
}