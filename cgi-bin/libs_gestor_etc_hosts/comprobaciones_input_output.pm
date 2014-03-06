#!/usr/bin/perl
use warnings;
use strict;
# Funciones que comprueban si ficheros y/o carpetas son Escribibles y/o Leibles


##############################################################################
# Function ficheroLeible                                                     #
#                                                                            #
# Parameters:                                                                #
#   path_fichero - path al fichero                                           #
#                                                                            #
# Returns:                                                                   #
#   %return{status} - "OK";  =>    es leible                                 #
#   $return{status} -  "FAIL" => se rellena $return{avalue}                  #
#   $return{avalues} - referencia a aarray conlas descripciones de los fallos #
#                                                                            #
#   Posibles fallos encontrados                                              #
#   - fichero no existe                                                      #
#   - fichero esta vacio                                                     #
#   - fichero no es leible                                                   #
#   - fichero no es plain text                                               #
##############################################################################
sub ficheroLeible($){
    my $unpath = shift;
    my %return;
    $return{status} = "OK";
    my @errores_encontrados;

    # comprobar integridad de los ficheros de entrada (que existen, que no son vacios, que son leeibles y q son plain text)
    unless (-e $unpath) {
        $return{status} = "FAIL";
        push(@errores_encontrados,"ERROR_FICHERO1: el fichero " . $unpath . " no existe");
    }
    else{
        unless (-r $unpath) {
            $return{status} = "FAIL";
            push(@errores_encontrados,"ERROR_FICHERO3: el fichero " . $unpath . " no es leible");
        }
        unless (-f $unpath) {
            $return{status} = "FAIL";
            push(@errores_encontrados,"ERROR_FICHERO4: el fichero " . $unpath . " no es plain text");
        }
    }
    $return{avalues} = \@errores_encontrados;
    return(%return)
}
###############################################################################
# Function ficheroEscribible                                                  #
#                                                                             #
# Parameters:                                                                 #
#   path_fichero - path al fichero                                            #
#                                                                             #
# Returns:                                                                    #
#   %return{status} - "OK";  =>    es leible                                  #
#   $return{status} -  "FAIL" => se rellena $return{avalue}                   #
#   $return{avalues} - referencia a aarray conlas descripciones de los fallos #
#                                                                             #
#   Posibles fallos encontrados                                               #
#   - fichero no es escribible                                                #
###############################################################################
sub ficheroEscribible($){
    my $unpath = shift;
    my %return;
    $return{status} = "OK";
    my @errores_encontrados;

    # comprobar integridad de los ficheros de entrada (que existen, que no son vacios, que son leeibles y q son plain text)
    unless (-W $unpath) {
        $return{status} = "FAIL";
        push(@errores_encontrados,"ERROR_FICHERO5: el fichero " . $unpath . " no es escribible");
    }
    $return{avalues} = \@errores_encontrados;
    return(%return)
}

##############################################################################
# Function carpetaLeible                                                     #
#                                                                            #
# Parameters:                                                                #
#   path_carpeta - path al carpeta                                           #
#                                                                            #
# Returns:                                                                   #
#   %return{status} - "OK";  =>    es leible                                 #
#   $return{status} -  "FAIL" => se rellena $return{avalue}                  #
#   $return{avalue} - referencia a aarray conlas descripciones de los fallos #
#                                                                            #
#   Posibles fallos encontrados                                              #
#   - carpeta no existe                                                      #
#   - carpeta esta vacio                                                     #
#   - carpeta no es leible                                                   #
#   - carpeta no es plain text                                               #
##############################################################################
sub  carpetaLeible($){
    my $unpath = shift;
    my %return;
    $return{status} = "OK";
    my @errores_encontrados;

    # comprobar integridad de los carpetas de entrada (que existen, que no son vacios, que son leeibles y q son plain text)
    unless (-e $unpath) {
        $return{status} = "FAIL";
        push(@errores_encontrados,"ERROR_CARPETA1: la carpeta " . $unpath . " no existe");
    }
    else{
        unless (-r $unpath) {
            $return{status} = "FAIL";
            push(@errores_encontrados,"ERROR_CARPETA3: la carpeta " . $unpath . " no es leible");
        }
        if (-f $unpath) {
            $return{status} = "FAIL";
            push(@errores_encontrados,"ERROR_CARPETA4: la carpeta " . $unpath . " no es una carpeta, sino plain text");
        }
    }
    $return{avalues} = \@errores_encontrados;
    return(%return)
}

###############################################################################
# Function carpetaEscribible                                                  #
#                                                                             #
# Parameters:                                                                 #
#   path_carpeta - path al carpeta                                            #
#                                                                             #
# Returns:                                                                    #
#   %return{status} - "OK";  =>    es leible                                  #
#   $return{status} -  "FAIL" => se rellena $return{avalue}                   #
#   $return{avalues} - referencia a aarray conlas descripciones de los fallos #
#                                                                             #
#   Posibles fallos encontrados                                               #
#   - carpeta no es escribible                                                #
###############################################################################
sub  carpetaEscribible($){
    my $unpath = shift;
    my %return;
    $return{status} = "OK";
    my @errores_encontrados;

    # comprobar integridad de los carpetas de entrada (que existen, que no son vacios, que son leeibles y q son plain text)
    unless (-W $unpath) {
        $return{status} = "FAIL";
        push(@errores_encontrados,"ERROR_CARPETA5: la carpeta " . $unpath . " no es escribible");
    }
    $return{avalues} = \@errores_encontrados;
    return(%return)
}





1;