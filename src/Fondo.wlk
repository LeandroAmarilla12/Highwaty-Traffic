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



