class Chat {
	const mensajes = []
	const receptor
	
	method esCon(unReceptor) = unReceptor == receptor
	method agregarMensaje(mensaje) = mensajes.add(mensaje)
	method espacioOcupado() = mensajes.sum {mensaje => mensaje.peso()}
	method tieneMasMensajesQue(otro) = self.cantMensajes() > otro.cantMensajes()
	method cantMensajes() = mensajes.size()
	method abrir() {
		mensajes.forEach{ mensaje => mensaje.serLeido() }
	}
	method cantMensajesSinLeer() = mensajes.filter { mensaje => not mensaje.leido() }.size()
}