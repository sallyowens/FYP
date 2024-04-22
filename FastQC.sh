#!/bin/bash

# Make new directories the raw fastq files and FASTQC output
# -p: allows for any parent directory to be created if it does not alreay exist
mkdir -p ~/FYP/script/raw_fastq_subset/FastQC
cd ~/FYP/script/raw_fastq_subset

# Run FASTQC on files
# wildcard (*): runs command on all files ending with .fq
# --ourdir=: put the output in the desired directory (FastQC)
fastqc *.fq --outdir=/media/newdrive/GCB2024/sallyowens/FYP/script/raw_fastq_subset/FastQC

# run MultiQC on FastQC reports to generate summary report for quality assessment on reads
multiqc /media/newdrive/GCB2024/sallyowens/FYP/script/raw_fastq_subset/FastQC

