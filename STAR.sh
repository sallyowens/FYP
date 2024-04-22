#!/bin/bash

# aligning reads to reference genome using STAR, reference genome being used is UCSC hg38
# specify STAR path, refernce genome file, and sjdbOverhang (maximum read length -1)
for i in *_1.fq; do
STAR --genomeDir $star_path --runThreadN 12 --readFilesIn $i ${i%_1.fq}_2.fq --readFilesCommand cat --outFileNamePrefix ${i%_1.fq} --outSAMtype BAM SortedByCoordinate --outSAMunmapped Within --outSAMattributes Standard --sjdbGTFfile $referncegenome_path/hg38.ncbiRefSeq.gtf --sjdbOverhang 149
done

# Move bams and related files to a new directory and create a multiqc summary
mkdir -p ~/FYP/script/coordinate_sorted_bams
mv *.out* ~/FYP/script/coordinate_sorted_bams/
cd ~/FYP/script/coordinate_sorted_bams
multiqc ~/FYP/script/coordinate_sorted_bams -n STAR_multiqc

# samtools index
# bam files need to be indexed for a variety of downstream tools
for i in *Aligned.sortedByCoord.out.bam; do
samtools index $i -@ 12
done
