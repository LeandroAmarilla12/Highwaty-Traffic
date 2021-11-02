import wollok.game.*
import autos.*
import puntaje.*
import Fondo.*
import objetosEnLaPista.*


object juego{
	const property enemigos = []//= [new Enemigo(), new Enemigo(position = game.at())]
	const pared = []
	const property aceite =[]
	const property llaves = []
	var property balas = []
	
	var tiempQueSeCreanEnemigos=3000
	
	method aparecerEnemigo(algo, coleccion){ 
		const enemy = algo
		coleccion.add(enemy)
		game.addVisual(enemy)
	}
	
	
	method crearParedIzquierda(){
		(game.height()/2+2).times({i => pared.add(new ParedIzquierda(position = game.at(2,i*2 -2)))})	
	
	}
	method crearParedDerecha(){
		(game.height()/2+2).times({i => pared.add(new ParedDerecha(position = game.at(40,i*2 -2)))})	
	}
	
	
	method iniciar(){
		//	CONFIG	
		game.title("TP")
		game.height(60)
		game.width(60)
		game.ground("mapita.png")
		game.cellSize(10)
		
		
		
		// FONDO
		game.addVisual(pista)
		game.onTick(30, "pista moviendose", { pista.mover() })
		game.onTick(1,"Mostrar Corazones",{vida.mostrarVida()})
		
		
		// Enemigos
		game.onTick(30,"enemigo moviendose", { enemigos.forEach{unEnemigo => unEnemigo.caer()}})
		game.onTick(tiempQueSeCreanEnemigos,"Crear enemigo nuevo", {self.aparecerEnemigo(new EnemigoAuto(position = game.at(4.randomUpTo(29),game.height()+2), todosLosEnemigos=enemigos), enemigos)})
		//Manchas De Aciete
		game.onTick(30,"mancha moviendose", { aceite.forEach{unEnemigo => unEnemigo.caer()}})
		game.onTick(tiempQueSeCreanEnemigos*2,"Crear nueva mancha de aceite", {self.aparecerEnemigo(new ManchaAceite(position = game.at(2.randomUpTo(29),game.height()+2), todosLosEnemigos = aceite), aceite)})
		//Llaves
		game.onTick(30,"llaves moviendose", { llaves.forEach{unaLlave => unaLlave.caer()}})
		game.onTick(20000,"Crear nueva llave reparadora", {self.aparecerEnemigo(new Reparador(position = game.at(2.randomUpTo(29),game.height()+2), todosLosEnemigos = llaves), llaves)})
		
	
		//game.onCollideDo(auto, { unEnemigo => unEnemigo.chocado() })
		game.onTick(500,"eliminar enemigo",{enemigos.forEach{unEnemigo => unEnemigo.desaparece()}})
		game.onTick(500,"eliminar manchas",{aceite.forEach{unaMancha => unaMancha.desaparece()}})
		game.onTick(500,"eliminar llaves",{llaves.forEach{unaLlave => unaLlave.desaparece()}})
		game.onTick(500,"eliminar balas",{balas.forEach{unaBala => unaBala.desaparece()}})
		
		// MOVERSE
		game.addVisualCharacter(auto)
		
		//Puntaje
		//game.say(auto, puntaje.verPuntos())
		game.addVisual(centena)
		game.addVisual(decena)
		game.addVisual(unidad)
		
		
		//PAREDES
		self.crearParedIzquierda()
		self.crearParedDerecha()
		pared.forEach({unaPared => game.addVisual(unaPared)})
		game.onTick(80,"paredes reiniciado",{pared.forEach{unaPared => unaPared.subir()}})
		
		// crear un objeto para controlar a los enemigos (objeto corredores, rivales) 		
		
		//Tanque
		
		//COLISIONES
		game.onCollideDo(auto, {algo => auto.chocarCon(algo)})
		game.onTick(10, "", {self.peleaTanque()})
		
	}
	method peleaTanque(){
			if(puntaje.verPuntos()>40){
				//>>>game.addVisual(tanque)<<<//
				game.onTick(10,"movimiento tanque",{tanque.mover()})
				game.onTick(5000,"tanque dispara", {self.aparecerEnemigo(new Bala(position = tanque.position() , todosLosEnemigos = balas), balas)})
				game.onTick(5,"bala moviendose",{balas.forEach{unaBala => unaBala.caer()}})
				game.onCollideDo(tanque, {algo => tanque.chocarCon(algo)})
			}
	}
}

class ElementoMovil{
	var property position 
	
	method caer(){
		position = self.position().down(1)
	}
	
}


