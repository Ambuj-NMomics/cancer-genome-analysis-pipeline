## Copy Number Visualization

library(data.table)
library(ggplot2)

# Read Delly CNV output

cnv <- fread(cmd = "zcat ../cnv.cov.gz")

# Create genomic midpoint

cnv$midpoint <- (cnv$start + cnv$end)/2

# Basic inspection

print(head(cnv))

summary(cnv$tumor_CN)


# Plot Copy Number

p <- ggplot(cnv,
            aes(x = midpoint,
                y = tumor_CN)) +

    geom_point(size = 0.4,
               alpha = 0.6) +

    geom_hline(yintercept = 2,
               color = "red",
               linetype = "dashed") +

    labs(title = "Copy Number Profile (Chromosome 2)",
         x = "Genomic Position",
         y = "Estimated Copy Number") +

    theme_bw()

print(p)

ggsave("Step10_CopyNumber_Profile.png",
       p,
       width = 12,
       height = 5,
       dpi = 300)
