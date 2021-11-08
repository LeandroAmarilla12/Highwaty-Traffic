import wollok.game.*
import autos.*
import Fondo.*

object puntaje {

	var property puntos = 0

	method sumarPuntos(puntosSumados) {
		puntos += puntosSumados
	}

}

class Numero {

	method valor()

	method image() {
		return self.valor().stringValue() + ".png"
	}

}

object centena inherits Numero {

	var property position = game.at(11, 9)

	override method valor() = puntaje.puntos().div(100)

}

object decena inherits Numero {

	var property position = game.at(12, 9)

	override method valor() = (puntaje.puntos() - centena.valor() * 100).div(10)

}

object unidad inherits Numero {

	var property position = game.at(13, 9)

	override method valor() = (puntaje.puntos() - centena.valor() * 100) - decena.valor() * 10

}

