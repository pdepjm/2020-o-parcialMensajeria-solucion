import chats.*

class Usuario {
	const memoria
	const chats = []
	const notificaciones = []
	
	method agregarChat(chat) { chats.add(chat) }
	
	// 
	method espacioSuficientePara(mensaje) = 
		self.espacioOcupado() + mensaje.peso() <= memoria
		
	method espacioOcupado() = chats.sum {chat => chat.espacioOcupado()}
	
	//
	method mensajesMasPesados() = chats.map({chat => chat.mensajeMasPesado()})
		
	//
	method recibirNotificacion(notificacion) { notificaciones.add(notificacion) }
	
	method leer(chat) {
		notificaciones.filter({n => n.chat() == chat}).forEach({n => n.leer()})
	}
	
	method notificacionesSinLeer() = notificaciones.filter({n => not n.leida()})
	
	//
	method liberarEspacio() {
		chats.forEach({c => c.liberar()})
	}
	
}