#!/bin/bash
plink --bfile famEpilepsy --chr-set 38 --assoc --adjust --out epilepsy.txt
