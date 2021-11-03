import wollok.game.*
import puntaje.*
import Fondo.*
import juegoYConfiguraciones.*
import objetosEnLaPista.*


object auto{
	var property position = game.center()
	var property image = "auto.png"
	
	method soyPlayer() = true
	method image() = image
	
	method crearContorno() = 0
	
	method meMori() = vida.cantidad() <= 0
	
	method chocarCon(algo){
		algo.choqueConPlayer()
	}
	
	method disparar(){
		juego.aparecerEnemigo(new BalaDePlayer(position = self.position().up(2) , todosLosEnemigos = juego.balasDePlayer()), juego.balasDePlayer())
	}
	
}

class AutoAmarillo inherits ObjetoEnLaPista(imagen = "enemy1.png", valorXDesaparecer = 10){
	override method choqueConPlayer(){
		vida.cantidad(vida.cantidad()-1)
		super()
	}
}

object tanque{
	var property position= game.at(5,40)
	var valor = 1
	var property vida = 10
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
	method disparar(){
		if(1.randomUpTo(20)>=15) juego.aparecerEnemigo(new BalaDeTanque(position = self.position().right(3).down(2) , todosLosEnemigos = juego.balasDeTanque()), juego.balasDeTanque())
	}
}


