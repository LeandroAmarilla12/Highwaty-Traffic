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
	var property segundos = 0
	
	var posicionAux 
	
	method crearBloques(aLaDer,arriba,objeto){
		posicionAux=objeto.position()
		self.crearALaDerecha(aLaDer,arriba,objeto)
		objeto.bloques().forEach({bloque=>game.addVisual(bloque)})
	}
	method crearALaDerecha(aLaDer, arriba,objeto){
			aLaDer.times({i=>self.crearArriba(arriba,objeto)})
	}
	method crearArriba(cuantosArriba,objeto){
		cuantosArriba.times({i=>objeto.bloques().add(new BloqueInvisible(position=posicionAux.up(i),duenio=objeto))})
		posicionAux=posicionAux.right(1)
		objeto.bloques().add(new BloqueInvisible(position=posicionAux.left(1),duenio=objeto))
	}
	
	method iniciar(){
		
		self.configurarTablero()
		
		game.addVisual(pista) // agrego primero para que este debajo de todo
	
		self.agregarBordesDeRuta()
		
		self.agregarPlayer()
		
		self.agregarPuntaje()

		game.addVisual(vida)
		
//<<<<<<< HEAD
		game.onTick(30, "objetos cayendo", {self.objetosQueCaen()}) //hacer caer objetos

		//self.crearEnemigos()
//=======
		self.crearEnemigos()
//>>>>>>> branch 'master' of git@github.com:algo1unsam/tpgame-los-perris.git
		
		game.onTick(30, "objetos cayendo", {self.objetosQueCaen()}) //hacer caer objetos
		
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
		game.addVisual(auto)
		game.onCollideDo(auto, {algo => auto.chocarCon(algo)})
		keyboard.space().onPressDo { auto.disparar() }
		self.movimientoAuto()
		self.crearBloques(2,3,auto)
		auto.bloques().forEach({bloque=>game.onCollideDo(bloque, {algo => bloque.chocarCon(algo)})})
	}
	
	method movimientoAuto(){
		keyboard.up().onPressDo { auto.vertical(1) }
		keyboard.down().onPressDo { auto.vertical(-1) }
		keyboard.right().onPressDo { auto.horizontal(1) }
		keyboard.left().onPressDo { auto.horizontal(-1) }
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
	
	method aparecerEnemigo(algo, coleccion,izq,arriba){ 
		const enemy = algo
		coleccion.add(enemy)
		game.addVisual(enemy)
		self.crearBloques(izq,arriba,algo)
	}
	
	method crearParedIzquierda(){
		(game.height()/2+2).times({i => pared.add(new ParedIzquierda(position = game.at(2,i*2 -2)))})	
	
	}
	
	method crearParedDerecha(){
		(game.height()/2+2).times({i => pared.add(new ParedDerecha(position = game.at(40,i*2 -2)))})	
	}
	
	method crearEnemigos(){
		game.onTick(3000,"Crear enemigo auto amarillo", {self.aparecerEnemigo(new AutoAmarillo(position = game.at(4.randomUpTo(29),game.height()+2), todosLosEnemigos=enemigos),enemigos,2,4)}) 
		game.onTick(6000,"Crear nueva mancha de aceite", {self.aparecerEnemigo(new ManchaAceite(position = game.at(2.randomUpTo(29),game.height()+2), todosLosEnemigos = aceite), aceite,2,2)})
		game.onTick(20000,"Crear nueva llave reparadora", {self.aparecerEnemigo(new Reparador(position = game.at(2.randomUpTo(29),game.height()+2), todosLosEnemigos = llaves), llaves,3,3)})
		
	}
	method agregarBordesDeRuta(){
		self.crearParedIzquierda()
		self.crearParedDerecha()
		pared.forEach({unaPared => game.addVisual(unaPared)})
		game.onTick(80,"paredes reiniciado",{pared.forEach{unaPared => unaPared.subir()}})
	}
	
	method etapaFinal(){
		game.schedule(30000, {self.removerAcciones()})
		game.schedule(35000,{self.accionesTanque()})
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
		self.crearBloques(8,14,tanque)
	}
	//method sumarSegundos() {
	//	segundos+=1
	//}
}

