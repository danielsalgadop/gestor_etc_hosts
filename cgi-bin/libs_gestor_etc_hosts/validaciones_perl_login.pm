#!/usr/bin/perl

# funciones para validar login
use warnings;
use strict;

sub validaNombre($){
	my $nombre = shift;
	return &estaVacio($nombre);

	# if(&estaVacio($nombre)){
	# 	return 1;
	# }
	# return 0;
}


sub validaContrasenya($){
	my $contrasenya = shift;
	return &estaVacio($contrasenya);
	
	# if(&estaVacio($contrasenya)){
	# 	return 1;
	# }
	# return 0;
}


sub estaVacio($){
	my $vacio_o_rellno = shift;
	return $vacio_o_rellno =~ /^\s*$/;
}

1;