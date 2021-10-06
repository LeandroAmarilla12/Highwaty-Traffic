import wollok.game.*

object pista{
	var property position = game.at(2,0)
	
	method image() = "pista.png"
	
	method mover(){
		position = self.position().down(1)
	}
}

object auto{
	var property position = game.center()
	
	method image() = "auto.png"
}
