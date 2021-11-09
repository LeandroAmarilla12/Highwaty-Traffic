import wollok.game.*
import Autos.*
import Fondo.*

object puntaje {

	var property puntos = 0

	method sumarPuntos(puntosSumados) {
		puntos = (puntos + puntosSumados).max(0)
	}

}

class Numero {

	method valor()

	method image() {
		return "Puntaje/" + (self.valor().stringValue()) + ".png"
	}

}

object centena inherits Numero {

	var property position = game.at(11, 8)

	override method valor() = puntaje.puntos().div(100)

}

object decena inherits Numero {

	var property position = game.at(12, 8)

	override method valor() = (puntaje.puntos() - centena.valor() * 100).div(10)

}

object unidad inherits Numero {

	var property position = game.at(13, 8)

	override method valor() = (puntaje.puntos() - centena.valor() * 100) - decena.valor() * 10

}

