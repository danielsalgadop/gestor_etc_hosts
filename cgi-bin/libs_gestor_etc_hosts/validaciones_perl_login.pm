#!/usr/bin/perl

# funciones para validar login
use warnings;
use strict;

sub validaNombre($){
	my $nombre = shift;
	return &estaRelleno($nombre);

	# if(&estaRelleno($nombre)){
	# 	return 1;
	# }
	# return 0;
}


sub validaContrasenya($){
	my $contrasenya = shift;
	return &estaRelleno($contrasenya);

	# if(&estaRelleno($contrasenya)){
	# 	return 1;
	# }
	# return 0;
}


sub estaRelleno($){
	my $vacio_o_relleno = shift;
	return $vacio_o_relleno !~ /^\s*$/;
}

1;