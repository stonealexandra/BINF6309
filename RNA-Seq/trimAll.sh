#!/bin/bash
#Initialize variable to contain the directory of un-trimmed fastq files and left read suffix
fastqPath="/scratch/AiptasiaMiSeq/fastq/"
leftSuffix=".R1.fastq"
rightSuffix=".R2.fastq"
#Initialize variables with the desired output path for the paired trimmed reads
pairedOutPath="Paired/"
unpairedOutPath="Unpaired/"
#Loop through all the left-read fastq files in $fastqPath
for leftInFile in $fastqPath*$leftSuffix
do
        #Remove the path and left-read suffix from the filename and assign to sampleName
        pathRemoved="${leftInFile/$fastqPath}"
        sampleName="${pathRemoved/$leftSuffix/}"
        nice -n 19 java -jar /usr/local/programs/Trimmomatic-0.36/trimmomatic-0.36.jar PE \
	-threads 1 -phred33 \
	$fastqPath$sampleName$leftSuffix \
	$fastqPath$sampleName$rightSuffix \
	$pairedOutPath$sampleName$leftSuffix \
	$unpairedOutPath$sampleName$leftSuffix \
	$pairedOutPath$sampleName$rightSuffix \
	$unpairedOutPath$sampleName$rightSuffix \
	HEADCROP:0 \
	ILLUMINACLIP:/usr/local/programs/Trimmomatic-0.36/adapters/TruSeq3-PE.fa:2:30:10 \
	LEADING:20 TRAILING:20 SLIDINGWINDOW:4:30 MINLEN:36 \
	1>sampleName.trim.log 2>sampleName.trim.err &
done
