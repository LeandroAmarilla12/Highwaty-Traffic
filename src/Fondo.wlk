import wollok.game.*
import autos.*
import juegoYConfiguraciones.*
import objetosEnLaPista.*

object pista inherits ElementoMovil(position = game.at(1,0)){
	const initialPosition = game.at(1,0)

	method image() = "pista.png"
		
	
	method mover(){
		if(self.position().distance(initialPosition)==6){
			self.position(initialPosition)
		}
		else{self.caer()}
	}
}
class Pared inherits ElementoMovil{
	
	const valor = 0

	method soyPlayer() = false
	
	
	
	method choqueConPlayer(){
		auto.horizontal(valor)
	}
	
	method subir(){
		if(self.position().y()<= -2){
			self.position(game.at(self.position().x(),game.height()+1))
		}
		else{self.caer()}
	}

					
}

class ParedIzquierda inherits Pared(valor = 1){	
	
	method image() =  "barreraIzquierda.png"
}

class ParedDerecha inherits Pared(valor = -1){
	
	method image() =  "barreraDerecha.png"
	
}

class Corazon{
	const property image
	const property position
}

object vida{
	var property cantidad = 4
	
	var property position = game.at(45,55)
	
	method image() =  "corazon"+cantidad.max(0)+".png"
}
