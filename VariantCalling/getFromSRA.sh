#!/bin/bash
#set the varriable with file containing SRA accessions
filename="SRR_Acc_List.txt"
#create function to read file in line by line
getAll(){
	while read -r line
	do
		#get FASTQ
		fastq-dump $line --split-3 --gzip
	done < "$filename"
}
#call function in background
getAll 1>get.log 2>get.err &
