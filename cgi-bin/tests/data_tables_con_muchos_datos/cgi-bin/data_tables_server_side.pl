#!/usr/bin/perl -w
# script llamado desde jquery datatables

use strict;
use Data::Dumper;
use JSON;

my %json_mock;
$json_mock{sEcho} = 1;
$json_mock{iTotalRecords} = 57;
$json_mock{iTotalDisplayRecords} = 57;
my @aaData = (["IP1", "HOSTNAME1"],["IP2", "HOSTNAME2"]);
$json_mock{aaData} = \@aaData;
# print Dumper(%json_mock);




 my $json=new JSON;

my $encoded = $json->encode(\%json_mock);
print "Content-type: text/html\n\n";
print $encoded;


# my $json_data= '{
#   "sEcho": 1,
#   "iTotalRecords": "57",
#   "iTotalDisplayRecords": "57",
#   "aaData": [
#     [
#       "Gecko",
#       "Firefox 1.0",
#       "Win 98+ / OSX.2+",
#       "1.7",
#       "A"
#     ],
#     [
#       "Gecko",
#       "Firefox 1.5",
#       "Win 98+ / OSX.2+",
#       "1.8",
#       "A"
#     ],
#     [
#       "Gecko",
#       "Firefox 2.0",
#       "Win 98+ / OSX.2+",
#       "1.8",
#       "A"
#     ],
#     [
#       "Gecko",
#       "Firefox 3.0",
#       "Win 2k+ / OSX.3+",
#       "1.9",
#       "A"
#     ],
#     [
#       "Gecko",
#       "Camino 1.0",
#       "OSX.2+",
#       "1.8",
#       "A"
#     ],
#     [
#       "Gecko",
#       "Camino 1.5",
#       "OSX.3+",
#       "1.8",
#       "A"
#     ],
#     [
#       "Gecko",
#       "Netscape 7.2",
#       "Win 95+ / Mac OS 8.6-9.2",
#       "1.7",
#       "A"
#     ],
#     [
#       "Gecko",
#       "Netscape Browser 8",
#       "Win 98SE+",
#       "1.7",
#       "A"
#     ],
#     [
#       "Gecko",
#       "Netscape Navigator 9",
#       "Win 98+ / OSX.2+",
#       "1.8",
#       "A"
#     ],
#     [
#       "Gecko",
#       "Mozilla 1.0",
#       "Win 95+ / OSX.1+",
#       "1",
#       "A"
#     ]
#   ]
# }';
# # my $informacion=$json->encode($json);

# # print "$informacion";
# print $json_data;