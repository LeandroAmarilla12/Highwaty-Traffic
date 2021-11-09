import wollok.game.*

class SonidosEnLoop {

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

object cancion inherits SonidosEnLoop(audio = game.sound("Audio/Spyhunter.wav")) {

}

object motor inherits SonidosEnLoop(audio = game.sound("Audio/motorAuto.wav")) {

}

object sonido {
	var audio 
	method reproducir(sonido, volumen) {
	 	audio = game.sound(sonido)
		audio.volume(volumen)
		audio.play()
	}
	
	method pausar() {
		if (audio.played() and not audio.paused()) {
			audio.pause()
		}
	}
}

