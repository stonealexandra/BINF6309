#!/bin/perl
use Bio::SearchIO;
use Bio::Search::Result::GenericResult;
use Data::Dumper;
use Bio::SeqIO;

my $blastXml = Bio::SearchIO->new(
	-file 	=> 'Trinity-GG.blastp.xml',
	-format =>	'blastxml'
	);

open(AIP_OUT, ">", 'aipSwissProt.tsv') or die $!;
print AIP_OUT "Trinity","\t", "SwissProt","\t", "SwissProtDesc","\t", "eValue","\n";
	
while ( my $result = $blastXml->next_result()){
	my $queryDesc = $result->query_description;
	if ( $queryDesc =~ /::(.*?)::/ ) {
	my $queryDescShort = $1;
	my $hit = $result->next_hit;
	if ($hit){
			print AIP_OUT $queryDescShort,"\t";
			print AIP_OUT $hit->accession, "\t";
			my $subjectDescription = $hit->description;
			if($subjectDescription =~/Full=(.*?);/){
				$subjectDescription = $1;
			}
			if ($subjectDescription =~/Full=(.*?)\[/){
				$subjectDescription = $1;
			}
			print AIP_OUT $subjectDescription, "\t";
			print AIP_OUT $hit->significance, "\n";
			
	}
	
}	
}

