#!/bin/bash
#Initialize variable for input and desired output path 
samPath="/home/stone.al/workspace/BINF6309/RNA-Seq/sam/"
samSuffix=".sam"
samToBamOutPath="bam/"
#Loop through all the sam files in $samPath
for leftInFile in $samPath*$samSuffix
do
        #Remove the path and left-read suffix from the filename and assign to sampleName
        pathRemoved="${leftInFile/$samPath}"
        sampleName="${pathRemoved/$samSuffix/}"
        echo samtools sort \
	$samPath$sampleName$samSuffix \
	-o $samToBamOutPath.$sampleName.sorted.bam \
	#1>$sampleName.sort.bam 
done
