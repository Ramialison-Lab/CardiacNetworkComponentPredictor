#!/bin/bash

## Step 1 (Python) - Calculating all the CREs between the organs and their overlaps
cd data/h3k4me1
python3 ../../scripts/LD_getSubsets.py H3K4me1Heartmm9E14halfEncodeLicr.bed H3K4me1Limbmm9E14halfEncodeLicr.bed H3K4me1Livermm9E14halfEncodeLicr.bed H3K4me1Wbrainmm9E14halfEncodeLicr.bed ../../out/
cd ../h3k4me3
python3 ../../scripts/LD_getSubsets.py H3K4me3Heartmm9UE14halfEncodeLicr.bed H3K4me3Limbmm9UE14halfEncodeLicr.bed H3K4me3Livermm9UE14halfEncodeLicr.bed H3K4me3Wbrainmm9UE14halfEncodeLicr.bed ../../out/
cd ../h3k27ac
python3 ../../scripts/LD_getSubsets.py H3K27acHeartmm9UE14halfEncodeLicr.bed H3K27acLimbmm9UE14halfEncodeLicr.bed H3K27acLivermm9UE14halfEncodeLicr.bed H3K27acWbrainmm9UE14halfEncodeLicr.bed ../../out/

## Step 2 (outside this script): Use GREAT database (http://great.stanford.edu/great/public-3.0.0/html/) to map the above CREs to the associated genes

## Step 3 (Perl): Process GREAT output files to produce heart-specific gene candidates 
cd ../../
perl scripts/compare_GREAT_genes.pl data/great_output/enhancer_promoters_heart_only.txt data/heart-E14.5-gene-expression/001_heart-E14.5-1_2_expr.txt data/heart-E14.5-gene-expression/002_mart_export-6_mrk_ensids_NM.txt >> out/enhancer_promoters_heart_only_expressed.txt
perl scripts/compare_GREAT_genes.pl data/great_output/enhancers_heart_only.txt data/heart-E14.5-gene-expression/001_heart-E14.5-1_2_expr.txt data/heart-E14.5-gene-expression/002_mart_export-6_mrk_ensids_NM.txt >> out/enhancers_heart_only_expressed.txt
perl scripts/compare_GREAT_genes.pl data/great_output/promoters_heart_only.txt data/heart-E14.5-gene-expression/001_heart-E14.5-1_2_expr.txt data/heart-E14.5-gene-expression/002_mart_export-6_mrk_ensids_NM.txt >> out/promoters_heart_only_expressed.txt
perl scripts/compare_GREAT_genes.pl data/great_output/enhancer_promoters_ubiquitous.txt data/heart-E14.5-gene-expression/001_heart-E14.5-1_2_expr.txt data/heart-E14.5-gene-expression/002_mart_export-6_mrk_ensids_NM.txt >> out/enhancer_promoters_ubiquitous_expressed.txt 
