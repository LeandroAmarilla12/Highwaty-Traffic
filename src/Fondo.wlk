import wollok.game.*
import autos.*
import juegoYConfiguraciones.*
import objetosEnLaPista.*

object pista inherits ElementoMovil(position = game.at(2,0)){
	const initialPosition = game.at(2,0)

	method image() = "pista.png"
		
	
	method mover(){
		if(self.position().distance(initialPosition)==32){
			self.position(initialPosition)
		}
		else{self.caer()}
	}
}
class Pared inherits ElementoMovil{
	
	const valor = 0

	method soyPlayer() = false
	
	method image() =  "rueda.png"
	
	
	method choqueConPlayer(){
		auto.position(auto.position().right(valor))
	}
	
	method subir(){
		if(self.position().y()<= -2){
			self.position(game.at(self.position().x(),game.height()+1))
		}
		else{self.caer()}
	}

					
}

class ParedIzquierda inherits Pared(valor = 3){	
}

class ParedDerecha inherits Pared(valor = -3){
	
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
