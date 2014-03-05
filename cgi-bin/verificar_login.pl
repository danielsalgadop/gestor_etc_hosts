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
use Data::Dumper;


my $q = new CGI;
print $q->header('application/json');
our $estructura_modelo;  # variables_globales.pm

my @errores;

my %return;

$return{result} = "FAIL: hay errores1";



my $nombre;
my $contrasenya;

if (  $q->param("nombre") && $q->param("contrasenya") ) {
	$nombre = $q->param("nombre");
	$contrasenya = $q->param("contrasenya");

	# print "param RECIBIDOS Y CON VALOR nombre=[".$nombre."] contrasenya=[".$contrasenya."]\n";

	if (!validaNombre($nombre) ){
		push(@errores, "nombre invalido");
	}

	# print Dumper(@errores);

	if(@errores){
		# $errores[1] = "error uno";
		# $errores[2] = "error dos";
		my @errores2 = ("error uno", "error2");
		my $ref = \@errores2;
		$return{result} = "FAIL: hay errores2222";

		# $return{errores} = ("erroraurrrr uno", "erroraurrrr2", "erroraurrrr3333332");
		
		# $return{errores} = "erroraurrrr uno";
		$return{"errores"} = @errores2;
		# $return{"errores"} = $ref;

	}
	else{
		# validaciones han dado ok, hay que autenticar
		$return{result}="OK";

	}

}
else{  # no he recibido los parametros necesarios
	$return{result} = "FAIL : falta recepcion de parametros necesarios";
	# print '{"result":"FAIL","errores":["falta recepcion de parametros necesarios"]}';

}

# devuelvo la respuesta %return
my @errores3 = ("e323232rror uno", "error2");

my %return2 = {"result"=> "toe", "errores" => \@errores3};
my $json = CodificaJson(\%return2);
print $json;
