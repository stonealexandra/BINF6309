#!/usr/bin/perl
use warnings;
use strict;

use Bio::SeqIO;
use Bio::SeqIO;
use Bio::SeqIO;
use Bio::Seq::Quality;
use Bio::Seq::Quality;


my $left = Bio::SeqIO->new(
	-format => 'fastq',
	-file   => 'Sample.R1.fastq'
);

my $right = Bio::SeqIO->new(
	-format => 'fastq',
	-file   => 'Sample.R2.fastq'
);

my $out = Bio::SeqIO->new(
	-format => 'fastq',
	-file   => '>Interleaved.fastq'
);

my $seq_objL;
my $seq_objR;

while ( $seq_objL = $left  -> next_seq) {
	$seq_objL = Bio::Seq::Quality->new(
        -id => $seq_objL->id(),
        -seq => $seq_objL->seq,
        -desc => $seq_objL->desc,
        -qual => $seq_objL->qual(),
        );
         
         $out->write_seq($seq_objL);
}

		
while ( $seq_objR = $right -> next_seq) {
	$seq_objR = Bio::Seq::Quality->new(
        -id => $seq_objR->id(),
        -seq => $seq_objR->seq,
        -desc => $seq_objR->desc,
        -qual => $seq_objR->qual()
        );
        $out->write_seq($seq_objR);
}



