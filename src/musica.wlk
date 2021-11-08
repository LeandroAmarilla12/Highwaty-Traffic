import wollok.game.*

class sonidosEnLoop {

	var audio

	method reproducir(volumen) {
		audio.shouldLoop(true)
		audio.volume(volumen)
		if (audio.played()) {
			audio.resume()
		} else audio.play()
	}

	method pausar() {
		if (audio.played() and not audio.paused()) {
			audio.pause()
		}
	}

}

object cancion inherits sonidosEnLoop(audio = game.sound("Spyhunter.wav")) {

}

object motor inherits sonidosEnLoop(audio = game.sound("motorAuto.wav")) {

}

object sonido {

	method reproducir(sonido, volumen) {
		var audio = game.sound(sonido)
		audio.volume(volumen)
		audio.play()
	}

}

