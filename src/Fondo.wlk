import wollok.game.*
import autos.*
import juego.*
import objetos.*

object pista inherits ElementoMovil(position = game.at(1,0)){
	const initialPosition = game.at(1,0)

	method image() = "pista.png"
		
	method choqueConPlayer(){}
	method mover(){
		if(self.position().distance(initialPosition)==6){
			self.position(initialPosition)
		}
		else{self.caer()}
	}
}
class ParedHorizontal{
	
	var property position
	
	const valor = 0

	method soyPlayer() = false
	
	method choqueConPlayer(){
		auto.horizontal(valor)
	}
	method choqueConAutoAmarillo(algo){
		algo.position(algo.position().right(valor))
	}
					
}


class ParedVertical inherits ParedHorizontal{
	
	override method choqueConPlayer(){
		auto.vertical(valor)
	}
	override method choqueConAutoAmarillo(algo){
	}
	method recibirBala(){}
	
}

class Corazon{
	const property image
	const property position
}

