library(data.table)

cnv <- fread(
    cmd = "zcat ../cnv.cov.gz"
)

head(cnv)

str(cnv)

summary(cnv)
