#!/usr/bin/perl

# recibe los datos introducidos en index.pl
# valida desde perl nombre y contrasenya
# autentica el nombre y contsenya, si es correcto genera la sesion
use CGI::Session;
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

# recojo valores enviados
my $nombre      = $q->param("nombre");
my $contrasenya = $q->param("contrasenya");

if ( defined($nombre) && defined($contrasenya) ) {

# print "param RECIBIDOS Y CON VALOR nombre=[".$nombre."] contrasenya=[".$contrasenya."]\n";

    if ( !validaNombre($nombre) ) {
        push( @errores, "nombre invalido PERL" );
    }
    if ( !validaContrasenya($contrasenya) ) {
        push( @errores, "contrasenya invalido PERL" );
    }

    unless (@errores) {

        # validaciones han dado ok, hay que autenticar
        my %r_autenticar = autenticar($nombre, $contrasenya);
        if ( $r_autenticar{status} ne "OK" ){
            push( @errores, $r_autenticar{status} );
        }
    }
}
else {    # no he recibido los parametros necesarios
    push( @errores, "falta recepcion de parametros necesarios" );
}

if (@errores) {

    # construir array errores
    $return{result} = "FAIL";
    my $ref = \@errores;
    $return{"errores"} = \@errores;
}
else {

    #validacion y autenticado ok
    $return{result} = "OK";

    # generar SESSION
    my $session = CGI->new(); # Variable CGI.

    my $CGISESSID = $session->param('CGISESSID');                                           # Recuperamos la session.
    my $session = new CGI::Session("driver:File", $CGISESSID, {'Directory'=>'/tmp/'});  # Session actual.

                $session->param('~logeado', 1);         #       # logeado=1 indica que la session esta activa.
            $session->save_param();     #           #       #
            $session->expire('~logeado', '+20m');   #       # Tiempo de expedición de la sesión 10 
}

my $json = CodificaJson( \%return );
print $json;
