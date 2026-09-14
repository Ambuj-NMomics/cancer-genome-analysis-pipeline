# Workflow Overview

## Input Files
- `tumor.bam`
- `control.bam`
- `chr2.fa`
- `hg19.ex`
- `spl.tsv`

## Workflow
1. BAM quality assessment (`samtools`, `alfred`)
2. Structural variant calling (`Delly`)
3. Somatic SV filtering
4. Breakpoint visualization (`Wally`)
5. Copy number analysis (`Delly CNV`)
6. SNP calling (`bcftools`)
7. BAF calculation from normal heterozygous SNPs
8. CNV segmentation (`DNAcopy`)
9. SV–CNV–BAF integration

## Output Files
### Structural Variants
- `sv.bcf`
- `somatic.bcf`
- `sv.tsv`

### Copy Number
- `cnv.bcf`
- `cnv.cov.gz`
- `cnv_segments.csv`

### BAF
- `baf.tsv`
- `baf_normal.tsv`

### Figures
- Copy number profile
- CNV segmentation plot
- BAF plot
- SV–CNV overlay plot
- Breakpoint visualizations
