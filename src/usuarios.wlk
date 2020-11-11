import chats.*

class Usuario {
	const memoria
	const chats = []
	const bloqueados = []
	method enviar(mensaje,receptor){
		self.validarEnvio(mensaje,receptor)
		self.agregarAlChat(mensaje,receptor)
		receptor.recibirMensaje(mensaje,self)
	}
	
	method validarEnvio(mensaje, receptor){
		if (not self.puedeEnviar(mensaje, receptor)) {
			self.error("No se puede enviar el mensaje")
		}
	}
	
	method puedeEnviar(mensaje, receptor) = 
		not receptor.tenesBloqueadoA(self) and 
		self.espacioSuficientePara(mensaje) and
		receptor.espacioSuficientePara(mensaje)
		
	method tenesBloqueadoA(quien) = bloqueados.contains(quien)
	
	method espacioSuficientePara(mensaje) = 
		self.espacioOcupado() + mensaje.peso() > memoria
		
	method espacioOcupado() = chats.sum {chat => chat.espacioOcupado()}
	
	method agregarAlChat(mensaje, receptor) {
		self.chatDe(receptor).agregarMensaje(mensaje)
	}
	
	method chatDe(receptor) = chats.findOrElse(
		{chat => chat.esCon(receptor)}, 
		{ self.nuevoChatCon(receptor) })
		
	method nuevoChatCon(receptor) = {
		// Sí! Acá tenemos un método que retorna y produce efecto.
		// Para no hacerlo, hay que usar un if en agregarAlChat, con un any y luego un find.
		// El findOrElse resuelve declarativamente eso, pero a costa de hacernos embarrarnos un toque.
		const chat = new Chat(receptor = receptor)
		chats.add(chat)
		return chat
	}
	
	method recibirMensaje(mensaje, emisor) {
		self.agregarAlChat(mensaje, emisor)
	}
		
	method chatsDestacados() = chats.sortedBy { unChat, otroChat => unChat.tieneMasMensajesQue(otroChat) }.take(5)
	
	method liberarEspacio() {
		chats.remove(self.chatMasPesadoNoDestacado())
	}
	
	method chatMasPesadoNoDestacado() = 
		chats.
		filter { chat => not self.esDestacado(chat)}.
		sortedBy { unChat, otroChat => unChat.pesaMasQue(otroChat) }.
		first()
	
	method esDestacado(chat) = self.chatsDestacados().contains(chat)
	
	method cantMensajesSinLeer() = chats.sum { chat => chat.cantMensajesSinLeer() }
}