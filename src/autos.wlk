import wollok.game.*
import puntaje.*
import Fondo.*
import juegoYConfiguraciones.*
import objetosEnLaPista.*


object auto{
	var property vida = 100
	var property position = game.center()
	var property image = "auto.png"
	
	method image() = image
	
	method crearContorno() = 0
	
	method meMori() = vida <=0
	
}



class EnemigoAuto inherits ObjetoEnLaPista(imagen = "enemy1.png", valorXDesaparecer = 10){
	
}

object tanque{
	const property position= game.center()
	method image() = "tanque.png"
	
	method disparar() = game.addVisual(new Bala(position = self.position().down(1)))
	
}


