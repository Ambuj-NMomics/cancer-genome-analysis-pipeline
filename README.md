# Integrative Cancer Genome Analysis Using Short-Read Sequencing

![License](https://img.shields.io/badge/license-MIT-blue)
![Platform](https://img.shields.io/badge/platform-Linux-green)
![Language](https://img.shields.io/badge/R-Bash-orange)
![Tool](https://img.shields.io/badge/Delly-SV%2FCNV-red)

## Project Overview

This project demonstrates an end-to-end analysis of somatic structural variants (SVs), copy number variants (CNVs), and allelic imbalance from paired tumor-normal whole-genome sequencing data.

The analysis was performed using short-read sequencing data and focuses on chromosome 2 of a melanoma tumor-normal pair.

The workflow integrates:

- Structural Variant Calling (SV)
- Somatic SV Filtering
- Breakpoint Visualization
- Copy Number Analysis
- B-Allele Frequency (BAF) Analysis
- CNV Segmentation
- Integrated Cancer Genome Interpretation

The goal is to identify genomic alterations associated with cancer development and progression by combining multiple orthogonal genomic signals.

---

# Biological Background

Cancer genomes accumulate multiple classes of genomic alterations:

### Structural Variants (SVs)

Large genomic rearrangements including:

- Deletions (DEL)
- Duplications (DUP)
- Inversions (INV)
- Translocations (TRA)

These events can:

- Disrupt tumor suppressor genes
- Amplify oncogenes
- Generate fusion genes

---

### Copy Number Variants (CNVs)

Changes in DNA dosage:

- Copy number gain
- Copy number loss
- Amplification
- Deletion

CNVs frequently drive tumor evolution by altering gene expression.

---

### B-Allele Frequency (BAF)

Measures the proportion of reads supporting the alternative allele.

BAF helps detect:

- Loss of heterozygosity (LOH)
- Allelic imbalance
- Copy-neutral LOH
- Tumor purity effects

---

# Objectives

The objectives of this project were:

1. Assess alignment quality of tumor and normal BAM files.
2. Detect structural variants using Delly.
3. Identify tumor-specific somatic SVs.
4. Visualize SV breakpoints using Wally.
5. Detect copy number alterations.
6. Calculate B-allele frequencies.
7. Integrate SV, CNV, and BAF evidence.
8. Characterize genomic instability in the tumor genome.

---

# Dataset

## Samples

| Sample | Type |
|----------|----------|
| tumor | Melanoma Tumor |
| control | Matched Normal |

---

## Reference

| File | Description |
|--------|--------|
| chr2.fa | Chromosome 2 reference sequence |
| chr2.map.fa | Mappability reference |
| hg19.ex | Exclusion regions |

---

# Workflow Overview

```text
Tumor BAM + Normal BAM
          │
          ▼
   Quality Control
          │
          ▼
 Structural Variant Calling
          │
          ▼
 Somatic SV Filtering
          │
          ▼
 Breakpoint Visualization
          │
          ▼
 CNV Calling
          │
          ▼
 BAF Calculation
          │
          ▼
 CNV Segmentation
          │
          ▼
 Integrated Interpretation
```

---

# Software and Dependencies

## Core Tools

| Tool | Purpose |
|--------|--------|
| Samtools | BAM processing |
| BCFtools | Variant manipulation |
| Delly | SV/CNV calling |
| Wally | Breakpoint visualization |
| Bedtools | Genomic interval operations |

---

## R Packages

```r
data.table
ggplot2
DNAcopy
```

Install:

```r
install.packages(c(
  "data.table",
  "ggplot2"
))

if (!requireNamespace("BiocManager"))
  install.packages("BiocManager")

BiocManager::install("DNAcopy")
```

---

# Project Structure

```text
integrative-cancer-genome-analysis
│
├── data
│   ├── raw
│   └── reference
│
├── metadata
│
├── results
│   ├── qc
│   ├── sv
│   ├── cnv
│   ├── baf
│   ├── tables
│   └── figures
│
├── src
│   ├── bash
│   └── r
│
├── doc
│
├── README.md
├── LICENSE
├── CITATION.cff
└── environment.yml
```

---

# Analysis Workflow

## Step 1: Quality Assessment

### Purpose

Evaluate BAM quality before variant calling.

### Tool

Samtools + Alfred

### Input

```text
tumor.bam
control.bam
```

### Commands

```bash
samtools flagstat tumor.bam \
> results/qc/tumor.flagstat.txt

samtools flagstat control.bam \
> results/qc/control.flagstat.txt
```

### Output

```text
tumor.flagstat.txt
control.flagstat.txt
```

### Interpretation

Checks:

- Mapping rate
- Proper pairing
- Duplicate reads
- Alignment quality

---

## Step 2: Structural Variant Calling

### Tool

Delly

### Purpose

Detect:

- DEL
- DUP
- INV
- INS
- BND

### Command

```bash
delly call \
-g data/reference/chr2.fa \
-o results/sv/sv.bcf \
data/raw/tumor.bam \
data/raw/control.bam
```

### Output

```text
sv.bcf
```

### Interpretation

Candidate structural variants supported by:

- Discordant read pairs
- Split reads

---

## Step 3: Somatic SV Filtering

### Purpose

Remove germline variants.

### Command

```bash
delly filter \
-f somatic \
-o results/sv/somatic.bcf \
-s metadata/spl.tsv \
results/sv/sv.bcf
```

### Output

```text
somatic.bcf
```

### Result

10 somatic structural variants identified.

---

## Step 4: Breakpoint Visualization

### Tool

Wally

### Purpose

Validate SV evidence visually.

### Command

```bash
wally region \
-R results/sv/somatic.bp.bed \
-s 2 \
-cp \
-g data/reference/chr2.fa \
data/raw/tumor.bam \
data/raw/control.bam
```

### Output

Breakpoint images:

```text
DEL00000064R.png
INV00000364R.png
DUP00001492R.png
...
```

### Interpretation

Confirms:

- Split reads
- Read pair orientation
- Breakpoint support

---

## Step 5: Copy Number Analysis

### Tool

Delly CNV

### Purpose

Estimate copy number changes.

### Command

```bash
delly cnv \
-g data/reference/chr2.fa \
-m data/reference/chr2.map.fa \
-e data/reference/hg19.ex \
-o results/cnv/cnv.bcf \
data/raw/tumor.bam
```

### Output

```text
cnv.bcf
cnv.cov.gz
```

---

## Step 6: Copy Number Visualization

### Tool

R

### Input

```text
cnv.cov.gz
```

### Output

```text
copy_number_profile.png
```

### Interpretation

- CN ≈ 2 → Diploid
- CN > 2 → Gain
- CN < 2 → Loss

---

## Step 7: SV + CNV Integration

### Purpose

Determine whether structural variants occur within copy number altered regions.

### Output

```text
sv_cnv_overlay.png
```

### Interpretation

Events supported by both SV and CNV evidence have higher confidence.

---

## Step 8: BAF Analysis

### Purpose

Detect allelic imbalance.

### SNP Calling

```bash
bcftools mpileup \
-f data/reference/chr2.fa \
tumor.bam control.bam | \
bcftools call -m -v -Oz \
-o snps.vcf.gz
```

### BAF Calculation

```bash
bash src/bash/calculate_baf.sh
```

### Output

```text
baf.tsv
```

---

## Step 9: BAF Visualization

### Output

```text
baf_normal_heterozygous.png
```

### Interpretation

Expected:

```text
0.5
```

Deviation suggests:

- LOH
- Copy-neutral LOH
- Allelic imbalance

---

## Step 10: CNV Segmentation

### Tool

DNAcopy

### Purpose

Identify contiguous CNV regions.

### Output

```text
cnv_segments.csv
cnv_segmented_profile.png
```

### Interpretation

Segments represent inferred chromosomal gains and losses.

---

# Major Findings

## Somatic Structural Variants

Detected:

- Deletions
- Duplications
- Inversions

Examples:

| SV ID | Type |
|---------|---------|
| DEL00000064 | Deletion |
| DUP00001492 | Duplication |
| INV00000364 | Inversion |

---

## Copy Number Alterations

Observed:

- Broad copy number gains
- Copy number losses
- Segmented CNV regions

---

## Allelic Imbalance

BAF deviations suggest:

- Loss of heterozygosity
- Chromosomal imbalance
- Potential tumor evolution events

---

# Results

## Figures

### Copy Number Profile

```text
results/figures/copy_number_profile.png
```

### CNV Segmentation

```text
results/figures/cnv_segmented_profile.png
```

### BAF Profile

```text
results/figures/baf_normal_heterozygous.png
```

### SV-CNV Integration

```text
results/figures/sv_cnv_overlay.png
```

### Breakpoint Validation

```text
results/figures/breakpoints/
```

---

# Reproducibility

Create environment:

```bash
conda env create -f environment.yml
conda activate cancer_genomics
```

Run analysis:

```bash
bash src/bash/run_delly_sv.sh

bash src/bash/filter_somatic_sv.sh

bash src/bash/run_delly_cnv.sh

bash src/bash/calculate_baf.sh
```

Generate figures:

```bash
Rscript src/r/step10_plot_cnv.R

Rscript src/r/step13_BAF_normal.R

Rscript src/r/step14_CNV_segmentation.R
```

---

# Future Improvements

- Whole genome analysis
- Tumor purity estimation
- ASCAT-based allele-specific CNV analysis
- GRIDSS structural variant calling
- Long-read validation
- Multi-sample comparison
- Automated Nextflow workflow

---

# Citation

If you use this repository, please cite:

```text
Maurya AN.

Integrative Cancer Genome Analysis Using Short-Read Sequencing.

GitHub Repository.
```

---

# Author

**Ambuj Narayan Maurya**

Bioinformatics | Cancer Genomics | NGS Analysis

GitHub: https://github.com/<your_username>
