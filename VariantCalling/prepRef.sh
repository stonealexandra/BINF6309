#!/bin/bash
#use vShiloni.fasta as the file
samtools faidx vShiloni.fasta
#create a sequence dictionary from the reference sequence vShiloni.fasta
java -jar /usr/local/bin/picard.jar CreateSequenceDictionary \
R=vShiloni.fasta O=vShiloni.dict \
1>prepRef.log 2>prepRef.err &
