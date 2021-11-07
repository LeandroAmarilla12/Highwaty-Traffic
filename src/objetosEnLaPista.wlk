import wollok.game.*
import autos.*
import puntaje.*
import Fondo.*
import juegoYConfiguraciones.*


class ElementoMovil{
	var property position
	
	method caer(){
		position = self.position().down(1)
	}
	
}

class ObjetoEnLaPista inherits ElementoMovil{
	var imagen 
	var property valorXDesaparecer 
	var estoyVivo=true
	var property soyAutoAmarillo=false
	
	const coleccion = [] 
	const property bloques =[]
	method soyPlayer() = false
	method image() = imagen
	
	override method caer(){
		super()
		self.desaparece()
		//bloques.forEach({bloque=>bloque.position(bloque.position().down(1))})
	}
	
	method desaparece(){
		if(self.position().y() <= -3 or self.position().y() >= game.height()+3){
			self.removerObjeto()
			
			
		}
	}
	
	method removerObjeto(){
		game.removeVisual(self)
		coleccion.remove(self)
		estoyVivo=false
		puntaje.sumarPuntos(valorXDesaparecer)
	}
	
	method choqueConTanque(){
		self.removerObjeto()
	}
	
	method choqueConPlayer(){
		self.removerObjeto()	
	}	
	
	method choqueConAutoAmarillo(algo){}
}

class ManchaAceite inherits ObjetoEnLaPista(imagen = "aceite.png", valorXDesaparecer = 0){	
//	override method chocarCon(unAuto){
//		 
//	}
	
	override method choqueConAutoAmarillo(algo){
		if(1.randomUpTo(10).truncate(0).even()){
			algo.position(algo.position().right(1))
		}
		else{
			algo.position(algo.position().left(1))
		}
	}
	override method choqueConPlayer(){
		self.desplazamientoAleatorio(auto)
	}
	
	method desplazamientoAleatorio(unAuto){
		const desplazamiento = 1.randomUpTo(10).truncate(0)
		if(desplazamiento.even()){
			unAuto.horizontal(1)
		}
		else{
			unAuto.horizontal(-1)
		}
		
	}
}

class Reparador inherits ObjetoEnLaPista(imagen = "llave.png", valorXDesaparecer = 0){
	override method choqueConPlayer(){
		if (vida.cantidad() < 4){			
			vida.cantidad(4)
			super()
		}
	}	
}

class Municion inherits ObjetoEnLaPista(imagen = "municiones.png", valorXDesaparecer = 0){
	override method choqueConPlayer(){
		if (auto.balas() == 0){			
			auto.balas(10)
			super()
		}
	}	
}

class BalaDeTanque inherits ObjetoEnLaPista(imagen = "balaTanque.png", valorXDesaparecer = 0){
	override method choqueConPlayer(){
		vida.cantidad(vida.cantidad()-2)
		super()
	}
	override method choqueConTanque(){}
	
	}
class BalaDePlayer inherits ObjetoEnLaPista(imagen = "balaPlayer.png", valorXDesaparecer = 0){
	override method choqueConTanque(){
		tanque.recibirDanio()
		super()
	}
	override method caer(){
		position = self.position().up(1)
		self.desaparece() 
	}
	override method choqueConPlayer(){
	}
	
	override method choqueConAutoAmarillo(algo){
		algo.valorXDesaparecer(20)
		algo.removerObjeto()
		self.removerObjeto() 
		
	}
	
	
}

class BloqueInvisible{
	var property position
	const property duenio
	method image() = "pixel.png"
	
	method chocarCon(algo){
		//duenio.chocarCon(algo)
		algo.choqueConPlayer()
	}
	
	method choqueConPlayer(){
		duenio.choqueConPlayer()	
	}
	method choqueConTanque(){
		duenio.choqueConTanque()	
	}
	method soyPlayer(){duenio.soyPlayer()}
	method soyAutoAmarillo(){duenio.soyAutoAmarillo()}
}

class BloqueInvisibleDePlayer inherits BloqueInvisible{
}

class BloqueInvisibleDeTanque inherits BloqueInvisible{
}

class BloqueInvisibleDeEnemigo inherits BloqueInvisible{
}
