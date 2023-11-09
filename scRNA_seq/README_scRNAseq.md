# Introduction to single cell RNA-seq (scRNA-seq) data analysis
* Authors: Krithika Bhuvaneshwar, Yuriy Gusev
* Affiliation: Innovation Center For Biomedical Informatics (ICBI), and Biomedical Informatics Shared Resource (BISR) at Georgetown University Medical Center (GUMC)

***More about our research work:***
* *ICBI: https://icbi.georgetown.edu*
* *BISR: https://icbi.georgetown.edu/bisr/ and https://lombardi.georgetown.edu/research/sharedresources/bbsr/*

## What is single cell RNA-seq data ?
* Traditional next generation sequencing (NGS) is done on a bulk scale. It is called bulk NGS, and the expression data is averaged
* In contrast scRNA-seq allows users to get thousands of measurements from individual cells across thousands of dimensions (genes)
  Image courtesy: Stephanie Hicks

<img src="https://github.com/ICBI/BISR_Tutorials/blob/main/scRNA_seq/Picture1.png" width="600" height="400">

## Why do we need single cell sequencing ? You can get the same clusters as in flow cytometry
In single cell sequencing, users can 
* sequence every cell 
* look at the transcriptional profiles of each of these clusters to identify different cell types - can get information about each clone 
* Clusters can be further broken down and analyzed by the genes
* Take measurements on 20,000 genes that might be present in samples
* Explore individual clusters - it is possible to re-cluster and get more separation within one cluster 

In contrast flow cytometry and mass cytometry can 
* only sequence a few limited markers 

## Advantages 
* Very high dimensional read out compared to other methods 

## Disadvantages 
* Cannot examine mutations
 
## Applications
* Cancer, Immunology
* Study cell populations in a tissue
* Discover new cell types
* Discover new markers and regulatory pathways
* Reconstruct cellular lineage - (pseudotime cell ordering) i.e. ordering single cells in pseudotime and placing them along a trajectory corresponding to a biological process

## Experimental design
* Tissue of interest --> Disassociation of cells (by using enzymes, cations, chelating agents) --> Isolation of cells -->
  Get Single Cell --> RNA extraction --> cDNA synthesis --> Amplification -->
  Sequencing (Get FASTQ File) --> Get expression matrix --> Analysis

* Common Elements of a Library
    * Library Barcode (Sample Index) - Used to pool multiple samples on one sequencing lane
    * Cell Barcode (10x Barcode) – Used to identify the cell the read came from
    * Unique Molecular Index (UMI) – Used to identify reads that arise during PCR replication
    * Sequencing Reads – Used to identify the gene a read came from
 
<img src="https://github.com/ICBI/BISR_Tutorials/blob/main/scRNA_seq/library.png" width="400" height="110">

 
## Different technologies for isolation of the cels
* Earliest - plate based SMART-seq
* Drop seq - more parallel , droplet based, less expensive
* 10 X genomics - latest (similar to Dropset)
* Microwells - parallel single seq without droplets


## How get the gene expression count matrix file from raw FASTQC files
* Nextflow: https://nf-co.re/scrnaseq which includes the tools in the Figure
* Galaxy: https://training.galaxyproject.org/training-material/topics/single-cell/tutorials/scrna-case_alevin/tutorial.html

<img src="https://github.com/ICBI/BISR_Tutorials/blob/main/scRNA_seq/scrnaseq_pipeline_v1.0_metro_clean.png" width="600" height="200">


**Tools for this processing**
* STARsolo - a droplet-based scRNA-seq-specific variant of the popular genome alignment method STAR. Produces results very close to those of Cellranger 
* Kallisto/ bustools - developed by the originators of the transcriptome quantification method, Kallisto.
* Alevin - another transcriptome analysis method developed by the authors of the Salmon tool.
* Cellranger - Tool from 10X Genomics that uses STAR under the hood

## Popular software tools for analysis of scRNA-seq data matrix files
(a) Monocle 
* Comprehensive package 
* Clustering
* Differential gene expression testing
* Main aseet - Introduced concept of Pseudotime cell ordering

