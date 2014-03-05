#!/usr/bin/perl
use warnings;
use strict;
use Switch;


# --- Lee una linea de archivo JSON. --- #
sub LeeJson($){
  
  my $archivo=shift;
  # --- DATOS GENERICOS. --- #
  open(CONFIG,"$archivo");
    my @Config=<CONFIG>;
  close(CONFIG);
  
  my $jsoncfg= new JSON;
  my $enperlcfg = $jsoncfg->decode($Config[0]);
  my %Hcfg = %$enperlcfg;
  return(%Hcfg);
}#Cierra sub LeeJson($)

# --- Decodifica JSON. --- #
sub DecodificaJson($){

  my $dato=shift;

  my $json= new JSON;
  my $enperl = $json->decode($dato);
  my %Hash = %$enperl;

  return(%Hash);

}#Cierra sub DecodificaJson($)

# --- Codifica JSON. --- #
sub CodificaJson($){

  # --- Recibe una referencia a un hash. --- #
  my $dato=shift;

  my $json=new JSON;
  my $informacion=$json->encode($dato);

  return($informacion);

}#Cierra sub CodificaJson($)

1;