import wollok.game.*
import puntaje.*
import Fondo.*
import juego.*
import objetosEnLaPista.*
import gameManager.*


object auto{
	var property position = game.at(3,3)
	//var posicionAux = self.position()
	var property image = "player.png"
	var property balas = 10  
	const property bloque = new BloqueInvisible(position = self.position().up(1) , duenio = self)
	
	method vertical(sentido){
		self.position(self.position().up(sentido))
		
		bloque.position(bloque.position().up(sentido))
	}
	method horizontal(sentido){
		self.position(self.position().right(sentido))
		
		bloque.position(bloque.position().right(sentido))
	}
	method soyPlayer() = true
	method image() = image
	
	method crearContorno() = 0
	
	method meMori() = vida.cantidad() <= 0
	
	method chocarCon(algo){
		algo.choqueConPlayer()
		if(vida.cantidad()<=0){gameManager.perdio()}
	}
	
	method choqueConPlayer(){}
	
	method disparar(){
	
		if(balas>0){
			juego.aparecerEnemigo(new BalaDePlayer(position = self.position().up(2) , coleccion = juego.balasDePlayer()), juego.balasDePlayer())
			balas-=1
		}
		else {game.say(self, "Encontrá municiones!!") }
	}
	
}

class AutoAmarillo inherits ObjetoEnLaPista(imagen = "enemigo1.png", valorXDesaparecer = 10 , soyAutoAmarillo=true){

	const property bloque = new BloqueInvisible(position = self.position().up(1) , duenio = self)
	override method caer(){
		bloque.position(bloque.position().down(1))
		super()
		
	}
	override method removerObjeto(){
		super()
		game.removeVisual(bloque)
	}
	override method choqueConPlayer(){
		vida.cantidad(vida.cantidad()-1)
		super()
	}
	method chocarCon(algo){
		if(algo.soyPlayer()){/*nada*/}
		else algo.choqueConAutoAmarillo(self)		
	}
}

object tanque{
	const property bloques =[]
	var property position= game.at(4,9)
	var valor = 1
	var property vida = 10
	//method soyPlayer() = false
	
	method crearBloques(){
		bloques.add(new BloqueInvisible(position = self.position().up(1).right(1) , duenio = self))
		bloques.add(new BloqueInvisible(position = self.position().right(1) , duenio = self))
		bloques.add(new BloqueInvisible(position = self.position().up(1) , duenio = self))
		bloques.forEach({bloque=>game.addVisual(bloque)})
	}
	
	method image() = "tanque.png"
	method choqueConPlayer(){
		//pantalla GAME OVER
	}
	method chocarCon(algo){
		if(algo.soyPlayer()){/*nada*/}
		else algo.choqueConTanque()
	}
	method recibirDanio(){
		self.vida(self.vida()-1)
		if(self.vida()<=0){gameManager.gano()}
	}
	
	method choqueConTanque(){}
	method mover(){
		self.position(self.position().right(valor))
		bloques.forEach({bloque=>bloque.position(bloque.position().right(valor))})
		if (self.position().x()<=1 or self.position().x()>=7){
			valor = valor*-1
		}
	}
	method disparar(){
		if(1.randomUpTo(20)>10) juego.aparecerEnemigo(new BalaDeTanque(position = self.position().down(1) , coleccion = juego.balasDeTanque()), juego.balasDeTanque())
	}
}


