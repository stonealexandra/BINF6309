#!/bin/bash
#Initialize variable for input and desired output path
bamPath="bam/"
bamSuffix="sort.log"
bamToBamOutPath="bam/"
#Loop through all the bam log files in $bamPath
for leftInFile in $bamPath*$bamSuffix
do
        #Remove the path from the filename and assign to sampleName
        pathRemoved="${leftInFile/$bamPath}"
        sampleName="${pathRemoved/$bamSuffix/}"
        samtools index \
        $bamPath$sampleName$bamSuffix \
        1>$sampleName.index.log 2>$sampleName.index.err
done
