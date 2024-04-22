#!/bin/bash

# create name-sorted bam file
# -n sort by name rather than coordinates
# -@ specify number of threads to use
# -o name of output file

mkdir -p ~/FYP/script/name_sorted_bam
for i in *Aligned.sortedByCoord.out.bam; do
samtools sort -n -@ 12 -o ~/name_sorted_bams/${i%Aligned.sortedByCoord.out.bam}_namesorted.bam $i
done

cd ~/name_sorted_bam
mkdir -p ~/FYP/script/counts

# for unstranded libraries
featureCounts -T 12 -p --countReadPairs -C -a /media/newdrive/data/Reference_genomes/Human/UCSC/hg38.ncbiRefSeq.gtf -o ~/FYP/script/counts/featurecounts.txt *namesorted.bam 2> ~/FYP/script/counts/featurecounts.screen-output.log

# -p specifies paired-end reads
# --countReadPairs counts fragments instead of reads (only applicable for paired-end reads)
# -C means do not count read pairs that have their two ends mapping to different chromosomes or mapping to same chromosome but on different strands
# -a identifies the gene annotation gtf file
# -o specifies the name (and path) of the output counts file
# 2 is used to denote Stderr (standard error) output

# run multiQC on featurecounts
multiqc ~/FYP/script/counts -n featurecounts_multiqc

