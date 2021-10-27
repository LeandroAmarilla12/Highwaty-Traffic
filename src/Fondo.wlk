import wollok.game.*
import autos.*
import juegoYConfiguraciones.*

object pista inherits ElementoMovil(position = game.at(2,0)){
	const initialPosition = game.at(2,0)

	method image() = "pista.png"
		
	
	method mover(){
		if(self.position().distance(initialPosition)==20){
			position = initialPosition
		}
		else{self.caer()}
	}
}

class Pared{
	var property position
	method image() =  "rueda.png"
	
	method chocarCon(unAuto)
					
}

class ParedIzquierda inherits Pared{
	override method chocarCon(unAuto){
		unAuto.position(unAuto.position().right(3))
	}
}

class ManchaAceite inherits ElementoMovil{
	
	method image() = "aceite.png"
	
	method chocarCon(unAuto){
		self.desplazamientoAleatorio(unAuto)
	}
	
	method desplazamientoAleatorio(unAuto){
		const desplazamiento = 1.randomUpTo(3)
		if(desplazamiento.even()){
			unAuto.position(unAuto.position().right(3))
		}
		else{
			unAuto.position(unAuto.position().left(3))
		}
	}
}