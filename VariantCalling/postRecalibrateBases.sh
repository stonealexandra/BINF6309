#!/bin/bash
vcfOut='post_recal_data.table'
postRecalibrateBases(){
for bam in noDup/*.bam
do
nice -n19 java -jar /usr/local/programs/GenomeAnalysisTK-3.8-0/GenomeAnalysisTK.jar -T BaseRecalibrator -R vShiloni.fasta -I $bam -knownSites filteredSnps.vcf -BQSR recal_data.table -o $vcfOut
done
}
postRecalibrateBases 1>postRecalibrateBases.log 2>postRecalibrateBases.err &
