#!/bin/bash
#create an array of accession numbers
array=(NZ_CP018308.1 NZ_CP018309.1 NZ_CP018310.1)
#iterate over the array and get accessions from NCBI
for acc in "${array[@]}"
do
bp_download_query_genbank.pl --query $acc --db nucleotide -o $acc".fasta" --format fasta
done

