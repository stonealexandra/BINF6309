#!/bin/bash
#HaplotypeCaller to determine what part of the genome should be processed using bam files as input and the Reference as vShiloni.fasta
#emitRefConfidence will emit with the GVCF format and the genotyper will determine most likely allele
#LINEAR index type for the indices creates equal width bins of 128000 with the parameter for bin width to pass
#set the minimum confidence threshold at 30 phred-scaled or annotate as Low Quality in order to distinguish high from low conference calls
#and run on 16 threads and output to $vcfOut
mkdir -p vcf
findVariants(){
for bam in noDup/*.bam
do 
vcfOut="${bam/noDup/vcf}"
vcfOut="${vcfOut/bam/vcf}"
nice -n19 java -jar /usr/local/programs/GenomeAnalysisTK-3.8-0/GenomeAnalysisTK.jar \
-T HaplotypeCaller --emitRefConfidence GVCF -R vShiloni.fasta -I $bam --genotyping_mode DISCOVERY \
-variant_index_type LINEAR -variant_index_parameter 128000 \
-stand_call_conf 30 -nct 16 -o $vcfOut
done
}
findVariants 1>findVariants.log 2>findVariants.err &
