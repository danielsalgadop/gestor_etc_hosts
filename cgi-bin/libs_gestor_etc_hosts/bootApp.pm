#!/usr/bin/perl
use warnings;
use strict;

# Comprueba acceso a recursos indespensables para al app
use lib '.';
use variables_globales;
use comprobaciones_input_output;
use Switch;




sub bootApp(){
	my %return;
	my @errores;
	our $estructura_modelo;

	switch($estructura_modelo){
		# si la estructura de modelo es json
		case "json"{
			# comprobar que se puede leer el fichero que contiene los datos para autenticar
			# TODO: comprobar que se trata de un json valido
			our $path_absoluto_y_fichero_autenticar_json;
			my %r_ficheroLeible = ficheroLeible($path_absoluto_y_fichero_autenticar_json);
			if($r_ficheroLeible{status} ne "OK"){
				push(@errores, @{$r_ficheroLeible{avalues}});
			}
		}
	}

	unless(@errores){ # si array errores esta vacio todo ha ido ok
		$return{status} = "OK";
	}
	else{
		$return{status} = "FAIL";
		$return{errores} = \@errores;
	}
	return(%return);
}



1;