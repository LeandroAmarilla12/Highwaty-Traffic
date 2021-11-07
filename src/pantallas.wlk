import wollok.game.*
import autos.*
import puntaje.*
import Fondo.*
import juegoYConfiguraciones.*
object menu{
	var estoyEnMenu
	method image() = "menu.png"
	method position() = game.at(0,0)
	
	method iniciar(){
		estoyEnMenu=true
		self.configurarTablero()
		keyboard.enter().onPressDo{self.iniciarJuego()}
	}
	
	method iniciarJuego(){
		if(estoyEnMenu){
			game.removeVisual(self)
			estoyEnMenu=false
			juego.iniciar()
		}
	}
	method configurarTablero(){
		game.title("TP")
		game.height(12)
		game.width(15)
		game.cellSize(50)
		game.addVisual(self)
	}
}
object gameOver{
	var estoyEnGameOver
	
	method iniciar(){
		if(estoyEnGameOver){
			estoyEnGameOver=false
			game.removeVisual(self)
			menu.iniciar()
		}
	}
	
	method mostrarGameOver(){
		estoyEnGameOver=true
		juego.enemigos().clear()
		juego.pared().clear()
		juego.aceite().clear()
		juego.llaves().clear()
		juego.balasDeTanque().clear()
		juego.balasDePlayer().clear()
		juego.municiones().clear()
		game.clear()
		keyboard.m().onPressDo{self.iniciar()}
	}
}
