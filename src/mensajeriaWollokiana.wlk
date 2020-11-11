// Puntos de entrada
// Punto 1: unMensaje.peso()
// Punto 2: unUsuario.enviar(unMensaje, otroUsuario)
// Punto 3: unUsuario.chatsDestacados()
// Punto 4: unUsuario.liberarEspacio()
// Punto 5: unChat.abrir()
// Punto 6: unUsuario.cantMensajesSinLeer()

class Mensaje {
	const contenido
	var property leido = false
	
	method peso() = 5 + contenido.peso() * 1.3
	method serLeido() {
		leido = true
	}
}

/***** Contenidos ******/

class Texto {
	const elTexto
	method peso() = elTexto.size()
}

class Audio {
	const duracion
	method peso() = duracion * 1.2
}

class Contacto {
	const usuario
	method peso() = 3
}

class Imagen {
	const alto
	const ancho
	const modo = tamanioOriginal
	method peso() = modo.pixelesAEnviar(ancho * alto) * 2
}

object tamanioOriginal {
	method pixelesAEnviar(cant) = cant
}

class TamanioVariable {
	const porcentaje
	method pixelesAEnviar(cant) = cant * porcentaje
}

object tamanioReducido {
	method pixelesAEnviar(cant) = cant.min(10000)
}

class GIF inherits Imagen {
	const cantCuadros
	override method peso() = super() * cantCuadros
}


