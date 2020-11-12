class Notificacion {
	const property chat
	var property leida = false
	
	method leer() { leida = true }
}

class Chat {
	const property mensajes = []
	const participantes = []
	
	method espacioOcupado() = mensajes.sum {mensaje => mensaje.peso()}
	
	//
	method enviar(mensaje) {
		self.validarEnvio(mensaje)
		mensajes.add(mensaje)
		self.notificar()
	}
	
	method validarEnvio(mensaje){
		if (not self.puedeEnviar(mensaje)) {
			self.error("No se puede enviar el mensaje")
		}
	}
	
	method puedeEnviar(mensaje) = participantes.contains(mensaje.emisor())
		and participantes.all({usuario => usuario.espacioSuficientePara(mensaje)})
	

	//
	method mensajeMasPesado() = mensajes.max({m => m.peso()})
	
	//
	method notificar() {
		participantes.forEach({usuario => usuario.recibirNotificacion(new Notificacion(chat = self))})
	}
	
	//
	method contiene(texto) = mensajes.any({m => m.contiene(texto)})



}

class ChatPremium inherits Chat {
	const creador
	const permiso
	
	override method puedeEnviar(mensaje) = super(mensaje) && permiso.puedeEnviar(mensaje, creador)
}

object difusion {
	method puedeEnviar(mensaje, creador) = mensaje.emisor() == creador 
}

object reunion {
	method puedeEnviar(mensaje, creador) = true 
}

class Ahorro {
	const pesoMaximo
	
	method puedeEnviar(mensaje, creador) = mensaje.peso() < pesoMaximo 
}