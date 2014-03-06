#!/usr/bin/perl
use lib 'libs_gestor_etc_hosts';
use variables_globales;
# use bootApp;
use strict;
use warnings;

use Data::Dumper;

# use CGI qw(:standard);
use CGI::Pretty qw(:all);
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);

our $name_app;

my $q = new CGI;
print $q->header;
print "<br><br><br><br><br>\n";
print $q->div( { -id => "errores" }, "", );  # se rellena desde  javascript

print $q->start_html(
    -title  => 'Gestor ETC HOSTS',
    -style  => { 'src' => '/' . $name_app . '/css/css.css' },
    -script => [
        {   -type => "text/javascript",
            -src  => '/' . $name_app . '/js/jquery.js'
        },
        {   -type => "text/javascript",
            -src  => '/' . $name_app . '/js/js.js'
        },
    ],
);

my $error;

print $q->start_form(
    -name    => 'login',
    -method  => 'POST',
    -enctype => &CGI::MULTIPART,
    -action  => '/where/your/form/gets/sent',    # Defaults to
                                                 # the current program
);
print $q->textfield(
    -name      => 'nombre',
    -id        => 'nombre',
    -value        => 'nombre',
    -size      => 20,
    -maxlength => 99,
);
print $q->textfield(
    -name      => 'contrasenya',
    -id        => 'contrasenya',
    -value        => 'contrasenya',
    -size      => 20,
    -maxlength => 99,
);

print $q->button(
    -name    => 'submit_form',
    -value   => 'ENTRAR',
    -onclick => 'javascript: validate_login_form();',
);

print $q->end_form;
