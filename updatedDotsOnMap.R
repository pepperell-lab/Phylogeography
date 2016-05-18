#Update "Dots on a Map" with rworldmap package

#convert data from one row per sample to one row per location per lineage
dat.m <- aggregate(Sample ~ Lineage + Latitude + Longitude + Iso2 + WHORegion, meta, length)

#convert data to one row per location
dat <- dcast(dat.m, Latitude + Longitude + Iso2 + WHORegion ~ Lineage)
names(dat) <- c("Latitude","Longitude", "Iso2", "WHORegion", "Lin1","Lin2","Lin3","Lin4","Lin5","Lin6","Lin7")
dat[is.na(dat)] <- 0

#sum the number of isolates per location
dat$Total = rowSums(dat[,c("Lin1","Lin2","Lin3","Lin4","Lin5","Lin6","Lin7")])

mPDF <- joinCountryData2Map(dat,
                            joinCode = "ISO2",
                            nameJoinColumn = "Iso2")


WHO = c("#FFFF5A","#00FFB7", "#5BA0FF", "#2DE200", "#FF9700")


par(mai=c(0,0,0.2,0), xaxs="i", yaxs="i")
m1 <- mapCountryData(mPDF, nameColumnToPlot="WHORegion", colourPalette=WHO)


dat$size <- log2(dat$Total + 1)

#par(mai=c(0,0,0.2,0),xaxs="i",yaxs="i")
mapBubbles( dF=mPDF
            , nameZSize="Total"
            , nameX="Longitude"
            , nameY="Latitude" 
            , nameZColour="black")
            #, colourPalette='rainbow'
#)


### Lineage Specific

country.m <- aggregate(Sample ~ Lineage + Iso2 + WHORegion, meta, length)

#convert data to one row per location
country <- dcast(country.m, Iso2 + WHORegion ~ Lineage)
names(country) <- c("Iso2", "WHORegion", "Lin1","Lin2","Lin3","Lin4","Lin5","Lin6","Lin7")

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

#calculate total number of samples from each country
country$total = rowSums(country[,c("Lin1","Lin2","Lin3","Lin4","Lin5","Lin6","Lin7")])

#calculate lineage frequencies for each country
#country$perLin1 <- (country$Lin1 / sum(country$Lin1, na.rm=TRUE))*100


country$perLin1 <- (country$Lin1/country$total)*100
country$perLin2 <- (country$Lin2/country$total)*100
country$perLin3 <- (country$Lin3/country$total)*100
country$perLin4 <- (country$Lin4/country$total)*100
country$perLin5 <- (country$Lin5/country$total)*100
country$perLin6 <- (country$Lin6/country$total)*100
country$perLin7 <- (country$Lin7/country$total)*100


country[country == 0] <- NA


#join data to country map
m2 <- joinCountryData2Map(country,
                          joinCode = "ISO2",
                          nameJoinColumn = "Iso2")




op <- par(fin=c(7,9),mfcol=c(4,2),mai=c(0,0,0.2,0),xaxs="i",yaxs="i")

panels = c("perLin1", "perLin2", "perLin3", "perLin4", "perLin5", "perLin6", "perLin7")
brewerList <- c("Greens","Greys","Oranges","OrRd","PuBuGn","Purples","YlGn")

for(i in 1:7)
{
  colourPalette <- brewer.pal(7,brewerList[i])
  
  lineage <- panels[i]
  mapParams <- mapCountryData( m2
                               , nameColumnToPlot=lineage
                               , addLegend=FALSE
                               , colourPalette=colourPalette
                               , mapTitle=lineage)
  do.call( addMapLegend
           , c(mapParams, horizontal=TRUE,legendWidth=0.7))
}


par(op)


###try2

op <- par(fin=c(7,9),mfcol=c(2,2),mai=c(0,0,0.2,0),xaxs="i",yaxs="i")

panels = c("perLin1", "perLin2", "perLin3", "perLin4") #, "perLin5", "perLin6", "perLin7")
brewerList <- c("RdPu", "Blues", "Purples", "Reds")

for(i in 1:4)
{
  colourPalette <- brewer.pal(7,brewerList[i])
  
  lineage <- panels[i]
  mapParams <- mapCountryData( m2
                               , nameColumnToPlot=lineage
                               , addLegend=FALSE
                               , colourPalette=colourPalette
                               , mapTitle=lineage)
  do.call( addMapLegend
           , c(mapParams, horizontal=TRUE,legendWidth=0.7))
}


par(op)


