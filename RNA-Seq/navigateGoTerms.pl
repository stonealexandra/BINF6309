#!/bin/perl
use warnings;
use strict;

use Bio::OntologyIO;

#instantiate and assign variable
my $parser = Bio::OntologyIO->new(
	-format => "obo",
	-file   => "go-basic.obo"
);

#open output file for writing
open( OUT_BIO, ">", "bioProcess.tsv" ) or die $!;

#loop through and return name and identifier
#and print to output file in tab separated format
while ( my $ont = $parser->next_ontology() ) {
	if ( $ont->name() eq "biological_process" ) {
		foreach my $leaf ( $ont->get_leaf_terms ) {
			my $go_name = $leaf->name();
			my $go_id   = $leaf->identifier();
			print OUT_BIO join( "\t", $go_id, $go_name ), "\n";
		}
	}
}
