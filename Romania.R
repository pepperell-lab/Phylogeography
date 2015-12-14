require("ape")
require("geiger")
require("phytools")
require("igraph")

setwd("C:/Users/Mary/PepLab/data/Phylogeography/TB-ARC/")
fa = "Romania_coreSNPs.fa"

aln = read.dna(fa, format="fasta")

dm = dist.dna(aln)
njTree <- nj(dm)
midpoint.root(njTree)
plot.phylo(njTree, show.tip.label=FALSE)


complete <- hclust(as.dist(dm), method="complete")
single <- hclust(as.dist(dm), method="single")
ss <- as.phylo(single)
sc <- di2multi(ss, tol = 0.015300)


cutComplete = as.data.frame(cutree(complete, k=10))
plot.phylo(as.phylo(single), tip.color=cutSingle$`cutree(single, k = 10)`)

plot.phylo(as.phylo(complete), tip.color=cutComplete$`cutree(complete, k = 10)`)


cutSingle <- as.data.frame(cutree(single, k=10))



#russia$cluster2 <- cut2[match(russia$id, rownames(cut2)), 'cutree(clust, k = 5)']