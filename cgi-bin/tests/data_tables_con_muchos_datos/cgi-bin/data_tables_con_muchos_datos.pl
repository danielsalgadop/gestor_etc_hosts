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
# open(HOST, "hosts");
# my @hosts = (<HOST>);
# close(HOST);
# print Dumper(@hosts);

my %etc_hosts = cargarHost("hosts");
# print Dumper(%etc_hosts);

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
						<th>IP</th>
						<th>HOSTNAME</th>
						<!-- <th>Platform(s)</th> -->
						<!-- <th>Engine version</th> -->
						<!-- <th>CSS grade</th> -->
					</tr>
				</thead>
				<tbody>
HTML
			foreach (keys(%etc_hosts)){
				print "<tr>";
					print "<td>";
					print $_;
					print "</td>";
					print "<td>";
					print $etc_hosts{$_};
					print "</td>";

				print "</tr>";
			}
		print <<HTML;
			</tbody>
			<tfoot>
				<tr>
					<th>IP</th>
					<th>HOSTNAME</th>
				</tr>
			</tfoot>
		</table>
			</div> <!-- fin de demo -->
			<div class="spacer"></div>
		</div>  <!-- fin de container -->
	</body>
HTML
