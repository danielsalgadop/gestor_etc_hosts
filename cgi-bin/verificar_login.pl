#!/usr/bin/perl

# recibe los datos introducidos en index.pl
# valida desde perl nombre y contrasenya
# autentica el nombre y contsenya, si es correcto genera la sesion
use CGI;
use lib 'libs_gestor_etc_hosts';
use variables_globales;
use validaciones_perl_login;
use autenticar_login;
use warnings;
use strict;
use Switch;


my $q = new CGI;
print $q->header('application/json');
our $estructura_modelo;  # variables_globales.pm

# voy a intentar hacer proyecto sin libreria JSON
my @errores;

my $nombre;
my $contrasenya;

if (  $q->param("nombre") && $q->param("nombre") ) {
	$nombre = $q->param("nombre");
	$contrasenya = $q->param("contrasenya");
	if (validaNombre($q->param("nombre") ) ){
		push(@errores, "nombre invalido");
	}

	if(@errores){

	}
	else{
		# validaciones han dado ok, hay que autenticar
		print '{"result":"OK"}';

	}

}
else{  # no he recibido los parametros necesarios

	print '{"result":"FAIL","errores":["falta recepcion de parametros necesarios"]}';

}
