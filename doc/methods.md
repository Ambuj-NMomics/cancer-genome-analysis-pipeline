# Methods

## Sequencing Data
Paired tumor–normal whole-genome sequencing BAM files (`tumor.bam`, `control.bam`) aligned to the hg19 reference genome. Analysis was restricted to chromosome 2.

## BAM Quality Control
Alignment quality, mapping statistics, and sequencing metrics were assessed using `samtools flagstat` and `alfred qc`.

## Structural Variant Calling
Somatic and germline structural variants were identified using Delly v2. Structural variant classes included deletions (DEL), duplications (DUP), and inversions (INV).

## Somatic Filtering
Tumor-specific structural variants were extracted using Delly's somatic filtering workflow with matched normal controls.

## Copy Number Analysis
Copy number profiles were generated using Delly CNV based on read-depth differences between tumor and normal samples.

## SNP Calling
Single nucleotide variants were called using `bcftools mpileup` and `bcftools call` to obtain allele counts across chromosome 2.

## BAF Analysis
B-allele frequencies were calculated from normal heterozygous SNPs and used to assess allelic imbalance within the tumor genome.

## CNV Segmentation
Copy number segments were identified using Circular Binary Segmentation (CBS) implemented in the `DNAcopy` R package.

## Visualization
Structural variants, copy number alterations, and BAF profiles were visualized using custom R scripts and integrated for genome-wide interpretation.
