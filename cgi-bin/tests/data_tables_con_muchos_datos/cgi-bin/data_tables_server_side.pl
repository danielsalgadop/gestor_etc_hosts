#!/usr/bin/perl -w
# script llamado desde jquery datatables

use strict;
use Data::Dumper;
use JSON;
use CGI;
print "Content-type: text/html\n\n";
my @aaData; # aaData tiene q tener 2 dimensiones  [  [datos1, datos1],[datos2 , datos2] ]
			# son los datos de la tabla

my $q = CGI->new;
my @param = $q->param;   # parametros llegados via url
 
my $datos_log= "";
# print Dumper(%json_mock);

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

# cargar los etch_hosts

my %etc_hosts = cargarHost("hosts");
my $num_total_records = keys(%etc_hosts);
my %json_mock;
$json_mock{sEcho} = 1;
$json_mock{iTotalRecords} = $num_total_records;

my $contador_display_length = $q->param('iDisplayLength');
my $contador_display_start = $q->param('iDisplayStart');
my $contador = 0;
my $valor_ultimo_contador = $contador_display_length + $contador_display_start;
foreach my $ip(sort(keys(%etc_hosts))){
	# logica de paginacion
	$contador++;
	next if $contador < $contador_display_start;
	
	last if $contador > $valor_ultimo_contador;

	# if($ip =~ /10.250/){
	push(@aaData,[$ip, $etc_hosts{$ip}]);   # no vale que aaData sea un array con los datos, tiene que ser un array de arrays

	# }
}

$json_mock{iTotalDisplayRecords} = $num_total_records;

$json_mock{aaData} = \@aaData;
 my $json=new JSON;

my $encoded = $json->encode(\%json_mock);
print $encoded;



##############################
# para ver los param por LOG #
##############################
open (LOG,">>/tmp/log_carga_datos") || die "problema abriedo /tmp/log_carga_datos";
foreach my $unparam(@param){
	my $value = $q->param($unparam);
	$datos_log .= $unparam."\t".$value."\n";
	# $q->save(\*LOG);  # no he coseguido que funcione  http://perldoc.perl.org/CGI.html#SAVING-THE-STATE-OF-THE-SCRIPT-TO-A-FILE%3a
}
$datos_log .= "estado PARAMETROS contador=[".$contador."] contador_display_start=[".$contador_display_start."] contador_display_length=[".$contador_display_length."]\n";
print LOG $datos_log."=================\n";
close(LOG);

