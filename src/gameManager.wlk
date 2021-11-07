import wollok.game.*
import autos.*
import puntaje.*
import Fondo.*
import juego.*

object gameManager {

	method configurarTablero() {
		game.title("TP")
		game.height(12)
		game.width(15)
		game.cellSize(50)
	}

	method mostrarMenu() {
		if (!game.hasVisual(menu)) game.addVisual(menu)
		keyboard.enter().onPressDo{ juego.iniciar()}
		keyboard.c().onPressDo{self.creditos()}
	}
	
	method perdio(){
		game.clear()
		self.limpiarJuego()
		game.addVisual(perder)
		keyboard.m().onPressDo{ self.mostrarMenu()}
	}
	
	method limpiarJuego() {
		juego.enemigos().clear()
		juego.pared().clear()
		juego.aceite().clear()
		juego.llaves().clear()
		juego.balasDeTanque().clear()
		juego.balasDePlayer().clear()
		juego.municiones().clear()
		vida.cantidad(4)
		puntaje.puntos(0)
	}
	method gano() {
		game.clear()
		self.limpiarJuego()
		game.addVisual(ganar)
		keyboard.m().onPressDo{ self.mostrarMenu()}
	}
	method creditos() {
		game.clear()
		self.limpiarJuego()
		game.addVisual(creditos)
		keyboard.m().onPressDo{ self.mostrarMenu()}
	}
}

object menu {

	method image() = "menu.png"

	method position() = game.at(0, 0)

}

object ganar {
	
	method image() = "win.png"

	method position() = game.at(0, 0)
}

object perder {
	
	method image() = "gameOver.png"

	method position() = game.at(0, 0)
}

object creditos {
	
	method image() = "credits.png"

	method position() = game.at(0, 0)
}
