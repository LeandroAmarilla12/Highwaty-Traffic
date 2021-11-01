import wollok.game.*
import autos.*
import juegoYConfiguraciones.*
import objetosEnLaPista.*

object pista inherits ElementoMovil(position = game.at(2,0)){
	const initialPosition = game.at(2,0)

	method image() = "pista.png"
		
	
	method mover(){
		if(self.position().distance(initialPosition)==20){
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

