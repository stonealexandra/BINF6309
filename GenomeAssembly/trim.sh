#!/bin/sh
nice -n 19 java -jar /usr/local/programs/Trimmomatic-0.36/trimmomatic-0.36.jar PE \
-threads 1 -phred33 \
/home/stone.al/workspace/BINF6309/GenomeAssembly/SRR6794364_1.fastq \
/home/stone.al/workspace/BINF6309/GenomeAssembly/SRR6794364_2.fastq \
SRR6794364_1.paired.fastq \
SRR6794364_1.unpaired.fastq \
SRR6794364_2.paired.fastq \
SRR6794364_2.unpaired.fastq \
HEADCROP:0 \
ILLUMINACLIP:/usr/local/programs/Trimmomatic-0.36/adapters/NexteraPE-PE.fa:2:30:10 \
LEADING:20 TRAILING:20 SLIDINGWINDOW:4:30 MINLEN:36 \
1>SRR6794364.trim.log 2>SRR6794364.trim.err &

