import wollok.game.*
import Autos.*
import Puntaje.*
import Fondo.*
import Objetos.*
import GameManager.*
import Musica.*

object juego {

	var batallaFinal = true
	const property enemigos = []
	const property pared = []
	const property aceite = []
	const property llaves = []
	var property balasDeTanque = []
	var property balasDePlayer = []
	const property municiones = []
	var property segundos = 0

	method iniciar() {
		game.clear()
		self.prepararFondo()
		self.agregarBordesDeRuta()
		self.agregarPlayer()
		self.agregarPuntaje()
		game.addVisual(vida)
		self.crearEnemigos()
		game.onTick(100, "objetos cayendo", { self.objetosQueCaen()}) // hacer caer objetos
			// Tanque
		self.etapaFinal()
	}

	method prepararFondo() {
		game.addVisual(fondo)
		game.addVisual(cartel)
		game.addVisual(cantidadBala)
	}

	method agregarBordesDeRuta() {
		self.crearParedes()
		pared.forEach({ unaPared => game.addVisual(unaPared)})
	}

	method agregarPlayer() {
		game.addVisual(auto)
		game.onCollideDo(auto, { algo => auto.chocarCon(algo)})
		keyboard.space().onPressDo{ auto.disparar()}
		self.movimientoAuto()
		game.addVisual(auto.bloque())
		game.onCollideDo(auto.bloque(), { algo => auto.chocarCon(algo)})
		motor.reproducir(0.3)
	}

	method movimientoAuto() {
		keyboard.up().onPressDo{ auto.vertical(1)}
		keyboard.down().onPressDo{ auto.vertical(-1)}
		keyboard.right().onPressDo{ auto.horizontal(1)}
		keyboard.left().onPressDo{ auto.horizontal(-1)}
	}

	method agregarPuntaje() {
		game.addVisual(centena)
		centena.position(game.at(11, 8))
		game.addVisual(decena)
		decena.position(game.at(12, 8))
		game.addVisual(unidad)
		unidad.position(game.at(13, 8))
	}

	method crearEnemigos() {
		game.onTick(1000, "Crear enemigo auto azul", { self.aparecerEnemigo(new AutoAzul(position = game.at(2.randomUpTo(10), game.height()), coleccion = enemigos), enemigos)})
		game.onTick(6000, "Crear nueva mancha de aceite", { self.aparecerEnemigo(new ManchaAceite(position = game.at(2.randomUpTo(10), game.height()), coleccion = aceite), aceite)})
		game.onTick(15000, "Crear nueva llave reparadora", { self.aparecerEnemigo(new Reparador(position = game.at(2.randomUpTo(10), game.height()), coleccion = llaves), llaves)})
		game.onTick(30000, "Crear nueva municion", { self.aparecerEnemigo(new Municion(position = game.at(2.randomUpTo(10), game.height()), coleccion = municiones), municiones)})
	}

	method aparecerEnemigo(algo, coleccion) {
		const enemy = algo
		coleccion.add(enemy)
		game.addVisual(enemy)
		if (enemy.soyAutoAzul()) {
			game.addVisual(enemy.bloque())
		}
	}

	method objetosQueCaen() {
		fondo.mover()
		self.todosLosObjetos().forEach{ objeto => objeto.caer()}
	}

	method todosLosObjetos() {
		return enemigos + aceite + balasDeTanque + balasDePlayer + llaves + municiones
	}

	method crearParedes() {
		(game.height() + 2).times({ i => pared.add(new ParedHorizontal(position = game.at(1, i - 1), valor = 1))})
		(game.height() + 2).times({ i => pared.add(new ParedHorizontal(position = game.at(10, i - 1), valor = -1))})
		(8).times({ i => pared.add(new ParedVertical(position = game.at(i, 12), valor = -1))})
		(8).times({ i => pared.add(new ParedVertical(position = game.at(i, -1), valor = 1))})
	}

	method etapaFinal() {
		game.schedule(50000, { self.prepararBatallaFinal()})
		game.schedule(55000, { self.accionesTanque()})
	}

	method prepararBatallaFinal() {
		game.removeTickEvent("Crear enemigo auto azul")
		game.removeTickEvent("Crear nueva mancha de aceite")
		game.removeTickEvent("Crear nueva llave reparadora")
		batallaFinal = false
	}

	method accionesTanque() {
		game.addVisual(tanque)
		game.onCollideDo(tanque, { algo => tanque.chocarCon(algo)})
		game.onTick(300, "accion tanque", { tanque.mover()
			tanque.disparar()
		})
		tanque.crearBloques()
	}

}

