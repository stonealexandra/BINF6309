#!/bin/bash
nice -n19 java -jar /usr/local/programs/GenomeAnalysisTK-3.8-0/GenomeAnalysisTK.jar -T AnalyzeCovariates -R vShiloni.fasta -before recal_data.table -after post_recal_data.table -plots recalibration_plots.pdf
