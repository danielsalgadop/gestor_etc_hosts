#!/usr/bin/perl -w
# script llamado desde jquery datatables

use strict;
use Data::Dumper;
use JSON;
print "Content-type: text/html\n\n";


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


# cargar host (uno ficticio)
# open(HOST, "hosts");
# my @hosts = (<HOST>);
# close(HOST);
# print Dumper(@hosts);

my %etc_hosts = cargarHost("hosts");
my %json_mock;
$json_mock{sEcho} = 1;
$json_mock{iTotalRecords} = 57;
$json_mock{iTotalDisplayRecords} = 57;
my @aaData = (["IP1", "HOSTNAME1"],["IP2", "HOSTNAME2"]);
$json_mock{aaData} = \@aaData;

 my $json=new JSON;


			# foreach (keys(%etc_hosts)){
			# }


my $encoded = $json->encode(\%json_mock);
print $encoded;