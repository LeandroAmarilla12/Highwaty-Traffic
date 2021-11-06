import wollok.game.*
import autos.*
import puntaje.*
import Fondo.*
import juegoYConfiguraciones.*


object menu{
	method image() = "menu.png"
	method position() = game.at(0,0)
	method iniciar(){
		self.configurarTablero()
		self.iniciarJuego()
	}
	
	method configurarTablero(){
		game.title("TP")
		game.height(12)
		game.width(15)
		game.cellSize(50)
		game.addVisual(self)
	}
	
	method iniciarJuego(){
		keyboard.enter().onPressDo{juego.iniciar()}
	}
}
