# Introduction to RNA-seq data analysis

Authors: Krithika Bhuvaneshwar, Yuriy Gusev

Affiliation: Innovation Center For Biomedical Informatics (ICBI), and Biomedical Informatics Shared Resource (BISR) at Georgetown University Medical Center (GUMC)

More about our research work:
* ICBI: https://icbi.georgetown.edu
* BISR: https://icbi.georgetown.edu/bisr/ and https://lombardi.georgetown.edu/research/sharedresources/bbsr/

## Recommended reading about basics on NGS data and file formats
* From NYU : https://learn.gencore.bio.nyu.edu/
* From UCDavis: https://ucdavis-bioinformatics-training.github.io/
* NIH webinars : https://bioinformatics.niaid.nih.gov/resources
* Coursera

## How RNA-seq data is obtained
(Image courtsey wikipedia)
![image](https://github.com/ICBI/BISR_Tutorials/assets/1800604/bccbbdb8-d9c0-40da-98a5-db4b5b6d86cb)

## Comparison of the older microarray techonology vs RNA-seq
(Reference: Illumina webiste)

| Microarray technology                                                                 | RNA-sequencing (RNA-seq)                                                                                 |
| ------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------- |
| Older technology                                                                      | Newer technology                                                                                         |
| Less sensitive                                                                        | More sensitive - can detect genes that have low expression                                               |
| Can only quantify gene expression                                                     | Can quantify gene expression, detect novel transcripts, gene fusions, single nucleotide variants, indels |
| Lower dynamic range - around 10^3                                                     | Can quantify expression across a larger dynamic range - more than 10^5                                   |
| Example platforms – Affymetrix U133Plus2, Illumina BeadChip |Example sequencing machines: Illumina HiSeq, Illumina MiSeq 

## Applications of RNA-seq data
* Transcriptome quantification to get RNA-seq expression data
* Differential expression analysis --> identify potential biomarkers, including fusion transcript, other RNA
* Variant calling
* Immuno oncology analysis (deconvolution, HLA type prediction)
* Detect and quantify microbes in RNA-seq data
* Neoantigen profiling

## Processing of raw RNA-seq data
Raw RNA-seq data is in the form of FASTQ files. There are several standard pipelines / tools / platforms that can be used for this
* Bioconductor workflows
* Seven Bridges Cancer Genomics cloud
* Galaxy platform
* Nextflow nf-core pipeline (image below)
  ![image](https://github.com/ICBI/BISR_Tutorials/assets/1800604/b350d218-a85d-4306-8f4a-d805a5988057)

## Comprehensive tutorials
* RNAseq with Bioconductor from Rockefeller University: https://rockefelleruniversity.github.io/RU_RNAseq/
* Gene level exploratory analysis using Bioc : https://master.bioconductor.org/packages/release/workflows/vignettes/rnaseqGene/inst/doc/rnaseqGene.html

## Advanced tutorials from Georgetown-BISR : requires programming experience
* Tutorial - how to perform group comparison analysis on RNA-seq gene expression raw count data . LINK https://github.com/ICBI/BISR_Tutorials/blob/main/RNA_seq/RNAseq_CompareGroups.ipynb


