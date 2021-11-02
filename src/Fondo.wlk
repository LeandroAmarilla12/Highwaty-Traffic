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
	var vida = ({auto.vida()})
	const property posicionCorazonPersonaje1 = game.at(50, 55)
	const property posicionCorazonPersonaje2 = game.at(51, 55)
	const property posicionCorazonPersonaje3 = game.at(52, 55)
	const property posicionCorazonPersonaje4 = game.at(53, 55)
	
	method mostrarVida(){
		self.removeVida(posicionCorazonPersonaje1,posicionCorazonPersonaje2,posicionCorazonPersonaje3,posicionCorazonPersonaje4)
		if (vida == 100){
			game.addVisual(new Corazon(image = "corazonCompleto.png",position = posicionCorazonPersonaje1))
			game.addVisual(new Corazon(image = "corazonCompleto.png",position = posicionCorazonPersonaje2))
			game.addVisual(new Corazon(image = "corazonCompleto.png",position = posicionCorazonPersonaje3))
			game.addVisual(new Corazon(image = "corazonCompleto.png",position = posicionCorazonPersonaje4))
		}
		if(vida == 75){
			game.addVisual(new Corazon(image = "corazonVacio.png",position = posicionCorazonPersonaje1))
			game.addVisual(new Corazon(image = "corazonCompleto.png",position = posicionCorazonPersonaje2))
			game.addVisual(new Corazon(image = "corazonCompleto.png",position = posicionCorazonPersonaje3))
			game.addVisual(new Corazon(image = "corazonCompleto.png",position = posicionCorazonPersonaje4))			
		}
		if(vida == 50){
			game.addVisual(new Corazon(image = "corazonVacio.png",position = posicionCorazonPersonaje1))
			game.addVisual(new Corazon(image = "corazonVacio.png",position = posicionCorazonPersonaje2))
			game.addVisual(new Corazon(image = "corazonCompleto.png",position = posicionCorazonPersonaje3))
			game.addVisual(new Corazon(image = "corazonCompleto.png",position = posicionCorazonPersonaje4))			
		}
		if(vida == 25){
			game.addVisual(new Corazon(image = "corazonVacio.png",position = posicionCorazonPersonaje1))
			game.addVisual(new Corazon(image = "corazonVacio.png",position = posicionCorazonPersonaje2))
			game.addVisual(new Corazon(image = "corazonVacio.png",position = posicionCorazonPersonaje3))
			game.addVisual(new Corazon(image = "corazonCompleto.png",position = posicionCorazonPersonaje4))	
		}
		if(vida == 0){
			game.addVisual(new Corazon(image = "corazonVacio.png",position = posicionCorazonPersonaje1))
			game.addVisual(new Corazon(image = "corazonVacio.png",position = posicionCorazonPersonaje2))
			game.addVisual(new Corazon(image = "corazonVacio.png",position = posicionCorazonPersonaje3))
			game.addVisual(new Corazon(image = "corazonVacio.png",position = posicionCorazonPersonaje4))			
		}
	}
	
	method removeVida(posicionCorazon1, posicionCorazon2, posicionCorazon3,posicionCorazon4) {
		game.getObjectsIn(posicionCorazon1).forEach({ visual => game.removeVisual(visual)})
		game.getObjectsIn(posicionCorazon2).forEach({ visual => game.removeVisual(visual)})
		game.getObjectsIn(posicionCorazon3).forEach({ visual => game.removeVisual(visual)})
		game.getObjectsIn(posicionCorazon4).forEach({ visual => game.removeVisual(visual)})
	}
}
