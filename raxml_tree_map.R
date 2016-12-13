require(ggplot2)
require(ape)
#source("https://bioconductor.org/biocLite.R")
#biocLite("ggtree")
require("ggtree")
require(phytools)
require(phangorn)
require(cowplot)
require(rworldmap)
require(reshape2)
require(RColorBrewer)
require(data.table)
require(splitstackshape)
library(viridis)
library(colorRamps)
library(scales)
require(akima)
require(dplyr)

setwd("C://Users/Mary/PepLab/data/Phylogeography/Phylo_Figures_Data/")


########RAxML Tree

full <- read.tree("RAxML_full_rapidbootstrap.tree")

un <- read.table("iso2_to_UNreg.txt")

fullUN <- split(full$tip.label, un[match(lapply(strsplit(as.character(full$tip.label), "_"), "[", 2), un$V1), 'V2'])

fullmpt <- midpoint(full)
fullmpt <- groupOTU(fullmpt, fullUN)

fullTree <- ggtree(fullmpt, layout="circular") + 
  geom_tippoint(aes(color=group)) + 
  geom_treescale(offset=-10) +
  scale_color_manual(name = "UN Geographic Region", values=c('#F8766D','#E88526','#D39200','#B79F00','#93AA00','#5EB300','#00BA38','#00BF74','#00C19F','#00BFC4','#00B9E3','#00ADFA','#619CFF','#AE87FF'), labels = c('Central Asia','Eastern Africa','Eastern Asia', 'Eastern Europe', 'Melanesia', 'Micronesia', 'Northern Africa', 'South Eastern Asia', 'Southern-Africa', 'Southern Asia', 'Southern Europe', 'Western Africa', 'Western Asia', 'Western Europe')) +
  theme(legend.position="right")


ggsave("161201_raxml_full_circular2.pdf", plot=fullTree, width=14, height=14, units = "in", dpi=300)

#######UN Region Map

un2 <- read.table("C:/Users/Mary/PepLab/data/Phylogeography/United_Nations/abr_country_codes_regions.txt", na.strings="NA", sep="\t", header=T)

#join data to country map
md <- joinCountryData2Map(un2,
                          joinCode = "ISO3",
                          nameJoinColumn = "ISO3")

par(mai=c(0.2,0.2,0.4,0.2),xaxs="i",yaxs="i")


cols = c('#F8766D','#E88526','#D39200','#B79F00','#93AA00','#5EB300','#00BA38','#00BF74','#00C19F','#00BFC4','#00B9E3','#00ADFA','#619CFF','#AE87FF')


mapParams <- mapCountryData( md
                             , nameColumnToPlot="UN_REG"
                             , addLegend=TRUE
                             , colourPalette=cols
                             , mapTitle="UN Geographic Regions"
                             #, xlim=c(20,140)
                             #, ylim=c(-50, 80)
                             #, mapRegion='africa'
                             , missingCountryCol="white"
                             , borderCol="darkgrey"
                             #, oceanCol=adjustcolor("#99CCFF")
)


mapParams <- mapCountryData( md
                             , nameColumnToPlot="UN_REG"
                             , addLegend=FALSE
                             , colourPalette=cols
                             , mapTitle="UN Geographic Regions"
                             , xlim=c(20,140)
                             , ylim=c(-50, 80)
                             #, mapRegion='africa'
                             , missingCountryCol="white"
                             , borderCol="darkgrey"
                             #, oceanCol=adjustcolor("#99CCFF")
)