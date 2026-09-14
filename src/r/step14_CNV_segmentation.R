library(data.table)
library(ggplot2)
library(DNAcopy)
library(scales)

#-----------------------------
# Read CNV data
#-----------------------------

cnv <- fread(cmd = "zcat cnv.cov.gz")

# Midpoint (Mb)
cnv$mid <- (cnv$start + cnv$end) / 2
cnv$midMb <- cnv$mid / 1e6

#-----------------------------
# CBS Segmentation
#-----------------------------

cna.object <- CNA(
    genomdat = cnv$tumor_logR,
    chrom = cnv$chr,
    maploc = cnv$mid,
    data.type = "logratio"
)

cna.object <- smooth.CNA(cna.object)

segment.object <- segment(
    cna.object,
    verbose = 0
)

segments <- segment.object$output

#-----------------------------
# Plot
#-----------------------------

p <- ggplot(cnv,
            aes(midMb, tumor_logR)) +

    geom_point(
        alpha = 0.25,
        size = 0.35,
        colour = "grey40"
    ) +

    geom_segment(
        data = segments,
        aes(
            x = loc.start/1e6,
            xend = loc.end/1e6,
            y = seg.mean,
            yend = seg.mean
        ),
        colour = "red",
        linewidth = 1
    ) +

    geom_hline(
        yintercept = 0,
        linetype = "dashed"
    ) +

    scale_x_continuous(
        labels = label_number(suffix = " Mb")
    ) +

    theme_bw(base_size = 14) +

    labs(
        title = "Segmented Copy Number Profile (CBS)",
        x = "Chromosome 2 Position",
        y = "Log2 Ratio"
    )

print(p)

ggsave(
    "Step14_CNV_Segmented.png",
    p,
    width = 14,
    height = 5,
    dpi = 300
)

write.csv(
    segments,
    "CNV_segments.csv",
    row.names = FALSE
)

