#!/bin/perl
use warnings;
use strict;


open( OUT_GO, ">", "trinitySpGo.tsv" ) or die $!;

open( SP_TO_GO, "<", "spToGo.tsv" ) or die $!;

my %spToGo;

while (<SP_TO_GO>) {
	chomp;
	my ( $swissProt, $go ) = split( "\t", $_ );
	$spToGo{$swissProt}{$go}++;
}

open( BIO_PROCESS, "<", "bioProcess.tsv" ) or die $!;

my %bioProcess = ();

while (<BIO_PROCESS>) {
	chomp;
	my ( $go_id, $go_name ) = split( "\t", $_ );
	$bioProcess{$go_id}{$go_name}++;

	
}

open( SP, "<", "aipSwissProt.tsv" ) or die $!;
while (<SP>) {
	chomp;
	my ( $trinity, $swissProt, $description, $eValue ) =
	  split( "\t", $_ );
	if ( defined $spToGo{$swissProt} ) {
		foreach my $go ( sort keys %{ $spToGo{$swissProt} } ) {
			if ( defined $bioProcess{$go} ) {
				foreach my $go_name (sort keys %{ $bioProcess{$go}})
				{
					print OUT_GO join( "\t",
						$trinity, $description, $swissProt, $go, $go_name ),
					  "\n";
				}
			}
		}
	}
}

