#!/usr/bin/perl
use strict;
use warnings;

use lib 'libs_gestor_etc_hosts';
use variables_globales;

use Data::Dumper;

use CGI::Session;
# use CGI qw(:standard);
use CGI::Pretty qw(:all);
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
