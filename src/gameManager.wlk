import wollok.game.*
import autos.*
import puntaje.*
import Fondo.*
import juego.*
import musica.*

object gameManager {

	method configurarTablero() {
		game.title("TP")
		game.height(12)
		game.width(15)
		game.cellSize(50)
	}

	method mostrarMenu() {
		if (!game.hasVisual(menu)) game.addVisual(menu)
		game.schedule(1, { cancion.pausar()})
		game.schedule(2, { cancion.reproducir(0.5)})
		keyboard.enter().onPressDo{ juego.iniciar()}
		keyboard.num1().onPressDo{ self.controles()}
		keyboard.num2().onPressDo{ self.creditos()}
	}

	method perdio() {
		sonido.reproducir("gameOver.wav", 0.5)
		game.clear()
		self.pausarSonidos()
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
		sonido.reproducir("aplausos.wav", 0.5)
		self.limpiarJuego()
		game.clear()
		self.pausarSonidos()
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

	method pausarSonidos() {
		cancion.pausar()
		motor.pausar()
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

