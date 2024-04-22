# Bulk RNA-seq Scripts

## Description
This project contains scripts designed to streamline a bulk RNA sequecning pipeline for paired-end reads. 
RNA seqencing is an advancing next generation sequencing technology that provides a comprehensive view of the entire transcriptome for applications such as gene expression profiling, differential gene expression analysis and variant analysis. 
These scripts aim to simplify the RNA sequencing process making it easy for scientists of all levels to follow.

## Table of Contents
- Installiation
- Usage
- Execution
- Contact

## Installation
Working in linux environment on Windows or Terminal in macOS. Tools such as 'emacs' are needed as a text editor and 'chmod' for changing file premissions. Clone this repository to local macheine.

Please use the scripts in the following order
- **FastQC**
- **CutAdpat** (only if necessary after assessing quality of files)
- **STAR**
- **RSeQC**
- **faturecounts**

## Usage
To get started with this project, navigate to your terminal and run the scripts in the order outlined in the Installation section for optimal performance.

## Execution

 1. **Initial FastQC**
Running this script will first create the directory for the project.
Of note, fastq files must end in .fq, please adjust code if necessary.
```bash
   bash FastQC.sh
```

2. **Trimming**
After assessing FastQC and MultiQC output, decide if trimming is necessary to remove adapter content or low quality bases or alternatively skip this script if not necessary.
```bash
   bash cutadapt.sh
```

3. **Alignment with STAR**
STAR aligner was chosen to map reads to the refernece genome (hg38). This script also includes creating index BAM files.
Please note your maximum read length and adjust sjdbOverhang accordingly (maximum read length minus 1).
```bash
   bash STAR.sh
```

4. **RSeQC**
Running this script to check the quality of the mapping from STAR.
```bash
   bash RSeQC.sh
```

5. **featureCounts**
This is the final script in this pipeline and it counts the gene features from the aligned reads.
This script requires the knowledge if the library is stranded or not. By default, it assumes a non-stranded library, if this is not the case please adjust accordingly.
```bash
   bash featurecounts.sh
```

## Author
Sally Owens - sallyellenowens@gmail.com
