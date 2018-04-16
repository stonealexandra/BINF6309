#!/bin/bash
vcfOut='recal_data.table'
recalibrateBases(){
for bam in noDup/*.bam
do
nice -n19 java -jar /usr/local/programs/GenomeAnalysisTK-3.8-0/GenomeAnalysisTK.jar -T BaseRecalibrator -R vShiloni.fasta -I $bam -knownSites filteredSnps.vcf -o $vcfOut
done
}
recalibrateBases 1>recalibrateBases.log 2>recalibrateBases.err & 
