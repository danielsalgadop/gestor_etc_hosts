#!/usr/bin/perl -w
use strict;
use Data::Dumper;
print "Content-type: text/html\n\n";
my $path_web = "/carga_datatables";

# Cargar los datos de ipservicio_nodo.txt y devolverlo en un hash
sub cargarHost($){
	my $path_y_fichero_ip_servicio_nodo = shift;
	my %ipservicio_nodo;
	our $fallo_grave_mensaje;
	open (IPSERV, $path_y_fichero_ip_servicio_nodo)  or die $fallo_grave_mensaje ." [u803ry893r] intentando abrir ".$path_y_fichero_ip_servicio_nodo." error[".$!."]";; # No hay control de errores por que se comprueba en bootApp
	while(<IPSERV>){
		next if $_!~/^\d/;   # pasar a siguiente si no comienza por un numero
		my @datos_splited = split(/\s+/,$_);
		$ipservicio_nodo{$datos_splited[0]} = $datos_splited[1];
	}
	close IPSERV;
	return(%ipservicio_nodo);
}


# cargar host (uno ficticio)
open(HOST, "hosts");
my @host = (<HOST>);
close(HOST);
# print Dumper(@host);

my %etc_hosts = cargarHost("hosts");
print Dumper(%etc_hosts);

 print <<HTML;
 <html>
 <head>
 <title>A Simple Perl CGI</title>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<link rel="shortcut icon" type="image/ico" href="http://www.datatables.net/favicon.ico" />
		
		<title>PRUEBA DE CARGA DATATABLES</title>
		<style type="text/css" title="currentStyle">
			\@import "$path_web/css/demo_page.css";
			\@import "$path_web/css/demo_table.css";
		</style>
		<script type="text/javascript" language="javascript" src="$path_web/js/jquery.js"></script>
		<script type="text/javascript" language="javascript" src="$path_web/js/jquery.dataTables.js"></script>
		<script type="text/javascript" charset="utf-8">
			\$(document).ready(function() {
				\$('#example').dataTable();
			} );
		</script>
	</head>
	<body id="dt_example">
		 <h1>A Simple Perl CGI</h1>
 <p>Hello World</p>

		<div id="container">
			<div class="full_width big">
				PRUEBA DE CARGA DATATABLES. Archivo de /etc/hosts simulado (mas de 100.000 registros)
			</div>
			<h1>Live example</h1>
			<div id="demo">
<table cellpadding="0" cellspacing="0" border="0" class="display" id="example" width="100%">
	<thead>
		<tr>
			<th>Rendering engine</th>
			<th>Browser</th>
			<th>Platform(s)</th>
			<th>Engine version</th>
			<th>CSS grade</th>
		</tr>
	</thead>
HTML
foreach (@hosts){

}
print <<HTML;
	<tbody>
		<tr class="odd gradeX">
			<td>Trident</td>
			<td>Internet
				 Explorer 4.0</td>
			<td>Win 95+</td>
			<td class="center"> 4</td>
			<td class="center">X</td>
		</tr>
		<tr class="even gradeC">
			<td>Trident</td>
			<td>Internet
				 Explorer 5.0</td>
			<td>Win 95+</td>
			<td class="center">5</td>
			<td class="center">C</td>
		</tr>
		<tr class="odd gradeA">
			<td>Trident</td>
			<td>Internet
				 Explorer 5.5</td>
			<td>Win 95+</td>
			<td class="center">5.5</td>
			<td class="center">A</td>
		</tr>
		<tr class="even gradeA">
			<td>Trident</td>
			<td>Internet
				 Explorer 6</td>
			<td>Win 98+</td>
			<td class="center">6</td>
			<td class="center">A</td>
		</tr>
		<tr class="odd gradeA">
			<td>Trident</td>
			<td>Internet Explorer 7</td>
			<td>Win XP SP2+</td>
			<td class="center">7</td>
			<td class="center">A</td>
		</tr>
	</tbody>
	<tfoot>
		<tr>
			<th>Rendering engine</th>
			<th>Browser</th>
			<th>Platform(s)</th>
			<th>Engine version</th>
			<th>CSS grade</th>
		</tr>
	</tfoot>
</table>
			</div>
			<div class="spacer"></div>
		</div>
	</body>
HTML
