#!/usr/bin/perl
use warnings;
use strict;
use JSON;


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

  # $json = $json->allow_nonref(1);
  my $informacion=$json->encode($dato);

  return($informacion);

}#Cierra sub CodificaJson($)

# lee un fichero entero y devuelve un hash con el contenido
sub fileJson2Hash($){
  my $path_absolute_to_file = shift;
  my $json;
  {
    local $/; #Enable 'slurp' mode   <<<< esta es la clave (que no 'trocee' linea a linea)
    open my $fh, "<", $path_absolute_to_file;
    $json = <$fh>;
    close $fh;
  }
  my %datos_en_perl = DecodificaJson($json);
  return(%datos_en_perl);

}

1;