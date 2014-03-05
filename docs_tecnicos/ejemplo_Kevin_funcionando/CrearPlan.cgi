#!/usr/bin/perl

#########################################################################################
# Version 2.0                                                                           #
# CrearPlan.cgi - Formulario para dar de alta un nuevo plan de acción.				    #
#########################################################################################

######################################################
# -------------------- Librerias --------------------#
######################################################

use strict;
use warnings;
use diagnostics;
use lib '/usr/lib/cgi-bin/'; # MiLibreria.pm
use MiLibreria;

use CGI::Session; # Hay que importar siempre esta libreria antes de CGI, lo pone en el manual.
use CGI ':standard';
use CGI::Carp qw'fatalsToBrowser warningsToBrowser';

use Time::HiRes qw/gettimeofday/;
use Time::Local;
use Data::Dumper;

######################################################
# -------------------- Variables --------------------#
######################################################

my $cgi = CGI->new(); # Variable CGI.

my $CGISESSID = $cgi->param('CGISESSID'); 											# Recuperamos la session.
my $session = new CGI::Session("driver:File", $CGISESSID, {'Directory'=>'/tmp/'}); 	# Session actual.

######################################################
# -------------------- Principal --------------------#
######################################################

my $ArchivosConfiguracion = "./ArchivosConfiguracion";
my %Configuraciones = &DecodificaJson("$ArchivosConfiguracion/Configuracion.cfg");
my %Carpetas = &DecodificaJson("$ArchivosConfiguracion/$Configuraciones{'CarpetasCfg'}");
my %Imagenes = &DecodificaJson("$ArchivosConfiguracion/$Configuraciones{'Imagenes'}");
my %Ficheros = &DecodificaJson("$ArchivosConfiguracion/$Configuraciones{'Ficheros'}");
my %Estilos = &DecodificaJson("$ArchivosConfiguracion/$Configuraciones{'Estilos'}");

print $session->header; #Para recuperar cookies si no, la página no carga.

if(not $session->param('~logeado')){	# Si no esta logeado.
    print "<script> window.location.href='./$Ficheros{'Login'}' </script>";
}

my $login = $session->param('login_nombre');
my $sessionActiva = $session->param('~logeado');

if($cgi->param('Desconectar')) # Si el usuario quiere desconectarse.
{
	$session->clear(['~logeado']);   								# Eliminamos la session.
	print "<script> window.location.href='./$Ficheros{'Login'}' </script>";  # Y redirigimos a la página de Login.cgi.

}else{ # Mostramos la página

	&MostrarPagina();
}

######################################################
# -------------------- Funciones --------------------#
######################################################

sub MostrarPagina {

	my $idNuevo = &CrearPlanID(); # Id que tendrá el plan que vamos a crear.

	print <<PARRILLA;
	
	<html>
	<head>
		<META HTTP-EQUIV="REFRESH">
		<title> Crear plan </title>

		<link rel="stylesheet" href="http://$Configuraciones{'Servidor'}/$Configuraciones{'BECA'}/$Configuraciones{'GestionPlanes'}/$Carpetas{'Estilos'}/$Estilos{'estilo'}" type="text/css"> <!-- Estilo de la pagina -->
        <link rel="shortcut icon" type="image/x-icon" href="http://$Configuraciones{'Servidor'}/$Configuraciones{'BECA'}/$Configuraciones{'GestionPlanes'}/$Carpetas{'Imagenes'}/$Imagenes{'LogoBTMini'}"> <!-- Icono del navegador -->
    </head>
	<html>
		<p class="info_login"> Bienvenido <b>$login</b> - <a onClick="window.location.href='./$Ficheros{'PAParrilla'}?Desconectar=1'"><u> Desconectar </u> &nbsp;&nbsp; </a></p>
		<p class="titulo"> <img src="http://img01.bt.co.uk/s/assets/images/BT_logo.png" class="bt"> &nbsp;&nbsp;  Plan ID: $idNuevo </p>
	
PARRILLA

		&FormularioAlta($idNuevo); # Muestra el formulario de alta.

		print <<PARRILLA;


	</body>
	</html>

PARRILLA
	
}

#####################################################################
# Función: CrearPlanID - Crea una ID a partir de la fecha actual 	#
#    en segundos.				                                    #
# Param:  -												            #
# Return: id_plan - ID creada.                                      #
#####################################################################
sub CrearPlanID {	

    return &LeerPlanID();
}


