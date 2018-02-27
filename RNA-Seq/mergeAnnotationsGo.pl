#!/bin/perl
use warnings;
use strict;
use Data::Dumper;

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
	$bioProcess{$go_id} = $go_name;

	#print Dumper(\%bioProcess);
}

open( SP, "<", "aipSwissProt.tsv" ) or die $!;
while (<SP>) {
	chomp;
	my ( $trinity, $swissProt, $description, $eValue ) =
	  split( "\t", $_ );
	if ( defined $spToGo{$swissProt} ) {
		foreach my $go ( sort keys %{ $spToGo{$swissProt} } ) {

			#print join( "\t", $trinity, $description, $swissProt, $go ), "\n";
			if ( defined $bioProcess{$go} ) {
				foreach my $go_name ( sort keys %bioProcess )
				{
					print join( "\t",
						$trinity, $description, $swissProt, $go_name ),
					  "\n";
				}
			}
		}
	}
}

