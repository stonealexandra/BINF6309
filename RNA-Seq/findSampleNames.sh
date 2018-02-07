#!/bin/bash
#Initialize variable to contain the directory of un-trimmed fastq files
fastqPath="/scratch/AiptasiaMiSeq/fastq/"
#Initialize variable to contain the suffix for the left reads
leftSuffix=".R1.fastq"
#Loop through all the left-read fastq files in $fastqPath
for leftInFile in $fastqPath*$leftSuffix
do
        #Print $leftInFile to see what it contains
        echo $leftInFile
        #Remove the path from the filename and assign to pathRemoved
        pathRemoved="${leftInFile/$fastqPath}"
        #Print $pathRemoved to see what it contains after removing the path
        echo $pathRemoved
        #Remove the left-read suffix from $pathRemoved and assign to suffix Removed
        suffixRemoved="${pathRemoved/$leftSuffix/}"
        #Print $suffixRemoved to see what it contains after removing the path
        echo $suffixRemoved
done

