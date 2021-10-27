import wollok.game.*
import puntaje.*
import Fondo.*
import juegoYConfiguraciones.*



object auto{
	var property position = game.center()
	
	method image() = "auto.png"
	
	method chocaPared(){
		if(!(self.position().x() >= 2 and self.position()<=32)){
			
		}
	}
	method chocarCon(param1) {
		//TODO: Código autogenerado 
	}
	
}

class Enemigo inherits ElementoMovil{
	var vida = 20
	const todosLosEnemigos = [] 
	
	method image() = "enemy1.png"
	// abstraer comportamiento comun con la pista
	
	method chocado() {vida -= 10}
	
	method destruir(){
		if(vida <= 0){game.removeVisual(self)}
	}
	
	method desaparece(){
		if(self.position().y() <= 0){
			game.removeVisual(self)
			todosLosEnemigos.remove(self)
			puntaje.sumarPuntos(99)
		}
	}
}


