import wollok.game.*
import autos.*
import puntaje.*
import Fondo.*

object juego{
	const property enemigos = []//= [new Enemigo(), new Enemigo(position = game.at())]
	var tiempQueSeCreanEnemigos=3000
	
	method aparecerEnemigo(){ 
		const enemy = new Enemigo(position = game.at(2.randomUpTo(29),40) , todosLosEnemigos=enemigos)
		enemigos.add(enemy)
		game.addVisual(enemy)
	}
	
//	method malos(){enemigos.forEach{unEnemigo => game.addVisual(unEnemigo)}
	
	method iniciar(){
		//	CONFIG	
		game.title("TP")
		game.height(38)
		game.width(34)
		game.ground("mapita.png")
		game.cellSize(10)
		
		
		// FONDO
		game.addVisual(pista)
		game.onTick(30, "pista moviendose", { pista.mover() })
		
		// Enemigos
		game.onTick(30,"enemigo moviendose", { enemigos.forEach{unEnemigo => unEnemigo.caer()}})
		game.onTick(tiempQueSeCreanEnemigos,"Crear enemigo nuevo", {self.aparecerEnemigo()})
		//game.onCollideDo(auto, { unEnemigo => unEnemigo.chocado() })
		game.onTick(500,"eliminar enemigo",{enemigos.forEach{unEnemigo => unEnemigo.desaparece()}})
		// MOVERSE
		game.addVisualCharacter(auto)
		//game.onCollideDo(auto, { auto.chocarCon(game.colliders(auto))})
		//Puntaje
		//game.say(auto, puntaje.verPuntos())
		game.addVisual(centena)
		game.addVisual(decena)
		game.addVisual(unidad)
		
		// crear un objeto para controlar a los enemigos (objeto corredores, rivales) 		
	}
}

class ElementoMovil{
	var property position 
	
	method caer(){
		position = self.position().down(1)
	}
	
}


