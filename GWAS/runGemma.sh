#!/bin/bash
gemma -bfile famEpilepsy -gk 2 -o epilepsy.txt
gemma -bfile famEpilepsy -k output/epilepsy.txt.sXX.txt -eigen -o epilepsy
gemma -bfile famEpilepsy -d output/epilepsy.eigenD.txt \
-u output/epilepsy.eigenU.txt -lmm 1 -o wald
