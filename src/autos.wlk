import wollok.game.*
import puntaje.*
import Fondo.*
import juegoYConfiguraciones.*
import objetosEnLaPista.*


object auto{
	var property vida = 100
	var property position = game.center()
	var property image = "auto.png"
	
	method soyPlayer() = true
	method image() = image
	
	method crearContorno() = 0
	
	method meMori() = vida <=0
	
	method chocarCon(algo){
		algo.choqueConPlayer()
	}
	
}

class EnemigoAuto inherits ObjetoEnLaPista(imagen = "enemy1.png", valorXDesaparecer = 10){
	override method choqueConPlayer(){
		auto.vida(auto.vida()-25)
		super()
	}
}

object tanque{
	var property position= game.at(5,40)
	var valor = 1
	method soyPlayer() = false
	method image() = "tanque.png"
	method choqueConPlayer(){
		//pantalla GAME OVER
	}
	method chocarCon(algo){
		if(algo.soyPlayer()){/*nada*/}
		else algo.choqueConTanque()
	}
	method mover(){
		self.position(self.position().right(valor))
		if (self.position().x()<=5 or self.position().x()>=30){
			valor = valor*-1
		}
	}
}


