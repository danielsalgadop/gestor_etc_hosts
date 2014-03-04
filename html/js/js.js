function validate_login_form(){
	var array_errores = new Array();
	var valor_nombre = $("#nombre").val();
	var valor_contrasenya = $("#contrasenya").val();


	if(!validarNombre( valor_nombre ) ){
		array_errores.push("nombre invalido");
	}
	if(!validarContrasenya( valor_contrasenya ) ){
		array_errores.push("contrasenya invalido");
	}
	if(array_errores > 0){
		mostrarErroresEnJs(array_errores);
	}
	esle{ // no hay errores de validacion detectado por js
		// lanzar ajax, validar desde perl
	}

}


function mostrarErroresEnJs(array_errores){
	// quitar anteriores errores
	$('#errores').html("");
	// recorrer array de errores
	for (error in array_errores) {
		// mostrar uno a uno los errores
		$('#errores').append(array_errores[error]+"<br>");
	}
}


function validarNombre(nombre){
	if(estaRelleno(nombre)){
		return true;
	}
	return false;
}
function validarContrasenya(contrasenya){
	if(estaRelleno(contrasenya)){
		return true;
	}
	return false;
}

function estaRelleno(campo){
	if(campo == ""){
		return false;
	}
	else{
		var filter = /^\s+$/;
	     if (!filter.test(campo)) {
			return true;
		}
	}
	return false;
}