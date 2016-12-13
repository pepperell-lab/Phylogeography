#Heatmap of Migration Rate Matrix Data

filename = "C://Users/Mary/PepLab/data/Phylogeography/Phylo_Figures_Data/MTB.RateMatrix.txt"
dat <- as.matrix(read.table(filename,header=T, sep="\t", row.names=1, na.strings="-"))
df <- read.table(filename,header=T, sep="\t", row.names=1, na.strings="-")


iso2un <- read.table("C://Users/Mary/PepLab/data/Phylogeography/Phylo_Figures_Data/iso2_to_UNreg.txt")

ord <- iso2un[match(rownames(dat), iso2un$V1), 'V2']


library("ggplot2")
library("reshape2")
library("RColorBrewer")
library("Matrix")

A <- forceSymmetric(dat)
B <- as.matrix(A)

dat.m <- melt(B)
dat.m$UN1 <- iso2un[match(dat.m$Var1, iso2un$V1), 'V2']
dat.m$UN2 <- iso2un[match(dat.m$Var2, iso2un$V1), 'V2']

C <- tbl_df(dat.m)

C <- arrange(C, UN1, Var1, UN2, Var2)


dat$Category <- factor(dat$Category, levels=(dat$Category)[order(dat$Order)])


C$Var1 <- factor(C$Var1, levels=(C$Var1)[order(C$UN1)])
C$Var2 <- factor(C$Var2, levels=(C$Var2)[order(C$UN2)])



mig <- ggplot(C, aes(x=Var1, y=Var2, fill=value)) + 
  geom_tile() +
  xlab(NULL) + ylab(NULL) +
  theme_bw(base_size=12) +
  theme(panel.background = element_blank(),
        panel.border = element_blank()) 
  



exportPlot <- function(gplot, filename, width=2, height=1.5) {
  ggsave(paste(filename,'.pdf',sep=""), gplot, width=width, height=height)
  postscript(file=paste(filename,'.eps',sep=""), width=width, height=height)
  print(gplot)
  dev.off()
  png(file=paste(filename,'.png', sep=""), width=width*100, height=height*100)
  print(gplot)
  dev.off()
}

exportPlot(mig, "migrationMatrixHeatmap", 12, 10)
