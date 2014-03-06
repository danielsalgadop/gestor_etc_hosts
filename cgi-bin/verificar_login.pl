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
our $estructura_modelo;    # variables_globales.pm

my @errores;

my %return;

$return{result} = "FAIL: hay errores1";

my $nombre;
my $contrasenya;

if ( $q->param("nombre") && $q->param("contrasenya") ) {
    $nombre      = $q->param("nombre");
    $contrasenya = $q->param("contrasenya");

# print "param RECIBIDOS Y CON VALOR nombre=[".$nombre."] contrasenya=[".$contrasenya."]\n";

    if ( !validaNombre($nombre) ) {
        push( @errores, "nombre invalido PERL" );
    }
    if ( !validaContrasenya($contrasenya) ) {
        push( @errores, "contrasenya invalido PERL" );
    }

    # print Dumper(@errores);
}
else {    # no he recibido los parametros necesarios
    push( @errores, "falta recepcion de parametros necesarios" );
}

# construir array errores
if (@errores) {
    $return{result} = "FAIL";
    my $ref = \@errores;
    $return{"errores"} = \@errores;
}
else {
    # validaciones han dado ok, hay que autenticar
    $return{result} = "OK";


    
}

my $json = CodificaJson( \%return );
print $json;
