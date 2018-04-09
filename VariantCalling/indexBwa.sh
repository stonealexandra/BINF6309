#!/bin/bash
#map low divergent sequences against large reference genome using linear-time algorithm with -p
#as filename  and -a as the algorithm 
nice -n19 bwa index -p vShiloni -a is vShiloni.fasta \
1>bwaIndex.log 2>bwaIndex.err &
