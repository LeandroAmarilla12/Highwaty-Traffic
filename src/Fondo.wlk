import wollok.game.*
import Autos.*
import Juego.*
import Objetos.*

object fondo inherits ElementoMovil(position = game.at(0, 0)) {

	const initialPosition = game.at(0, 0)

	method image() = "Fondo/fondo.png"

	method choqueConPlayer() {
	}

	method mover() {
		if (self.position().distance(initialPosition) == 37) {
			self.position(initialPosition)
		} else {
			self.caer()
		}
	}

}

object cartel {

	method position() = game.at(10, 7)

	method image() = "Menus/cartelVacio.png"

}

object cantidadBala {

	method position() = game.at(12, 9)

	method image() = "Puntaje/" + auto.balas() + ".png"

}

class ParedHorizontal {

	var property position
	const valor = 0

	method soyPlayer() = false

	method choqueConPlayer() {
		auto.horizontal(valor)
	}

	method choqueConAutoAmarillo(algo) {
		algo.position(algo.position().right(valor))
	}

}

class ParedVertical inherits ParedHorizontal {

	override method choqueConPlayer() {
		auto.vertical(valor)
	}

	override method choqueConAutoAmarillo(algo) {
	}

	method recibirBala(unaBala) {
	}

}

