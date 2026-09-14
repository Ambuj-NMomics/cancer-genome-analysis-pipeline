library(data.table)
library(ggplot2)

#-------------------------
# Read CNV
#-------------------------

cnv <- fread(cmd="zcat ../cnv.cov.gz")

cnv$midpoint <- (cnv$start + cnv$end)/2

#-------------------------
# Read Structural Variants
#-------------------------

sv <- fread("../sv.tsv")

colnames(sv) <- c(
    "chr",
    "start",
    "end",
    "type"
)

#-------------------------
# Plot
#-------------------------

p <- ggplot(cnv,
            aes(midpoint,
                tumor_CN)) +

    geom_point(size=.4,
               alpha=.6) +

    geom_hline(
        yintercept=2,
        linetype="dashed",
        color="red"
    ) +

    geom_vline(
        data=sv,
        aes(xintercept=start,
            color=type),
        linewidth=.5
    ) +

    theme_bw() +

    labs(
        title="CNV + Structural Variants",
        x="Chromosome 2 Position",
        y="Estimated Copy Number"
    )

print(p)

ggsave(
"Step11_CNV_SV.png",
p,
width=12,
height=5,
dpi=300
)
