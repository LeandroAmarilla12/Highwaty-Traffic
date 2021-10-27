import wollok.game.*

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
		game.onTick(5000,"eliminar enemigo",{enemigos.forEach{unEnemigo => unEnemigo.desaparece()}})
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
object puntaje{
	var puntos = 0
	
	method verPuntos() = puntos
	method sumarPuntos(puntosSumados){
		puntos+=puntosSumados
	}
}

class Numero{
	method valor()
	method image(){
		return self.valor().stringValue()+".png"
	}
}
object centena inherits Numero{
	var property position= game.at(20,30)
	override method valor() = puntaje.verPuntos().div(100)
	
}
object decena inherits Numero{
	var property position= game.at(21,30)
	override method valor() = (puntaje.verPuntos()-centena.valor()*100).div(10)
	
}
object unidad inherits Numero{
	var property position= game.at(22,30)
	override method valor() = (puntaje.verPuntos()-centena.valor()*100)-decena.valor()*10
	
}

object pista inherits ElementoMovil(position = game.at(2,0)){
	const initialPosition = game.at(2,0)

	method image() = "pista.png"
		
	
	method mover(){
		if(self.position().distance(initialPosition)==20){
		position = initialPosition
		}
		else{self.caer()}
	}
}
