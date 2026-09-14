library(data.table)
library(ggplot2)

cat("Working directory:\n")
print(getwd())

baf <- fread("baf.tsv", header = FALSE)

colnames(baf) <- c(
  "chr",
  "pos",
  "tumor_GT",
  "tumor_AD",
  "normal_GT",
  "normal_AD"
)

#----------------------------
# Keep heterozygous tumor SNPs
#----------------------------

baf <- baf[tumor_GT == "0/1"]

#----------------------------
# Split allele depths
#----------------------------

ad <- tstrsplit(baf$tumor_AD, ",")

baf$ref <- as.numeric(ad[[1]])
baf$alt <- as.numeric(ad[[2]])

#----------------------------
# Calculate BAF
#----------------------------

baf$BAF <- baf$alt / (baf$ref + baf$alt)

# Remove zero-depth sites
baf <- baf[!is.na(BAF)]

#----------------------------
# Plot
#----------------------------

p <- ggplot(
  baf,
  aes(pos, BAF)
) +

geom_point(
  size=0.4,
  alpha=0.4
)+

geom_hline(
  yintercept=0.5,
  colour="red",
  linetype="dashed"
)+

theme_bw() +

labs(
  title="B-Allele Frequency",
  x="Chromosome 2 Position",
  y="BAF"
)

print(p)

ggsave(
"Step13_BAF.png",
width=12,
height=4,
dpi=300
)
