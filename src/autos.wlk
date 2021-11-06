import wollok.game.*
import puntaje.*
import Fondo.*
import juegoYConfiguraciones.*
import objetosEnLaPista.*


object auto{
	var property position = game.at(3,3)
	//var posicionAux = self.position()
	var property image = "player.png"
	var property cancelarDisparo = 5
	const property bloques =[]
	/* 
	method crearBloques(){
		self.crearALaIzquierda(2, 3)
		bloques.forEach({bloque=>game.addVisual(bloque)})
	}
	method crearALaIzquierda(cuantosIzquierda, cuantosAbajo){
			cuantosIzquierda.times({i=>self.crearAbajo(cuantosAbajo)})
		}
		
	method crearAbajo(cuantosAbajo){
		cuantosAbajo.times({i=>bloques.add(new BloqueInvisible(position=posicionAux.up(i)))})
		posicionAux=posicionAux.right(1)
	}*/
	
	method vertical(sentido){
		self.position(self.position().up(sentido))
		//mover bloques
		bloques.forEach({bloque=>bloque.position(bloque.position().up(sentido))})
	}
	method horizontal(sentido){
		self.position(self.position().right(sentido))
		//mover bloques
		bloques.forEach({bloque=>bloque.position(bloque.position().right(sentido))})
	}
	method soyPlayer() = true
	method image() = image
	
	method crearContorno() = 0
	
	method meMori() = vida.cantidad() <= 0
	
	method chocarCon(algo){
		algo.choqueConPlayer()
	}
	
	method choqueConPlayer(){}
	
	method disparar(){
		if(cancelarDisparo>0){
			juego.aparecerEnemigo(new BalaDePlayer(position = self.position().up(1) , todosLosEnemigos = juego.balasDePlayer()), juego.balasDePlayer(),3,3)
			self.cancelarDisparo(self.cancelarDisparo()-1)
		}
	}
	
}

class AutoAmarillo inherits ObjetoEnLaPista(imagen = "enemigo1.png", valorXDesaparecer = 10){
	override method choqueConPlayer(){
		vida.cantidad(vida.cantidad()-1)
		super()
	}
}

object tanque{
	const property bloques =[]
	var property position= game.at(4,9)
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
	
	method choqueConTanque(){}
	method mover(){
		self.position(self.position().right(valor))
		bloques.forEach({bloque=>bloque.position(bloque.position().right(valor))})
		if (self.position().x()<=2 or self.position().x()>=5){
			valor = valor*-1
		}
	}
	method disparar(){
		if(1.randomUpTo(20)>10) juego.aparecerEnemigo(new BalaDeTanque(position = self.position().right(1).down(1) , todosLosEnemigos = juego.balasDeTanque()), juego.balasDeTanque(),0,0)
	}
}


