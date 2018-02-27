#!/bin/perl
use warnings;
use strict;

use Bio::OntologyIO;

my $parser = Bio::OntologyIO->new(
	-format => "obo",
	-file   => "go-basic.obo"
);

open( OUT_BIO, ">", "bioProcess.tsv" ) or die $!;

while ( my $ont = $parser->next_ontology() ) {
	if ( $ont->name() eq "biological_process" ) {
		foreach my $leaf ( $ont->get_leaf_terms ) {
			my $go_name = $leaf->name();
			my $go_id   = $leaf->identifier();
			print OUT_BIO join( "\t", $go_id, $go_name ), "\n";
		}
	}
}
