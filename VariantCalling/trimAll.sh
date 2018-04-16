#!/bin/sh
pairedOutPath='Paired/'
unpairedOutPath='Unpaired/'
mkdir -p $pairedOutPath
mkdir -p $unpairedOutPath
trimAll(){
for leftInFile in *_1.fastq.gz
	do
		rightInFile="${leftInFile/_1/_2}"
		nice -n 19 java -jar /usr/local/programs/Trimmomatic-0.36/trimmomatic-0.36.jar PE \
		-threads 4 -phred33 \
		~/BINF6309/VariantCalling/$leftInFile \
		~/BINF6309/VariantCalling/$rightInFile \
		~/BINF6309/VariantCalling/$pairedOutPath$leftInFile \
		~/BINF6309/VariantCalling/$unpairedOutPath$leftInFile \
		~/BINF6309/VariantCalling/$pairedOutPath$rightInFile \
                ~/BINF6309/VariantCalling/$unpairedOutPath$rightInFile \
		HEADCROP:0 \
		ILLUMINACLIP:/usr/local/programs/Trimmomatic-0.36/adapters/NexteraPE-PE.fa:2:30:10 \
		LEADING:20 TRAILING:20 SLIDINGWINDOW:4:30 MINLEN:36
	done
}
trimAll 1>trimAll.log 2>trimAll.err &