#!/bin/bash
#create var to store the sam dir and suffix
samDir="sam/"
samSuffix=".sam"
#write column headers
echo -e "Sample,Total,Aligned,Concordant" > alignmentStats.csv
#loop through sam files
for samFile in $samDir*$samSuffix
do
	total="$(samtools view -c $samFile)"
	mapped="$(samtools view -F4 -c $samFile)"
	paired="$(samtools view -f2 -c $samFile)"
	sample="${samFile/$samDir/}"
	sample="${sample/$samSuffix/}"
	echo -e "$sample,$total,$mapped,$paired" >> alignmentStats.csv
done
