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
		keyboard.c().onPressDo{ self.creditos()}
		keyboard.p().onPressDo{ self.controles()}
	}

	method perdio() {
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
		auto.balas(10)
		auto.position(game.at(5, 2))
		auto.bloque().position(game.at(5, 3))
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
	
	method controles() {
		game.clear()
		self.limpiarJuego()
		game.addVisual(controles)
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
object controles {

	method image() = "controls.png"

	method position() = game.at(0, 0)

}

