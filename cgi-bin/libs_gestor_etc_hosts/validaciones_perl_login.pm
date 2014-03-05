#!/usr/bin/perl

# funciones para validar login
use warnings;
use strict;

sub validaNombre($){
	my $nombre = shift;
	if(!&estaVacio($nombre)){
		return 1;
	}
	return 0;
}


sub validaContrasenya($){
	my $contrasenya = shift;
	if(!&estaVacio($contrasenya)){
		return 1;
	}
	return 0;
}


sub estaVacio($){
	return $=~/^\s*$/;
}

1;