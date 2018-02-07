#!/bin/sh
samtools index \
Aip02.sorted.bam \
-o Aip02.sorted.bam.bai \
1>Aip02.index.log 2>Aip02.index.err &
