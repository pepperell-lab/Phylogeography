#Update "Dots on a Map" with rworldmap package
require(rworldmap)

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

#India - TBARC
c.mod[c.mod$Iso2 == "IN", 'Lin1'] <- 150
c.mod[c.mod$Iso2 == "IN", 'Lin3'] <- 39
c.mod[c.mod$Iso2 == "IN", 'Lin2'] <- 6
c.mod[c.mod$Iso2 == "IN", 'Lin4'] <- 6
c.mod[c.mod$Iso2 == "IN", 'Lin5'] <- NA
c.mod[c.mod$Iso2 == "IN", 'Lin6'] <- NA
c.mod[c.mod$Iso2 == "IN", 'Lin7'] <- NA

#Mali - TBARC #####Still biased for 'M. africanum'
c.mod[c.mod$Iso2 == "ML", 'Lin1'] <- 1
c.mod[c.mod$Iso2 == "ML", 'Lin2'] <- 2
c.mod[c.mod$Iso2 == "ML", 'Lin3'] <- NA
c.mod[c.mod$Iso2 == "ML", 'Lin4'] <- 63
c.mod[c.mod$Iso2 == "ML", 'Lin5'] <- 2
c.mod[c.mod$Iso2 == "ML", 'Lin6'] <- 23
c.mod[c.mod$Iso2 == "ML", 'Lin7'] <- NA

#Moldova
c.mod[c.mod$Iso2 == "MD", 'Lin1'] <- NA
c.mod[c.mod$Iso2 == "MD", 'Lin2'] <- 34
c.mod[c.mod$Iso2 == "MD", 'Lin3'] <- NA
c.mod[c.mod$Iso2 == "MD", 'Lin4'] <- 60
c.mod[c.mod$Iso2 == "MD", 'Lin5'] <- NA
c.mod[c.mod$Iso2 == "MD", 'Lin6'] <- NA
c.mod[c.mod$Iso2 == "MD", 'Lin7'] <- NA

#Romania - TBARC
c.mod[c.mod$Iso2 == "RO", 'Lin1'] <- NA
c.mod[c.mod$Iso2 == "RO", 'Lin2'] <- NA
c.mod[c.mod$Iso2 == "RO", 'Lin3'] <- NA
c.mod[c.mod$Iso2 == "RO", 'Lin4'] <- 34
c.mod[c.mod$Iso2 == "RO", 'Lin5'] <- NA
c.mod[c.mod$Iso2 == "RO", 'Lin6'] <- NA
c.mod[c.mod$Iso2 == "RO", 'Lin7'] <- NA

#Russia - Samara study
c.mod[c.mod$Iso2 == "RU", 'Lin1'] <- NA
c.mod[c.mod$Iso2 == "RU", 'Lin2'] <- 642
c.mod[c.mod$Iso2 == "RU", 'Lin3'] <- 3
c.mod[c.mod$Iso2 == "RU", 'Lin4'] <- 355
c.mod[c.mod$Iso2 == "RU", 'Lin5'] <- NA
c.mod[c.mod$Iso2 == "RU", 'Lin6'] <- NA
c.mod[c.mod$Iso2 == "RU", 'Lin7'] <- NA

#Pakistan - ERP008770
c.mod[c.mod$Iso2 == "PK", 'Lin1'] <- 5
c.mod[c.mod$Iso2 == "PK", 'Lin2'] <- NA
c.mod[c.mod$Iso2 == "PK", 'Lin3'] <- 33
c.mod[c.mod$Iso2 == "PK", 'Lin4'] <- 4
c.mod[c.mod$Iso2 == "PK", 'Lin5'] <- NA
c.mod[c.mod$Iso2 == "PK", 'Lin6'] <- NA
c.mod[c.mod$Iso2 == "PK", 'Lin7'] <- NA

#Uganda - ERP000520
c.mod[c.mod$Iso2 == "UG", 'Lin1'] <- 1
c.mod[c.mod$Iso2 == "UG", 'Lin2'] <- 1
c.mod[c.mod$Iso2 == "UG", 'Lin3'] <- 14
c.mod[c.mod$Iso2 == "UG", 'Lin4'] <- 35
c.mod[c.mod$Iso2 == "UG", 'Lin5'] <- NA
c.mod[c.mod$Iso2 == "UG", 'Lin6'] <- NA
c.mod[c.mod$Iso2 == "UG", 'Lin7'] <- NA

#Portugal - ERP002611
c.mod[c.mod$Iso2 == "PT", 'Lin1'] <- NA
c.mod[c.mod$Iso2 == "PT", 'Lin2'] <- 4
c.mod[c.mod$Iso2 == "PT", 'Lin3'] <- 1
c.mod[c.mod$Iso2 == "PT", 'Lin4'] <- 39
c.mod[c.mod$Iso2 == "PT", 'Lin5'] <- NA
c.mod[c.mod$Iso2 == "PT", 'Lin6'] <- NA
c.mod[c.mod$Iso2 == "PT", 'Lin7'] <- NA

