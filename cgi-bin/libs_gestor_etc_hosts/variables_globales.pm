#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

# our $path_absoluto_app = "/home/dan/cosas_hechas/84.gestor_etc_hosts/cgi-bin/modelo"
our $name_app = "84.gestor_etc_hosts";
our $path_absoluto_app = "/home/dan/cosas_hechas/".$name_app;

# en el modelo se almacenan los usuarios y contrasenyas de aplicacion
our $estructura_modelo = "json";  # puede ser json/mysl/mongodb
our $path_relativo_y_fichero_autenticar_json = $path_absoluto_app."/cgi-bin/modelo/users.json";

1;