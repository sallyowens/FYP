#!/bin/bash

# -j specifies the number of CPUs to use
# --output specifies the name given to the trimmed read 
# --paired-output specifies the name given to the trimmed read 2 
# --error-rate sets the error tolerance used when searching for adapters (default=0.1)
# --times specifies the number of times to search for an adapter in a read (default=1)
# --overlap specifies the minimum overlap in np between the adapter sequence and the read (default=3)
# --action specifies what to do if an adapter match is found. 
# --minimum-length specifies a minimum length of processed reads to be retained, we chose 20
# --pair-filter determines how to combine the filters for read 1 and read 2 into a single decision about the read pair. 

for i in *_1.fq; do
cutadapt -j=1 --output=trimmed_$i --paired-output=trimmed_${i%_1.fq}_2.fq --error-rate=0.1 --times=1 --overlap=3 --action=trim --minimum-length=20 --pair-filter=any --quality-cutoff=20 $i ${i%_1.fq}_2.fq > trimmed_${i%_1.fq}_cutadapt.log
done

# make new directory for FastQC on trimmed fastq reads
# move the output to this new directory
mkdir -p ~/FYP/script/trimmed_fastq_subset/FastQC
mv trimmed* ~/FYP/script/trimmed_fastq_subset
cd ~/FYP/script/trimmed_fastq_subset

# run FastQC and then MultiQC on trimmed read to comapre quality with raw reads
fastqc *.fq --outdir=~/FYP/script/trimmed_fastq_subset/FastQC
multiqc ~/FYP/script/trimmed_fastq_subset/FastQC -n trimmed_fastqc_multiqc
