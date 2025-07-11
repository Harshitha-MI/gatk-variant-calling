#!/bin/bash

# Script to call germline variants in a human WGS paired end reads 2 X 100bp
# Following GATK4 best practices workflow - https://gatk.broadinstitute.org/hc/en-us/articles/360035535932-Germline-short-variant-discovery-SNPs-Indels-
# This script is for demonstration purposes only


# download data
#wget -p ~/wgs_va/reads ftp://ftp-trace.ncbi.nih.gov/1000genomes/ftp/phase3/data/HG00096/sequence_read/SRR062634_1.filt.fastq.gz
#wget -p ~/wgs_va/reads ftp://ftp-trace.ncbi.nih.gov/1000genomes/ftp/phase3/data/HG00096/sequence_read/SRR062634_2.filt.fastq.gz


echo "Run Prep files..."

################################################### Prep files (TO BE GENERATED ONLY ONCE) ##########################################################
if false
then
#create directory
if [ ! -d ~/wgs_va/supporting_files/hg38 ]; then
    mkdir -p ~/wgs_va/supporting_files/hg38
    echo "Created directory: ~/wgs_va/supporting_files/hg38"
else
    echo "Directory already exists: ~/wgs_va/supporting_files/hg38"
fi

# download reference files
wget -P ~/wgs_va/supporting_files/hg38/ https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz
gunzip ~/wgs_va/supporting_files/hg38/hg38.fa.gz

# index ref - .fai file before running haplotype caller
samtools faidx ~/wgs_va/supporting_files/hg38/hg38.fa


# ref dict - .dict file before running haplotype caller
gatk CreateSequenceDictionary R=~/wgs_va/supporting_files/hg38/hg38.fa O=~/wgs_va/supporting_files/hg38/hg38.dict


# download known sites files for BQSR from GATK resource bundle
wget -P ~/wgs_va/supporting_files/hg38/ https://storage.googleapis.com/genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.dbsnp138.vcf
wget -P ~/wgs_va/supporting_files/hg38/ https://storage.googleapis.com/genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.dbsnp138.vcf.idx

fi

###################################################### VARIANT CALLING STEPS ####################################################################


# directories
ref="$HOME/wgs_va/supporting_files/hg38/hg38.fa"
known_sites="$HOME/wgs_va/supporting_files/hg38/Homo_sapiens_assembly38.dbsnp138.vcf"
aligned_reads="$HOME/wgs_va/aligned_reads"
reads="$HOME/wgs_va/reads"
results="$HOME/wgs_va/results"
data="$HOME/wgs_va/data"



# -------------------
# STEP 1: QC - Run fastqc 
# -------------------

echo "STEP 1: QC - Run fastqc"

#fastqc ${reads}/SRR062634_1.filt.fastq.gz -o ${reads}/
#fastqc ${reads}/SRR062634_2.filt.fastq.gz -o ${reads}/

# No trimming required, quality looks okay.


# --------------------------------------
# STEP 2: Map to reference using BWA-MEM 
# --------------------------------------

echo "STEP 2: Map to reference using BWA-MEM"

# BWA index reference 
bwa index ${ref}
# BWA alignment
bwa mem -t 4 -R "@RG\tID:SRR062634\tPL:ILLUMINA\tSM:SRR062634" ${ref} ${reads}/SRR062634_1.filt.fastq.gz ${reads}/SRR062634_2.filt.fastq.gz > ${aligned_reads}/SRR062634.paired.sam




# -----------------------------------------
# STEP 3: Mark Duplicates and Sort - GATK4
# -----------------------------------------

echo "STEP 3: Mark Duplicates and Sort - GATK4"



# ----------------------------------
# STEP 4: Base quality recalibration
# ----------------------------------


echo "STEP 4: Base quality recalibration"

# 1. build the model


# 2. Apply the model to adjust the base quality scores



# -----------------------------------------------
# STEP 5: Collect Alignment & Insert Size Metrics
# -----------------------------------------------


echo "STEP 5: Collect Alignment & Insert Size Metrics"



# ----------------------------------------------
# STEP 6: Call Variants - gatk haplotype caller
# ----------------------------------------------

echo "STEP 6: Call Variants - gatk haplotype caller"



# extract SNPs & INDELS


