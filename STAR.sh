#!/bin/bash

# aligning reads to reference genome using STAR, reference genome being used is UCSC hg38
# Genome indices had already been generated using the following code
# STAR --runThreadN 32 --runMode genomeGenerate --genomeDir /media/newdrive/data/Reference_genomes/Human/UCSC/STAR --genomeFastaFiles /media/newdrive/data/Reference_genomes/Human/UCSC/hg38.fa --sjdbGTFfile /media/newdrive/data/Reference_genomes/Human/UCSC/hg38.ncbiRefSeq.gtf --sjdbOverhang 149
# --runThreadN 32: to speed up the process, the tool will utilise 32 threads for the computation
for i in *_1.fq; do
STAR --genomeDir /media/newdrive/data/Reference_genomes/Human/UCSC/STAR_UCSC_refseq/ --runThreadN 12 --readFilesIn $i ${i%_1.fq}_2.fq --readFilesCommand cat --outFileNamePrefix ${i%_1.fq} --outSAMtype BAM SortedByCoordinate --outSAMunmapped Within --outSAMattributes Standard
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
