class UserException inherits Exception{}


class Cuenta{
	var titular
	var pin
	var property saldo = 0 
	
	
	method titular(){
		return titular
	}
	method pin(){
		return pin
	}
	method saldo(){
		return saldo
	}
}

object cajero{
	var listaCuentas = []
	
	method verificarPinParaApertura(pinIngresado){
//		El pin consta de cuatro dígitos y no deben ser todos iguales ni conformar una secuencia ascendente.
		if ((pinIngresado.size() != 4) or (pinIngresado == pinIngresado.sortedBy({x,y => x<y})))
			throw new UserException("Pin no admitido") 

	}
	
	method verificarPinParaIngreso(cuenta,pinIngresado){
		if (pinIngresado != cuenta.pin()) {throw new UserException("Pin incorrecto")}
	}
	
	method apertura(pinIngresado,titularIngresado){
		
		self.verificarPinParaApertura(pinIngresado)
		listaCuentas.add(new Cuenta(pin = pinIngresado, titular = titularIngresado ))

	}
	
	method consultarSaldo(cuenta,pinIngresado){
		cuenta.verificarPinParaIngreso()
		return cuenta.saldo()
	}
	
	method cuentaExistente(titularIngresado){
		return listaCuentas.findOrElse(
		{cuentas => cuentas.contains(titularIngresado)}, //
		{throw new UserException("No se encontro cuenta del titular")})
	}
	
	method depositar(titularIngresado,dinero){
		self.cuentaExistente(titularIngresado)
		self.saldo(self.saldo() + dinero) 
	
	}
}