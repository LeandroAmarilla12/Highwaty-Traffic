import wollok.game.*
import autos.*
import puntaje.*
import Fondo.*
import juegoYConfiguraciones.*



class ObjetoEnLaPista inherits ElementoMovil{
	var imagen 
	var valorXDesaparecer 
	
	const todosLosEnemigos = [] 
	
	method image() = imagen
	
	
	
	method desaparece(){
		if(self.position().y() <= 0){
			game.removeVisual(self)
			todosLosEnemigos.remove(self)
			puntaje.sumarPuntos(valorXDesaparecer)
		}
	}
	
	method chocarCon(unAuto){
		 unAuto.vida(unAuto.vida()-25)
		 /*if(unAuto.meMori()){
		   
		  }*/
	}
	
}

class ManchaAceite inherits ObjetoEnLaPista(imagen = "aceite.png", valorXDesaparecer = 0){	
	override method chocarCon(unAuto){
		 self.desplazamientoAleatorio(unAuto)
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
	override method chocarCon(unAuto){
		unAuto.vida(100)
		game.removeVisual(self)
		todosLosEnemigos.remove(self)
	}
	
}

class Bala inherits ObjetoEnLaPista(imagen = "balaTanque.png", valorXDesaparecer = 0){
	override method chocarCon(unAuto){
		unAuto.vida(unAuto.vida()-50)
		game.removeVisual(self)
		todosLosEnemigos.remove(self)
	}
}
