#Lineage frequencies

require(rworldmap)
require(reshape2)

#location to meta file
metaFile <- "C:/Users/Mary/PepLab/data/Phylogeography/160223_finalizing/160203_passing.meta"

#read tab deliminated file
meta.pre <- read.table(metaFile, header=F, sep='\t', na.strings="NA")

#assign the headers
names(meta.pre) <- c('Sample','Runs', 'Country', 'SubRegion', 'Iso2', 'WHORegion', 'Lineage', 'Latitude', 'Longitude', 'PercentMissingSites')

#force lineage into a factor
meta.pre$Lineage <- as.factor(meta.pre$Lineage)

meta <- meta.pre[-c(which(meta.pre$Sample=="CCJS01"), which(meta.pre$Sample=="ERS217661"), which(meta.pre$Sample=="ERS218324"), which(meta.pre$Sample=="CCBK01"), which(meta.pre$Sample=="CCSJ01")),]


#Exclude samples from Beijing study (biased sampling as is only lineage 2)
beijing <- read.table("C:/Users/Mary/PepLab/data/Phylogeography/LineageFrequencies/Beijing_samples.exclude", header=TRUE)

meta <- meta[!meta$Sample %in% beijing$SRA_Sample_s, ]


#Convert data 

country.m <- aggregate(Sample ~ Lineage + Iso2 + WHORegion, meta, length)

#convert data to one row per location
country <- dcast(country.m, Iso2 + WHORegion ~ Lineage)
names(country) <- c("Iso2", "WHORegion", "Lin1","Lin2","Lin3","Lin4","Lin5","Lin6","Lin7")


#Edit country for downsampled locations
c.mod <- country




#convert NA's to 0's
country[is.na(country)] <- 0
c.mod[is.na(c.mod)] <- 0

#calculate total number of samples from each country
country$total = rowSums(country[,c("Lin1","Lin2","Lin3","Lin4","Lin5","Lin6","Lin7")])
c.mod$total = rowSums(c.mod[,c("Lin1","Lin2","Lin3","Lin4","Lin5","Lin6","Lin7")])

#calculate lineage frequencies for each country
#country$perLin1 <- (country$Lin1 / sum(country$Lin1, na.rm=TRUE))*100


country$perLin1 <- (country$Lin1/country$total)*100
country$perLin2 <- (country$Lin2/country$total)*100
country$perLin3 <- (country$Lin3/country$total)*100
country$perLin4 <- (country$Lin4/country$total)*100
country$perLin5 <- (country$Lin5/country$total)*100
country$perLin6 <- (country$Lin6/country$total)*100
country$perLin7 <- (country$Lin7/country$total)*100


c.mod$perLin1 <- (c.mod$Lin1/c.mod$total)*100
c.mod$perLin2 <- (c.mod$Lin2/c.mod$total)*100
c.mod$perLin3 <- (c.mod$Lin3/c.mod$total)*100
c.mod$perLin4 <- (c.mod$Lin4/c.mod$total)*100
c.mod$perLin5 <- (c.mod$Lin5/c.mod$total)*100
c.mod$perLin6 <- (c.mod$Lin6/c.mod$total)*100
c.mod$perLin7 <- (c.mod$Lin7/c.mod$total)*100

country[country == 0] <- NA
c.mod[c.mod == 0] <- NA

#exclude countries with only one data point
c2 <- c.mod[c.mod$total != 1,]
c2[is.na(c2)] <- 0

#join data to country map
m2 <- joinCountryData2Map(c2,
                          joinCode = "ISO2",
                          nameJoinColumn = "Iso2")

require(RColorBrewer)

op <- par(fin=c(7,9),mfcol=c(2,2),mai=c(0.0,0.0,0.2,0.0),xaxs="i",yaxs="i")

panels = c("perLin1", "perLin2", "perLin3", "perLin4") #, "perLin5", "perLin6", "perLin7")
brewerList <- c("Reds", "RdPu", "Blues", "Purples", "Reds")

for(i in 1:4)
{
  colourPalette <- brewer.pal(7,brewerList[1])
  
  lineage <- panels[i]
  mapParams <- mapCountryData( m2
                               , nameColumnToPlot=lineage
                               , addLegend=FALSE
                               , catMethod=c(0,1,10,20,30,40,50,60,70,80,90,100)
                               , colourPalette=c('white', colourPalette)
                               , mapTitle=lineage
                               , xlim=c(30,140)
                               , ylim=c(-40, 80)
                               #, mapRegion='africa'
                               , missingCountryCol="#EEEEEE"
                               , borderCol="darkgrey"
                               , oceanCol=adjustcolor("#99CCFF")
  )
  do.call( addMapLegend
           , c(mapParams, horizontal=TRUE,legendWidth=0.7))
}


par(op)
