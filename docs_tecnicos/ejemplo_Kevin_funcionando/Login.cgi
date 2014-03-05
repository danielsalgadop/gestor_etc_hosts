#!/usr/bin/perl

#########################################################################################
# Version 2.0                                                                           #
# Login.cgi - CGI donde se realiza el control de acceso, si la contraseña y el password #
#       introducidos son correctos, se redirige a la página de la parrilla de planes    #
#########################################################################################

######################################################
# -------------------- Liberarias -------------------#
######################################################

use strict;
use warnings;
use diagnostics;
use lib '/usr/lib/cgi-bin/'; # MiLibreria.pm
use MiLibreria;

use CGI::Session; # Hay que importar siempre esta libreria antes de CGI, lo pone en el manual.
use CGI ':standard';
use CGI::Carp qw'fatalsToBrowser warningsToBrowser';

######################################################
# -------------------- Variables --------------------#
######################################################

my $cgi = CGI->new(); # Variable CGI
my $session = CGI::Session->new("driver:File", $cgi, {'Directory'=>'/tmp/'}) or die CGI::Session->errstr; # Sesion que contiene la informacion del
                                                                                                          # usuario, se almacena en la carpeta 'tmp'.
print $session->header; #Para recuperar cookies si no, la página no carga.
my $usuario; # Datos del usuario que tiene una sesion activa.

my $ArchivosConfiguracion = "./ArchivosConfiguracion";
my %Configuraciones = &DecodificaJson("$ArchivosConfiguracion/Configuracion.cfg");
my %Carpetas = &DecodificaJson("$ArchivosConfiguracion/$Configuraciones{'CarpetasCfg'}");
my %Imagenes = &DecodificaJson("$ArchivosConfiguracion/$Configuraciones{'Imagenes'}");
my %Ficheros = &DecodificaJson("$ArchivosConfiguracion/$Configuraciones{'Ficheros'}");
my %Estilos = &DecodificaJson("$ArchivosConfiguracion/$Configuraciones{'Estilos'}");

######################################################
# --------------------- Programa --------------------#
######################################################

# Verificamos si el usuario ya tiene una sesion, o si quiere acceder, que la contraseña sea correcta.
if(not $session->param('~logeado'))     # Si no esta logeado.
{                                       #
    if(my $passwd = $cgi->param('login_password'))  # Si ha introducido una contraseña.
    {                                   #           #
        my $nombre = $cgi->param('login_nombre');   # Recuperamos el login que se ha seleccionado.
                                        #           #
        if($usuario = &UsuarioRegistrado($nombre, $passwd)) # Si los datos son correctos, establecemos los parametros de la sesion.
        {                               #           #       #
            $session->param('usuario', $usuario);   #       # 
            $session->param('~logeado', 1);         #       # logeado=1 indica que la session esta activa.
            $session->save_param();     #           #       #
            $session->expire('~logeado', '+20m');   #       # Tiempo de expedición de la sesión 10 minutos. 
                                        #           #       #
        }else{                          #           #       # Datos incorrectos, le pedimos que rellene el registro otra vez.
                                        #           #
            &MostrarPagina('Password incorrecta'); # Si ha introducido una password incorrecta, mostramos error.
            exit;                       #           #
        }                               #           #
    }else{                              #           # Si no se ha introducido se vuelve a pedir al usuario que se identifique.
                                        #
       &MostrarPagina();                # Si no ha introducido ningun dato aún, le mostramos la página.
       exit;                            #
    }                                   #
}else{                                  # Si ya estaba logeado, recuperamos la sesion.      
    $usuario = $session->param('usuario');
}

print "<script> window.location.href='./$Ficheros{'PAParrilla'}' </script>"; # Una vez que nos hemos logeado redirigimos a la parrilla de planes.

######################################################
# -------------------- Subrutinas -------------------#
######################################################

sub UsuarioRegistrado {

    my ($nombre, $password)=@_;
    my %PasswordLogin = &DecodificaJson("$ArchivosConfiguracion/$Configuraciones{'Password'}");

    if ($password eq $PasswordLogin{$nombre}) { # Si es correcta devolvemos el nombre del equipo.
        return $nombre;
    }

    return; # Si no es correcta no se devuelve nada.
}
 
#####################################################################
# Función: MostrarPagina - Muestra el formulario de acceso.        #
# Param: titulo - Información al usuario acerca de si se ha logeado #
#   correctamente.                                                  #
# Return: -                                                         #
#####################################################################
sub MostrarPagina {
    
    my $titulo  = shift;
    my %Equipos = &DecodificaJson("$Carpetas{'Configuracion'}/$Configuraciones{'Login'}"); # Decodificacion del fichero Equipos_login.cfg, donde se almacena el nombre de los

    print <<PRESENTA_LOGIN;

    <html>
    <head>
        <META HTTP-EQUIV="REFRESH" CONTENT="120">
        <title> Bienvenido </title>
        <link rel="stylesheet" href="http://$Configuraciones{'Servidor'}/$Configuraciones{'BECA'}/$Configuraciones{'GestionPlanes'}/$Carpetas{'Estilos'}/$Estilos{'estilo'}" type="text/css"> <!-- Estilo de la pagina -->
        <link rel="shortcut icon" type="image/x-icon" href="http://$Configuraciones{'Servidor'}/$Configuraciones{'BECA'}/$Configuraciones{'GestionPlanes'}/$Carpetas{'Imagenes'}/$Imagenes{'LogoBTMini'}"> <!-- Icono del navegador -->
    </head> 

    <body>

        </br><p class="titulo_login"> P&A Management </p>
        <form method="POST">
        <div class="fieldset">
            <fieldset>
                <legend> Owner </legend>
                <select name="login_nombre" id="login_nombre">
                    <option></option>
PRESENTA_LOGIN
                    foreach my $equipo (sort(keys %Equipos)) {
                        chomp($equipo);
                        print "<option> <b>$equipo</b> </option>";
                    }   

                    print <<PRESENTA_LOGIN; 

                </select>
            </fieldset> 
            <fieldset>
                <legend> Password </legend>
                <input type="password" size="34" name="login_password" id="login_password">
            </fieldset>
        </div>
        <p align="center"><input type="submit" value="Entrar" name="Entrar" id="Entrar" class="boton"></p>
        </form>

        <p class="error"> $titulo </p> <!-- Mensaje de error, si se produce algún error al logearse -->
        <img src="http://img01.bt.co.uk/s/assets/images/BT_logo.png" align="right" class="bt">
    </body>
    </html>

PRESENTA_LOGIN

}