(b) Seurat
* Performs quality control (QC), analysis, and exploration 
* Unsupervised clustering and discovery of cell types and states, 
* Spatial reconstruction of single cell data
* Integrated analysis of single cell RNA-seq across conditions, technologies, and species
* Main asset - ability to use data from different sequencing technology, species or condition, and integrate them to identify shared population across data sets
* Cannot do Pseudotime cell ordering

(c) Scanpy
* Python
* Output data format is an "ann" file
  
## Tools for Downstream analysis (regulatory networks)
* SCENIC: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5937676/
* SCA - IRCM: https://github.com/SCA-IRCM (Allows single cell RNA seq data analysis, clustering, creates internal network and infers cell-cell interactions)

## Recommended reading / workshops
* Stephanie Hicks: https://speakerdeck.com/stephaniehicks/welcome-to-the-world-of-single-cell-rna-sequencing
* UCLa workshops https://qcb.ucla.edu/collaboratory/workshops/w20-single-cell-rna-seq/
* Single cell RNA sequencing, an e-book generated by the Bioinformatics team at NYU for mastering NGS analysis, including scRNA-seq analysis
https://learn.gencore.bio.nyu.edu/single-cell-rnaseq/
* UC Davis Bioinformatics Core: https://ucdavis-bioinformatics-training.github.io/2021-August-Single-Cell-RNA-Seq-Analysis/
* Broad Institute single cell workshop https://broadinstitute.github.io/2020_scWorkshop/
* Orchestrating Single-Cell Analysis with Bioconductor, an e-book that teaches users some common workflows for the analysis of scRNA-seq http://bioconductor.org/books/release/OSCA/

## Platforms that offer pipelines for single cell RNA-seq analysis  
* Single cell RNA-seq data analyis on the Galaxy platform: https://training.galaxyproject.org/training-material/topics/single-cell/
* Single-cell RNA-ses analysis pipelines on the Seven Bridges Cancer Genomics Cloud platform: https://cgc.sbgenomics.com
* Single cell RNA-seq pipelines using Nextflow: https://nf-co.re/scrnaseq

## Types of input data for Seurat or Monocle
Once the raw data in FASTQ file is processed, the data files can be in several formats
* **Data cab be MatrixMarket (MTX) format** 
  The MTX format is a sparse matrix format with genes on the rows and cells on the columns as output by Cell Ranger which is the output from the 10X machine, along with  two metadata files (features information and cell information).
* **RDS format**
  Includes 3 files - expression_matrix, cell_metadata, gene_metadata (gene_annotation) files
IMPORTANT - do NOT use `as.matrix()` on the sparse matrix object. It will convert the sparse matrix into dense matrix object . Dense matrix takes up 20 times more space than sparse matrice

## 10X Genomics platforms
* Chromium - Single cell
  Main applications 
	- Gene exp 3' - used for long read seq also
	- 5' immune profiling - - used for long read seq also
	- million cells in a single cells
	- ATAC
	- Milti-ome
* Chromium - multi-omics
  - Gene exp 3' and 5'
	- proteomics - with cell surface
	- immune cell
	- Functional genomics  - CRISPR, 
	- Antigen specific B and T cell discovery
	- Epigenetics
	- Fixed samples - for fixed and FFPE
* Visium Spatial - compatible with long read
  - whole transcriptome 
	- can do single + spatial on the same cells
	- eg. lung microbiome after viral infection
	- able to pin point location of damage, 
	- saptial context for cll types and genes of interest 
	- Workflows 
		- Fresh frozen - poly A tail - compatible for long reads
		- CytAssit - probe based capture - only 50 bp probe seq - not compatible with long read
* Xenium
  - In situ - what's happening in individual cells (integrated microsscopy)

## References
* https://www.youtube.com/watch?v=k9VFNLLQP8c
* https://medium.com/@HeleneOMICtools/your-top-3-single-cell-rna-sequencing-analysis-tools-221b65fbc57e
* https://training.galaxyproject.org/training-material/topics/single-cell/tutorials/scrna-case_alevin/tutorial.html
* https://training.galaxyproject.org/training-material/topics/single-cell/tutorials/scrna-case_monocle3-rstudio/tutorial.html#monocle-workflow
* Stephanie Hicks: https://speakerdeck.com/stephaniehicks/welcome-to-the-world-of-single-cell-rna-sequencing
* How to use t-SNE effectively: https://distill.pub/2016/misread-tsne/