#####################################################################
# Función: FormularioAlta - Muestra el formulario de alta 			#
#		del plan.													#
# Param:  plan_id_creado - ID creada para el plan.		            #
# Return: -                                                         #
#####################################################################
sub FormularioAlta {

	my $idPlan = shift;

	print <<FORMULARIO_ALTA;

	<form action="./$Ficheros{'PAParrilla'}" method="POST" id="formulario_alta_plan">
		<table class="anadir_accion" align="center">

				<input type="hidden" name="anadir" id="anadir" value="si"> <!-- Indicamos que SI es el formulario de añadir -->
				<input type="hidden" name="id_plan" id="id_plan" value="$idPlan">

				<tr>
					<td> Nombre: </td>
					<td> <input type="text" size="35" name="nombre_plan" id="nombre_plan"> </td>
				</tr>

				<tr>
					<td> Caso problema (Num. Clarify): </td>
					<td> <input type="text" size="35" name="caso_plan" id="caso_plan"> </td>
				</tr>

				<tr>
					<td> Fecha de inicio: </td>
					<td>
						<input type="text" size="2" maxlength="2" name="fecha_inicio_dia"  id="fecha_inicio_dia"  onkeypress="return SoloNumeros(event)"> /  
						<input type="text" size="2" maxlength="2" name="fecha_inicio_mes"  id="fecha_inicio_mes"  onkeypress="return SoloNumeros(event)"> /  
						<input type="text" size="4" maxlength="4" name="fecha_inicio_anio" id="fecha_inicio_anio" onkeypress="return SoloNumeros(event)">
						(dd/mm/aaaa)
					</td>
				</tr>

				<tr>
					<td> Riesgo operativo: </td>
					<td><select name="riesgo_plan" id="riesgo_plan">
						<option value=""></option>
FORMULARIO_ALTA
						my %HRiesgo = &DecodificaJson("$ArchivosConfiguracion/$Configuraciones{'PARiesgo'}");
						foreach my $riesgo (sort(keys %HRiesgo)) {
							chomp($riesgo);
							print "<option value='$riesgo'> <b>$riesgo</b> </option>";
						}
						print <<FORMULARIO_ALTA;
					</select></td>
				</tr>

				<tr>
					<td> Categor&iacutea: </td>
					<td><select name="categoria_plan" id="categoria_plan">
						<option value=""></option>
FORMULARIO_ALTA
						my %Hcategoria = &DecodificaJson("$ArchivosConfiguracion/$Configuraciones{'PACategoria'}");
						foreach my $categoria (sort(keys %Hcategoria)) {
							chomp($categoria);
							print "<option value='$categoria'> <b>$categoria</b> </option>";
						}

						print <<FORMULARIO_ALTA;
					</select></td>
				</tr>

				<tr>
					<td> Origen: </td>
					<td><select name="origen_plan" id="origen_plan">
						<option value=""></option>
FORMULARIO_ALTA

						my %HOrigen = &DecodificaJson("$ArchivosConfiguracion/$Configuraciones{'PAOrigen'}");

						foreach my $origen (sort(keys %HOrigen)) {
							chomp($origen);
							print "<option value='$origen'> <b>$origen</b> </option>";
						}

						print <<FORMULARIO_ALTA;	
					</select></td>
				</tr>

				<tr>
					<td> Owner: </td>
					<td><select name="owner_plan" id="owner_plan">
						<option value=""></option>
FORMULARIO_ALTA
						my %HOwner = &DecodificaJson("$ArchivosConfiguracion/$Configuraciones{'PAOwner'}");

						foreach my $owner (sort(keys %HOwner)) {
							chomp($owner);
							print "<option value='$owner'> <b>$owner</b> </option>";
						}
						
						print <<FORMULARIO_ALTA;		
					</select></td>
				</tr>

				<tr>
					<td> Estado: </td>
					<td> En marcha </td>
					<input type="hidden" name="estado_plan" id="estado_plan" value="En marcha">
				</tr>

				<tr>
					<td> Coeficiente de dependencia: </td>
					<td><select name="coeficiente_plan" id="coeficiente_plan">
						<option value=""></option>
FORMULARIO_ALTA
						my %HCoeficiente = &DecodificaJson("$ArchivosConfiguracion/$Configuraciones{'PACoeficiente'}");

						foreach my $coeficiente (sort(keys %HCoeficiente)) {
							chomp($coeficiente);
							print "<option value='$coeficiente'> <b>$coeficiente</b> </option>";
						}
						
						print <<FORMULARIO_ALTA;		
					</select></td>
				</tr>

				<tr>
					<td colspan="2" align="center"></br>
						<input type="button" class="boton_aceptar" value="Crear plan" name="crear_plan" id="crear_plan" onClick="javascript:ConfirmarAlta(formulario_alta_plan);">
						<input type="reset"  class="boton_borrar" value="Borrar datos" name="borrar_datos" id="borrar_datos">
						<input type="button" class="boton_cancelar" value="Cancelar" name="cancelar_alta" id="cancelar_alta" onClick="window.location.href='./$Ficheros{'PAParrilla'}'">
					</td>
				</tr>
		</table>
	</form>

	<script>
		var nav4 = window.Event ? true : false;
	    function SoloNumeros(evt)
	    {
	        // NOTE: Backspace = 8, Enter = 13, '0' = 48, '9' = 57
	        var key = nav4 ? evt.which : evt.keyCode;
	        return (key <= 13 || (key >= 48 && key <= 57));
	    }

	    function ConfirmarAlta(formulario)
	    {
	    	var comprobacion = ComprobarCamposVacios();

	    	if(comprobacion==0)
	    	{
		    	if(window.confirm("\xbfConfirma el alta del plan?")){
		    		formulario.submit();
		    	}
	    	}
	    }

	    function ComprobarCamposVacios()
	    {
	    	var comprobacion = 0;
	    	var nombre = document.getElementById("nombre_plan").value;
	    	var caso = document.getElementById("caso_plan").value;
	    	var fechaDia = document.getElementById("fecha_inicio_dia").value;
	    	var fechaMes = document.getElementById("fecha_inicio_mes").value;
	    	var fechaAnio = document.getElementById("fecha_inicio_anio").value;
	    	var riesgo = document.getElementById("riesgo_plan").value;
	    	var categoria = document.getElementById("categoria_plan").value;
	    	var origen = document.getElementById("origen_plan").value;
	    	var owner = document.getElementById("owner_plan").value;
	    	var coeficiente = document.getElementById("coeficiente_plan").value;

			if(nombre=="" || caso=="" || fechaDia=="" || fechaMes=="" || fechaAnio=="" || riesgo=="" || categoria=="" || origen=="" || owner=="" || coeficiente=="")
			{
				comprobacion=1;
				alert("Alg\xfan campo no se ha completado correctamente.");
			}

			return comprobacion;
	    }
    </script>
FORMULARIO_ALTA
}
