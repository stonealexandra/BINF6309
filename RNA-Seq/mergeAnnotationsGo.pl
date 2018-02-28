#!/bin/perl
use warnings;
use strict;

#open file handle for writing output
open( OUT_GO, ">", "trinitySpGo.tsv" ) or die $!;

#open file handle for reading
open( SP_TO_GO, "<", "spToGo.tsv" ) or die $!;

#initialize hash to store swissProtIDs and GO terms
my %spToGo;

#loop through and assign and store variables in hash
while (<SP_TO_GO>) {
	chomp;
	my ( $swissProt, $go ) = split( "\t", $_ );
	$spToGo{$swissProt}{$go}++;
}

#open file handle for reading
open( BIO_PROCESS, "<", "bioProcess.tsv" ) or die $!;

#initialize hash to store GO IDs and Names
my %bioProcess = ();

#loop through and assign and store variables in hash
while (<BIO_PROCESS>) {
	chomp;
	my ( $go_id, $go_name ) = split( "\t", $_ );
	$bioProcess{$go_id}{$go_name}++;

}

#open filehandle for reading
open( SP, "<", "aipSwissProt.tsv" ) or die $!;
while (<SP>) {
	chomp;
	my ( $trinity, $swissProt, $description, $eValue ) =
	  split( "\t", $_ );
	if ( defined $spToGo{$swissProt} )
	{    #if swissProt found in hash, loop through keys
		foreach my $go ( sort keys %{ $spToGo{$swissProt} } ) {
			if ( defined $bioProcess{$go} )
			{    #if GO ID found in hash, loop through keys
				foreach my $go_name ( sort keys %{ $bioProcess{$go} } ) {
					print OUT_GO join( "\t",
						$trinity, $description, $swissProt, $go, $go_name )
					  ,    #print in tab separated format to output file
					  "\n";
				}
			}
		}
	}
}
