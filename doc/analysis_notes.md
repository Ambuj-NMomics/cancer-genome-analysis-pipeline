# Analysis Notes

## Day 1 – BAM Quality Control
- Verified BAM integrity and alignment statistics using `samtools flagstat`.
- Assessed mapping quality and coverage metrics using `alfred qc`.
- Confirmed suitability of tumor and normal BAM files for downstream analysis.

## Day 2 – Structural Variant Calling
- Performed structural variant discovery using Delly.
- Identified deletions, duplications, and inversions across chromosome 2.
- Generated `sv.bcf` containing candidate SVs.

## Day 3 – Somatic SV Filtering
- Applied matched tumor–normal filtering with Delly.
- Retained high-confidence somatic structural variants.
- Summarized somatic events in `somatic.bcf` and `sv.tsv`.

## Day 4 – Copy Number Analysis
- Computed copy number profiles using Delly CNV.
- Generated read-depth and copy number estimates.
- Visualized genome-wide copy number changes.

## Day 5 – BAF Analysis
- Called SNPs using `bcftools`.
- Calculated B-allele frequencies from normal heterozygous SNPs.
- Evaluated allelic imbalance across chromosome 2.

## Day 6 – Integrative Interpretation
- Integrated SV, CNV, and BAF results.
- Examined concordance between structural rearrangements and copy number changes.
- Identified evidence of chromosomal instability within the tumor genome.
