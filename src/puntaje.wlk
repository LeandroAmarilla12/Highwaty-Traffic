import wollok.game.*
import autos.*
import Fondo.*

object puntaje{
	var puntos = 0
	
	method verPuntos() = puntos
	method sumarPuntos(puntosSumados){
		puntos+=puntosSumados
	}
}


class Numero{
	method valor()
	method image(){
		return self.valor().stringValue()+".png"
	}
}
object centena inherits Numero{
	var property position= game.at(50,50)
	override method valor() = puntaje.verPuntos().div(100)
	
}
object decena inherits Numero{
	var property position= game.at(51,50)
	override method valor() = (puntaje.verPuntos()-centena.valor()*100).div(10)
	
}
object unidad inherits Numero{
	var property position= game.at(52,50)
	override method valor() = (puntaje.verPuntos()-centena.valor()*100)-decena.valor()*10
	
}


