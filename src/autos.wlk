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
		//Puntaje
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
			puntaje.sumarPuntos(100)
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

object centena{
	var property position= game.at(20,30)
	var property centena=puntaje.verPuntos()/100
	method image(){
		return (centena).toString()+".png"
	}
}
object decena{
	var property position= game.at(21,30)
	var property decena = (puntaje.verPuntos()-centena.centena()*100)/10
	method image(){
		return decena.toString()+".png"
	}
}
object unidad{
	var property position= game.at(22,30)
	var property unidad = (puntaje.verPuntos()-centena.centena()*100)-decena.decena()*10
	method image(){
		return unidad.toString()+".png"
	}
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
