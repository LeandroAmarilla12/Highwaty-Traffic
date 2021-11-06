import wollok.game.*
import autos.*
import puntaje.*
import Fondo.*
import juegoYConfiguraciones.*


object menu{

	method iniciar(){
		self.configurarTablero()
		//game.addVisual(pista)
		self.iniciarJuego()
	}
	
	method configurarTablero(){
		game.title("TP")
		game.height(12)
		game.width(12)
		game.ground("mapita.png")
		game.cellSize(50)
	}
	
	method iniciarJuego(){
		keyboard.enter().onPressDo{juego.iniciar()}
	}
}
