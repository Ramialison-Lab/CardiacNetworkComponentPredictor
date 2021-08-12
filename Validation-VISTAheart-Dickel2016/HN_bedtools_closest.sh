#! /bin/bash

#bedtools sort -k1,1 -k2,2n Pennachio_mm9.bed > Pennachio_mm9.sorted.bed

bedtools sort -i Dang_enhancer_mm9.bed > Dang_enhancer_mm9.sorted.bed
bedtools sort -i hg19_ext_latest.bed > hg19_ext_latest.sorted.bed
bedtools sort -i Pennachio_mm9_v1.bed > Pennachio_mm9.sorted.bed


bedtools sort -i VISTAheart_liftover_mm9.bed > VISTAheart_liftover_mm9.sorted.bed


bedtools closest -a Pennachio_mm9.bed -b Dang_enhancer_promoter_mm9.bed >> match_Pennacchio_Dang.txt

bedtools closest -a hg19_ext_latest.sorted.bed -b Dang_enhancer_promoter_mm9.sorted.bed >> match_VISAHeart_Dang.txt

#bedtools intersect -a VISTAheart_liftover_mm9.sorted.bed -b Dang_enhancer_promoter_mm9.sorted.bed >> intersect_VISAHeart_Dang.txt

bedtools intersect -a VISTAheart_liftover_mm9.sorted.bed -b Dang_enhancer_mm9.sorted.bed >> intersect_VISAHeart_Dang_enhancer.txt
bedtools intersect -a Pennachio_mm9.sorted.bed -b Dang_enhancer_mm9.sorted.bed >> intersect_Pennacchio_Dang_enhancer.txt


