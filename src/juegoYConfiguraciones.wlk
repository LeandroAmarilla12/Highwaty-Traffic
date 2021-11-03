import wollok.game.*
import autos.*
import puntaje.*
import Fondo.*
import objetosEnLaPista.*


object juego{
	const property enemigos = []
	const pared = []
	const property aceite =[]
	const property llaves = []
	var property balasDeTanque = []
	var property balasDePlayer = []
	
	method iniciar(){
		
		self.configurarTablero()
		
		game.addVisual(pista) // agrego primero para que este debajo de todo
	
		self.agregarPlayer()
		
		self.agregarPuntaje()
		
		game.addVisual(vida)
		
		game.onTick(30, "objetos cayendo", {self.objetosQueCaen()}) //hacer caer objetos

		self.crearEnemigos()
		
		self.agregarBordesDeRuta()
		
		//Tanque
		self.etapaFinal()
	}
	
	method configurarTablero(){
		game.title("TP")
		game.height(60)
		game.width(60)
		game.ground("mapita.png")
		game.cellSize(10)
	}
	
	method agregarPlayer(){
		game.addVisualCharacter(auto)
		game.onCollideDo(auto, {algo => auto.chocarCon(algo)})
		keyboard.space().onPressDo { auto.disparar() }
	}
	
	method agregarPuntaje(){
		game.addVisual(centena)
		game.addVisual(decena)
		game.addVisual(unidad)
	}
	
	method objetosQueCaen(){
		pista.mover() 
		self.todosLosObjetos().forEach{objeto => objeto.caer()}
	}
	
	method todosLosObjetos(){
		return enemigos + aceite + balasDeTanque + balasDePlayer + llaves
	}
	
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
	method crearEnemigos(){
		game.onTick(3000,"Crear enemigo auto amarillo", {self.aparecerEnemigo(new AutoAmarillo(position = game.at(4.randomUpTo(29),game.height()+2), todosLosEnemigos=enemigos), enemigos)})
		game.onTick(6000,"Crear nueva mancha de aceite", {self.aparecerEnemigo(new ManchaAceite(position = game.at(2.randomUpTo(29),game.height()+2), todosLosEnemigos = aceite), aceite)})
		game.onTick(20000,"Crear nueva llave reparadora", {self.aparecerEnemigo(new Reparador(position = game.at(2.randomUpTo(29),game.height()+2), todosLosEnemigos = llaves), llaves)})
	}
	method agregarBordesDeRuta(){
		self.crearParedIzquierda()
		self.crearParedDerecha()
		pared.forEach({unaPared => game.addVisual(unaPared)})
		game.onTick(80,"paredes reiniciado",{pared.forEach{unaPared => unaPared.subir()}})
	}
	
	method etapaFinal(){
		game.schedule(3000, {self.removerAcciones()})
		game.schedule(5000,{self.accionesTanque()})
	}
	
	method removerAcciones(){
		game.removeTickEvent("Crear enemigo auto amarillo")
		game.removeTickEvent("Crear nueva mancha de aceite")
		game.removeTickEvent("Crear nueva llave reparadora")
	}
	method accionesTanque(){					
		game.addVisual(tanque) 
		game.onCollideDo(tanque, {algo => tanque.chocarCon(algo)})
		game.onTick(100,"accion tanque",{tanque.mover() tanque.disparar()})
	}
}

