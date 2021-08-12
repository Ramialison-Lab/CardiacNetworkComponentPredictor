#! /bin/bash
for i in {0..1000}
do
  shuf -n 4450 RawHeartEnhancers.bed > out/random_RawHeartEnhancers.bed
  bedtools intersect -a Pennacchio_mm9.sorted.bed -b out/random_RawHeartEnhancers.bed | wc -l >> out/countLines_Pennacchio.txt
  bedtools intersect -a VISTAheart_liftover_mm9.sorted.bed -b out/random_RawHeartEnhancers.bed | wc -l >> out/countLines_VISTAheart.txt
done

#bedtools intersect -a Pennachio_mm9.sorted.bed -b Dang_enhancer_mm9.sorted.bed >> out/intersect_Pennacchio_Dang_enhancer.txt
#bedtools intersect -a VISTAheart_liftover_mm9.sorted.bed -b Dang_enhancer_mm9.sorted.bed >> out/test1.txt
#shuf -n 4450 RawHeartEnhancers.bed > out/random_RawHeartEnhancers.bed
#bedtools intersect -a Pennacchio_mm9.sorted.bed -b out/random_RawHeartEnhancers.bed >> out/intersect_raw_Pennacchio.txt
#bedtools intersect -a Pennacchio_mm9.sorted.bed -b out/random_RawHeartEnhancers.bed | wc -l >> out/countLines.txt
