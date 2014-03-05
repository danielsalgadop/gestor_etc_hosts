#!/usr/bin/perl

# recibe los datos introducidos en index.pl
# valida desde perl nombre y contrasenya
# autentica el nombre y contsenya, si es correcto genera la sesion
use CGI;
use lib 'libs_gestor_etc_hosts';
use variables_globales;
use warnings;
use strict;
use Switch;

sub autenticar($$) {
	our $estructura_modelo;
    my $nombre      = shift;
    my $contrasenya = shift;

    switch($estructura_modelo){
    	case "json"{
    		autenticarJSON($nombre,$contrasenya);
    	}

    }
    return 1;
}


sub autenticarJSON($$) {
	use miJSON;
	our $path_y_fichero_autenticar_json;

    my $nombre      = shift;
    my $contrasenya = shift;


}
1;