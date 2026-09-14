library(data.table)
library(ggplot2)
library(scales)

#-------------------------
# Read SNP table
#-------------------------

baf <- fread("baf_normal.tsv", header = FALSE)

colnames(baf) <- c(
  "chr",
  "pos",
  "tumor_GT",
  "tumor_AD",
  "normal_GT",
  "normal_AD"
)

#-------------------------
# Keep germline heterozygous SNPs
#-------------------------

baf <- baf[normal_GT == "0/1"]

#-------------------------
# Split tumor allele depths
#-------------------------

ad <- tstrsplit(baf$tumor_AD, ",")

baf$ref <- as.numeric(ad[[1]])
baf$alt <- as.numeric(ad[[2]])

#-------------------------
# Remove low coverage
#-------------------------

baf$depth <- baf$ref + baf$alt

baf <- baf[depth >= 10]

#-------------------------
# Calculate BAF
#-------------------------

baf$BAF <- baf$alt / baf$depth

baf <- baf[!is.na(BAF)]

#-------------------------
# Plot
#-------------------------

p <- ggplot(baf, aes(pos / 1e6, BAF)) +
  geom_point(size = 0.25, alpha = 0.35) +
  geom_hline(yintercept = 0.5,
             colour = "red",
             linetype = "dashed") +
  scale_x_continuous(
    labels = label_number(suffix = " Mb")
  ) +
  coord_cartesian(ylim = c(0, 1)) +
  theme_bw(base_size = 14) +
  labs(
    title = "Tumor B-Allele Frequency (Normal Heterozygous SNPs)",
    x = "Chromosome 2 Position",
    y = "B-Allele Frequency"
  )

print(p)

ggsave(
  "Step13_BAF_NormalHet.png",
  p,
  width = 14,
  height = 5,
  dpi = 300
)
