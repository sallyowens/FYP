#!/bin/bash

mkdir -p ~/FYP/script/coordinate_sorted_bams/rseqc/infer_experiment

# Infer whether strand-specific RNA-seq data was performed: Only need to check this for one bam file
for i in *Aligned.sortedByCoord.out.bam; do
infer_experiment.py -r /media/newdrive/data/Reference_genomes/Human/UCSC/hg38.ncbiRefSeq.bed12 -i RNA_S11Aligned.sortedByCoord.out.bam > ~/FYP/script/coordinate_sorted_bams/rseqc/infer_experiment/${i%Aligned.sortedByCoord.out.bam}.infer_exp.txt
done

# Summarizing mapping statistics of a BAM file
for i in *Aligned.sortedByCoord.out.bam; do
bam_stat.py -i $i > ~/rseqc/${i%Aligned.sortedByCoord.out.bam}.bamstats.txt
done


mkdir -p ~/FYP/script/coordinate_sorted_bams/rseqc/read_distribution

# Calculate how mapped reads were distributed over genome feature
for i in *Aligned.sortedByCoord.out.bam; do
read_distribution.py -i $i -r /media/newdrive/data/Reference_genomes/Human/UCSC/hg38.ncbiRefSeq.bed12 > ~/FYP/script/coordinate_sorted_bams/rseqc/read_distribution/${i%Aligned.sortedByCoord.out.bam}.read_dist.txt
done


mkdir -p ~/FYP/script/coordinate_sorted_bams/rseqc/gene_body_coverage

# Calculate the RNA-seq reads coverage over gene body
# This checks to see if we are getting even coverage across the full length of the gene, or if there any 3' or 5' bias
for i in *Aligned.sortedByCoord.out.bam; do
geneBody_coverage.py -i $i -r /media/newdrive/data/Reference_genomes/Human/UCSC/hg38.ncbiRefSeq.bed12 -o ~/FYP/script/coordinate_sorted_bams/rseqc/gene_body_coverage/${i%Aligned.sortedByCoord.out.bam}
done



mkdir -p ~/FYP/script/coordinate_sorted_bams/rseqc/TIN

# Calculate transcript integrity number (TIN) to confirm quality of files
for i in *Aligned.sortedByCoord.out.bam; do
tin.py -i $i -r /media/newdrive/data/Reference_genomes/Human/UCSC/hg38.ncbiRefSeq.bed12 > ~/FYP/script/coordinate_sorted_bams/rseqc/TIN/${i%Aligned.sortedByCoord.out.bam}.output
done


# Run multiqc on the results

cd ~/FYP/script/coordinate_sorted_bams/rseqc/gene_body_coverage
multiqc ~/FYP/script/coordinate_sorted_bams/rseqc/gene_body_coverage -n reseqc_gene_body_coverage_multiqc

cd ~/FYP/script/coordinate_sorted_bams/rseqc/read_distribution
multiqc ~/FYP/script/coordinate_sorted_bams/rseqc/read_distribution -n reseqc_read_distribution_multiqc

cd ~/FYP/script/coordinate_sorted_bams/rseqc/infer_experiment
multiqc ~/FYP/script/coordinate_sorted_bams/rseqc/infer_experiment -n reseqc_infer_experiment_multiqc
