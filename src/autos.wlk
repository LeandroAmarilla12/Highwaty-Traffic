import wollok.game.*

object juego{
	const enemigos = []//= [new Enemigo(), new Enemigo(position = game.at())]
	
	method aparecerEnemigo(){ 
		const enemy = new Enemigo(position = game.at(2.randomUpTo(29),40))
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
		game.onTick(3000,"Crear enemigo nuevo", {self.aparecerEnemigo()})
		//game.onCollideDo(auto, { unEnemigo => unEnemigo.chocado() })
		game.onTick(5000,"eliminar enemigo",{enemigos.forEach{unEnemigo => unEnemigo.desaparece()}})
		// MOVERSE
		game.addVisualCharacter(auto)
	
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
	
	method image() = "enemy1.png"
	// abstraer comportamiento comun con la pista
	
	method chocado() {vida -= 10}
	
	method destruir(){
		if(vida <= 0){game.removeVisual(self)}
	}
	
	method desaparece(){if(self.position().y() <= 0){game.removeVisual(self)}}
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