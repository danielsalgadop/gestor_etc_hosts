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
my $q = new CGI;
# my $session = new CGI::Session("driver:File", undef, {Directory=>'/tmp'});

# my $CGISESSID = $session->param('CGISESSID'); 									# Recuperamos la session.
my $session;  # mock, quitar en produccion
$session = new CGI::Session("driver:File", $q, {'Directory'=>'/tmp/'}); 	# Session actual.


print $q->header;
if($session){
	print "si";
}
else{
	print "no";
}




print "<h1>sldfjasldkjfasldkfjad</h1>";