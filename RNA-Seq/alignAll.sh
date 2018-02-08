#!/bin/bash
#Initialize variable to contain the directory of trimmed paired fastq files 
fastqPath="/scratch/AiptasiaMiSeq/fastq/"
#initialize variable to contain the suffix for the left reads
leftSuffix=".R1.fastq"
rightSuffix=".R2.fastq"
pairedOutPath="sam/"
#Loop through all the left-read fastq files in $fastqPath
for leftInFile in $fastqPath*$leftSuffix
do
	#Remove the path and left-read suffix from the filename and assign to sampleName
        pathRemoved="${leftInFile/$fastqPath}"
        sampleName="${pathRemoved/$leftSuffix/}"
	echo nice -n 19 gsnap \
	-A sam \
	-s AiptasiaGmapIIT.iit \
	-D . \
	-d AiptasiaGmapDb \
	$fastqPath$sampleName$leftSuffix \
        $fastqPath$sampleName$rightSuffix \
        $pairedOutPath$sampleName$leftSuffix \
        $pairedOutPath$sampleName$rightSuffix \
	#1>$sampleName.sam 2>$sampleName.err 
done
