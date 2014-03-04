#!/usr/bin/perl
use lib 'libs_gestor_etc_hosts';
use variables_globales;
use strict;
use warnings;

use Data::Dumper;
# use CGI qw(:standard);
use CGI::Pretty qw(:all);
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);

our $name_app;

my $q = new CGI;
print $q->header;

print $q->start_html(
	-title => 'Gestor ETC HOSTS',
	-style=>{'src'=>'/'.$name_app.'/css/css.css'},
	);
my $error;
print "usar CGI<br>";
print "autenticar<br>";

print $q->start_form(
    -name    => 'login',
    -method  => 'POST',
    -enctype => &CGI::MULTIPART,
    -onsubmit => 'return javascript:validation_function()',
    -action => '/where/your/form/gets/sent', # Defaults to 
                                             # the current program
);
print $q->textfield(
    -name      => 'nombre',
    -size      => 20,
    -maxlength => 99,
);
print $q->textfield(
    -name      => 'contrasenya',
    -size      => 20,
    -maxlength => 99,
);

print $q->end_form;