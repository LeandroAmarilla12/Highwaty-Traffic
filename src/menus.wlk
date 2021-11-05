import wollok.game.*
import autos.*
import puntaje.*
import Fondo.*
import juegoYConfiguraciones.*


object menu{

	
	method iniciar(){
		self.configurarTablero()
		self.iniciarJuego()
	}
	
	method configurarTablero(){
		game.title("TP")
		game.height(60)
		game.width(60)
		game.ground("mapita.png")
		game.cellSize(10)
	}
	
	method iniciarJuego(){
		keyboard.enter().onPressDo{juego.iniciar()}
	}
}
