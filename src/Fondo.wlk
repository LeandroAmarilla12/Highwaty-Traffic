import wollok.game.*

object pista{
	const initialPosition = game.at(2,0)
	var property position = initialPosition
	
	method image() = "pista.png"
	
	method mover(){
		if(self.position().distance(initialPosition)==20){
		position = initialPosition
		}
		else position = self.position().down(1)
	}
}

object auto{
	var property position = game.center()
	
	method image() = "auto.png"
}