#Malawi 
c.mod[c.mod$Iso2 == "MW", 'Lin1'] <- 269
c.mod[c.mod$Iso2 == "MW", 'Lin2'] <- 74
c.mod[c.mod$Iso2 == "MW", 'Lin3'] <- 205
c.mod[c.mod$Iso2 == "MW", 'Lin4'] <- 1139
c.mod[c.mod$Iso2 == "MW", 'Lin5'] <- NA
c.mod[c.mod$Iso2 == "MW", 'Lin6'] <- NA
c.mod[c.mod$Iso2 == "MW", 'Lin7'] <- NA

#Ethiopia - from typing study
c.mod[c.mod$Iso2 == "ET", 'Lin1'] <- 11
c.mod[c.mod$Iso2 == "ET", 'Lin2'] <- NA
c.mod[c.mod$Iso2 == "ET", 'Lin3'] <- 236
c.mod[c.mod$Iso2 == "ET", 'Lin4'] <- 671
c.mod[c.mod$Iso2 == "ET", 'Lin5'] <- NA
c.mod[c.mod$Iso2 == "ET", 'Lin6'] <- NA
c.mod[c.mod$Iso2 == "ET", 'Lin7'] <- 36

#c.mod[c.mod$Iso2 == "RU", 'Lin1'] <- NA
#c.mod[c.mod$Iso2 == "RU", 'Lin2'] <- NA
#c.mod[c.mod$Iso2 == "RU", 'Lin3'] <- NA
#c.mod[c.mod$Iso2 == "RU", 'Lin4'] <- NA
#c.mod[c.mod$Iso2 == "RU", 'Lin5'] <- NA
#c.mod[c.mod$Iso2 == "RU", 'Lin6'] <- NA
#c.mod[c.mod$Iso2 == "RU", 'Lin7'] <- NA
#####

mPDF <- joinCountryData2Map(dat,
                            joinCode = "ISO2",
                            nameJoinColumn = "Iso2")


WHO = c("#FFFF5A","#00FFB7", "#5BA0FF", "#2DE200", "#FF9700")


par(mai=c(.75,.75,.75,.75), xaxs="i", yaxs="i")
mapCountryData(m2, nameColumnToPlot="WHORegion", 
               colourPalette=WHO, xlim=c(10,180), ylim=c(-50, 90),
               addLegend=FALSE, , missingCountryCol="#EEEEEE", borderCol="darkgrey")


dat$size <- log2(dat$Total + 1)

#par(mai=c(0,0,0.2,0),xaxs="i",yaxs="i")
mapBubbles( dF=mPDF
            , nameZSize="Total"
            , nameX="Longitude"
            , nameY="Latitude" 
            , nameZColour="black")
            #, colourPalette='rainbow'
#)



#join data to country map
m2 <- joinCountryData2Map(country,
                            joinCode = "ISO2",
                            nameJoinColumn = "Iso2")
#color by WHO Region
par(mai=c(0,0,0.2,0), xaxs="i", yaxs="i")
mapCountryData(m2, nameColumnToPlot="perLin1", colourPalette=WHO)

#Add circlesbased on lat & long
mapBubbles( dF=dat
            , nameZSize="Lin1"
            , nameX="Longitude"
            , nameY="Latitude" 
            , nameZColour="black", add=TRUE)

#Add circles based on country total
mapBubbles(dF=m2, nameZSize="Lin1", nameZColour="red", add=TRUE)


#Color by no. samples
par(mai=c(0,0,0.2,0), xaxs="i", yaxs="i")
mapCountryData(m2, nameColumnToPlot="Lin1")

#Color by % samples for lineage



par(mai=c(0,0,0.2,0), xaxs="i", yaxs="i")
mapCountryData(m2, nameColumnToPlot="perLin1", oceanCol="lightblue", missingCountryCol="white")

library(RColorBrewer)
colourPalette <- RColorBrewer::brewer.pal(5,'RdPu')

library(classInt)
classInt <- classInt::classIntervals(m2[["perLin1"]], n=10, style="jenks")
catMethod = classInt[["brks"]]


par(mai=c(0,0,0.2,0), xaxs="i", yaxs="i")
mapCountryData(m2, nameColumnToPlot="perLin1", colourPalette=colourPalette, oceanCol="lightblue", missingCountryCol="white")

par(mai=c(0,0,0.2,0), xaxs="i", yaxs="i")
mapCountryData(m2, nameColumnToPlot="perLin1"
               , addLegend=TRUE
               , catMethod = catMethod
               , colourPalette = colourPalette
               #, oceanCol="lightblue"
               , missingCountryCol="#EEEEEE")

#####
### Lineage Specific

country.m <- aggregate(Sample ~ Lineage + Iso2 + WHORegion, meta, length)

#convert data to one row per location
country <- dcast(country.m, Iso2 + WHORegion ~ Lineage)
names(country) <- c("Iso2", "WHORegion", "Lin1","Lin2","Lin3","Lin4","Lin5","Lin6","Lin7")

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
brewerList <- c("RdPu", "Blues", "Purples", "Reds")

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
                               , xlim=c(-30,180)
                               , ylim=c(-50, 90)
                               #, mapRegion='africa'
                               , missingCountryCol="#EEEEEE"
                               , borderCol="darkgrey"
                               , oceanCol=adjustcolor("#99CCFF", alpha.f = 0.5)
                               )
  do.call( addMapLegend
           , c(mapParams, horizontal=TRUE,legendWidth=0.7))
}


par(op)

