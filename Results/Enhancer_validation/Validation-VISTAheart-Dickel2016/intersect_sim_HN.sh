#! /bin/bash
#Randomly selected 4450 CREs from  the raw heart enhancers, repeat the simulation 1000 times
for i in {0..1000}
do
  shuf -n 4450 RawHeartEnhancers.bed > out/random_RawHeartEnhancers.bed
  bedtools intersect -a Pennacchio_mm9.sorted.bed -b out/random_RawHeartEnhancers.bed | wc -l >> out/countLines_Pennacchio.txt
  bedtools intersect -a VISTAheart_liftover_mm9.sorted.bed -b out/random_RawHeartEnhancers.bed | wc -l >> out/countLines_VISTAheart.txt
done

