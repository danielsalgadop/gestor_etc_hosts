#!/usr/bin/perl
use warnings;
use strict;

use lib '.';
use variables_globales;
use miJSON;
use Switch;

# devuelve hash %return
# %return{status} = OK | FAIL[descripcion del error]
sub autenticar($$) {
	our $estructura_modelo;
    my $nombre      = shift;
    my $contrasenya = shift;
    my %return;

    $return{status} = "FAIL : usuario o contrasenya no correctos";
    switch($estructura_modelo){
        case "json"{
            if(autenticarJSON($nombre,$contrasenya)){
                $return{status} = "OK";
            }
        }
        else{
            $return{status} = "ERROR GRAVE: no existe valor en estructura_modelo recibido [".$estructura_modelo."]";
        }
    }
    return (%return);
}



# devuelve 0 o 1
sub autenticarJSON($$) {
    my $nombre      = shift;
    my $contrasenya = shift;
    use miJSON;
    our $path_absoluto_y_fichero_autenticar_json;
    my %users_psw = fileJson2Hash($path_absoluto_y_fichero_autenticar_json);

    # si el nombre y contrasenya recibidos coinciden con lo que hay en fichero, hay login!
    if($users_psw{$nombre} eq $contrasenya){
        return 1;
    }
    return 0;
}
1;