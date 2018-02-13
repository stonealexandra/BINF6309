#!/bin/bash
#Initialize variable for input and desired output path 
samPath="sam/"
samSuffix=".sam"
samToBamOutPath="bam/"
#Loop through all the sam files in $samPath
for leftInFile in $samPath*$samSuffix
do
        #Remove the path from the filename and assign to sampleName
        pathRemoved="${leftInFile/$samPath}"
        sampleName="${pathRemoved/$samSuffix/}"
        samtools sort \
	$samPath$sampleName$samSuffix \
	-o $sampleName.sorted.bam \
	1>$sampleName.sort.log 2>$sampleName.sort.err  
done
