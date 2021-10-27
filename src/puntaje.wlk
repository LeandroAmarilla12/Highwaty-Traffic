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
	var property position= game.at(20,30)
	override method valor() = puntaje.verPuntos().div(100)
	
}
object decena inherits Numero{
	var property position= game.at(21,30)
	override method valor() = (puntaje.verPuntos()-centena.valor()*100).div(10)
	
}
object unidad inherits Numero{
	var property position= game.at(22,30)
	override method valor() = (puntaje.verPuntos()-centena.valor()*100)-decena.valor()*10
	
}