library(DESeq2)
library(ggpot2)
library(gplots)
library(RColorBrewer)
comptage = read.delim("counts.txt",sep="\t", header=T,row.names=1)
countData = comptage[,-c(1:5)]
design = read.delim("annot_sample.csv",sep="\t", header=T,row.names=1)
colnames(countData) = rownames(design)

dds <- DESeqDataSetFromMatrix(countData = countData,
    colData = design,
    design = ~ condition)

dds <- dds[ rowSums(counts(dds)) > 1, ]

dds$condition <- relevel(dds$condition, ref="NBS")

dds <- DESeq(dds)

# expliquer a quoi sert le size factor
barplot(colSums(counts(dds)))
sizeFactors(dds) # divide each column by his size factor --> normalized counts 
#Construct a "reference sample" by taking, for each gene, the geometric mean of the counts in all samples.
#- To get the sequencing depth of a sample relative to the reference, calculate for each gene the quotient of the counts in your sample divided by the counts of the reference sample. Now you have, for each gene, an estimate of the depth ratio.
#- Simply take the median of all the quotients to get the relative depth of the library.


par(mfrow=c(1,2))
boxplot(log2(counts(dds) +1 ), las=2, col=as.numeric(design$condition)+1)
boxplot(log2(counts(dds, normalized=TRUE) +1 ),las=2, col=as.numeric(design$condition)+1)

#PCA
rld = rlog(dds, blind=FALSE)
plotPCA(rld, intgroup=c("condition"),ntop=nrow(rld))

acp = prcomp(t(assay(rld)),center=TRUE)
plot(acp$x[,1], acp$x[,2], col=as.numeric(design$condition), pch=16)
text(acp$x[,1]+3, acp$x[,2]+3, col=as.numeric(design$condition),labels = colnames(rld))

# Heatmap
sampledist = dist(t(assay(rld)))
sampledistMatrix =as.matrix(sampledist)
colors <- colorRampPalette( rev(brewer.pal(9, "Blues")) )(255)
pheatmap(sampledistMatrix,col=colors)

# Analyse Diff
resHER2 <- results(dds, contrast=c("condition","HER2","NBS"),alpha = 0.001)
resHER2Ordered <- resHER2[order(resHER2$padj),]
summary(resHER2)
plotCounts(dds, gene="ERBB2", intgroup="condition")


# volcano
up = which(resHER2$pvalue <= 0.001 & resHER2$log2FoldChange >= 1)
down = which(resHER2$pvalue <= 0.001 & resHER2$log2FoldChange <= -1)

plot(resHER2$log2FoldChange, -log10(resHER2$pvalue), type="n", xlab="log2Fold-Change", ylab="-log10(pvalue)", main="HER2 vs NBS")
points(resHER2$log2FoldChange[up], -log10(resHER2$pvalue[up]),col="red",pch=16)
points(resHER2$log2FoldChange[down], -log10(resHER2$pvalue[down]),col="green",pch=16)
points(resHER2$log2FoldChange[-c(up,down)], -log10(resHER2$pvalue[-c(up,down)]), pch=16)

abline(v=c(-1,1), lty=2)
abline(h=-log10(0.001), lty=2)

