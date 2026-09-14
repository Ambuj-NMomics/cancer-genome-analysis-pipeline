# Project Summary

## Objective
Identify somatic structural variants (SVs), copy number alterations (CNVs), and allelic imbalance events from paired tumor–normal whole-genome sequencing data.

## Dataset
- Tumor BAM: `tumor.bam`
- Normal BAM: `control.bam`
- Reference: `chr2.fa`
- Analysis restricted to chromosome 2

## Key Findings
- Delly detected multiple deletions, duplications, and inversions.
- 10 somatic SVs retained by the Delly filtering criteria
- CNV analysis revealed regions of copy number gain and loss.
- BAF analysis identified allelic imbalance across several chromosomal segments.

## Structural Variants
| Type | Count |
|--------|--------|
| DUP | 2 |
| DEL | 1 |
| INV | 7 |
| **Total** | **10** |

## Copy Number Findings
- Broad copy number gains detected in selected chromosome 2 regions.
- Localized copy number losses observed in multiple segments.
- Segmentation confirmed distinct CNV boundaries.

## BAF Findings
- Normal heterozygous SNPs showed deviation from the expected 0.5 allele frequency.
- Several regions demonstrated allelic imbalance consistent with underlying CNVs.

## Interpretation
The tumor genome exhibits concurrent structural rearrangements, copy number alterations, and allele-specific imbalance, indicating substantial chromosomal instability on chromosome 2.
