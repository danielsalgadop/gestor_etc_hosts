#!/usr/bin/perl
use lib 'libs_gestor_etc_hosts';
use variables_globales;
use bootApp;
my %r_bootApp = bootApp();
use strict;
use warnings;

use Data::Dumper;

use CGI::Session;
# use CGI qw(:standard);
use CGI::Pretty qw(:all);
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
my $q = new CGI;
print $q->header;
### control del boot
if($r_bootApp{status} ne "OK"){
    print "ERROR GRAVE<br>\n";
    my @errores = @{$r_bootApp{errores}};
    map{print $_."<br>\n"} @errores;
    exit;
}
our $name_app;
# Sesion que contiene la informacion del
my $session = CGI::Session->new("driver:File", $q, {'Directory'=>'/tmp/'}) or die CGI::Session->errstr; 



#             $session->param('~logeado', 1);         #       # logeado=1 indica que la session esta activa.
#             $session->save_param();     #           #       #
#             $session->expire('~logeado', '+20m');   #       # Tiempo de expedición de la sesión 10 

if(not $session->param('~logeado')){
    # Si no esta logeado.
    print "NO logeado";
    print "<br><br>\n";   # meter esto con css en <div id="errores"></div>
    print $q->div( { -id => "errores" }, "", );  # se rellena desde  javascript

    print $q->start_html(
        -title  => 'Gestor ETC HOSTS',
        -style  => { 'src' => '/' . $name_app . '/css/css.css' },
        -script => [
            {   -type => "text/javascript",
                -src  => '/' . $name_app . '/js/jquery.js'
            },
            {   -type => "text/javascript",
                -src  => '/' . $name_app . '/js/js.js'
            },
        ],
    );

    my $error;

    print $q->start_form(
        -name    => 'login',
        -method  => 'POST',
        -enctype => &CGI::MULTIPART,
        -action  => '/cgi-bin/'.$name_app.'/gestor_etc_hosts.pl',    # Defaults to
                                                     # the current program
    );
    print $q->textfield(
        -name      => 'nombre',
        -id        => 'nombre',
        -value        => 'nombre',
        -size      => 20,
        -maxlength => 99,
    );
    print $q->textfield(
        -name      => 'contrasenya',
        -id        => 'contrasenya',
        -value        => 'contrasenya',
        -size      => 20,
        -maxlength => 99,
    );

    print $q->button(
        -name    => 'submit_form',
        -value   => 'ENTRAR',
        -onclick => 'javascript: validate_login_form();',
    );
print $q->end_form;
}
else{
    print "SI LOGEADO";
}
