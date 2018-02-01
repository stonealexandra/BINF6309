#!/usr/bin/perl
use warnings;
use strict;
use Bio::Seq::Quality;
use Bio::Seq::Quality;
use Bio::SeqIO;
use Bio::SeqIO;
use Bio::SeqIO;
use Getopt::Long;
use Pod::Usage;

#GLOBALS
my $left        = '';
my $right       = '';
my $interleaved = '';
my $qual        = 0;
my $usage       = "\n$0 [options] \n
Options:
-left	Left reads
-right	Right reads
-qual	Quality score minimum
-help	Show this message
\n";

#check the flags
GetOptions(
	'left=s'        => \$left,
	'right=s'       => \$right,
	'interleaved=s' => \$interleaved,
	'qual=i'        => \$qual,
	help            => sub { pod2usage($usage); },
) or pod2usage(2);

unless ( $left and $right and $qual and $interleaved ) {
	unless ($left) {
		print "Specify file for left reads\n";
	}
	unless ($right) {
		print "Specify file for right reads\n";
	}
	unless ($interleaved) {
		print "Specify file for interleaved output\n";
	}
	unless ($qual) {
		print "Specify file for quality score cutoff\n";
	}
	die $usage;
}

$left = Bio::SeqIO->new(
	-format => 'fastq',
	-file   => $left
);

$right = Bio::SeqIO->new(
	-format => 'fastq',
	-file   => $right
);

$interleaved = Bio::SeqIO->new(
	-format => 'fastq',
	-file   => ">$interleaved"
);

while ( my $seq_objL = $left->next_seq ) {
	my $seq_objR = $right->next_seq;
	$interleaved->write_seq($seq_objL);
	$interleaved->write_seq($seq_objR);
	my $lTrim       = $left->next_seq;
	my $leftTrimmed = $lTrim->get_clear_range($qual);
	$leftTrimmed->desc( $lTrim->desc() );
	$interleaved->write_seq($leftTrimmed);
	my $rTrim        = $right->next_seq;
	my $rightTrimmed = $rTrim->get_clear_range($qual);
	$rightTrimmed->desc( $rTrim->desc() );
	$interleaved->write_seq($rightTrimmed);
}

while ( my $seq_objL = $left->next_seq ) {
	$seq_objL = Bio::Seq::Quality->new(
		-id   => $seq_objL->id(),
		-seq  => $seq_objL->seq,
		-desc => $seq_objL->desc,
		-qual => $seq_objL->()
	);

}

while ( my $seq_objR = $right->next_seq ) {
	$seq_objR = Bio::Seq::Quality->new(
		-id   => $seq_objR->id(),
		-seq  => $seq_objR->seq,
		-desc => $seq_objR->desc,
		-qual => $seq_objR->qual()
	);

}
