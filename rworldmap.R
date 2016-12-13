#install.packages('rworldmap', dependencies=TRUE)
require('rworldmap')

data(countryExData)
countryExData[5:10, 1:5]

#joining data to a country map
sPDF <- joinCountryData2Map(countryExData,
                            joinCode = "ISO3",
                            nameJoinColumn = "ISO3V10")

#displaying a countries map
par(mai=c(0,0,0.2,0), xaxs="i", yaxs="i")
mapCountryData(sPDF, nameColumnToPlot="BIODIVERSITY")

#make default legend smaller
mapParams <- mapCountryData( sPDF, nameColumnToPlot="BIODIVERSITY"
                              , addLegend=FALSE )
do.call( addMapLegend, c(mapParams, legendWidth=0.5, legendMar = 2))

#mapping your own half degree gridded data
par(mai=c(0,0,0.2,0),xaxs="i",yaxs="i")
data(gridExData)
mapGriddedData(gridExData)

#aggregating half degree gridded data to a country level
par(mai=c(0,0,0.2,0),xaxs="i",yaxs="i")
mapParams <- mapHalfDegreeGridToCountries(gridExData, addLegend=FALSE)
do.call( addMapLegend, c(mapParams, legendWidth=0.5, legendMar = 2))

#aggregating country level data to global regions
#Using country2Region to calculate mean ENVHEALTH in Stern regions.
sternEnvHealth <- country2Region(inFile=countryExData
                                 ,nameDataColumn="ENVHEALTH"
                                 ,joinCode="ISO3"
                                 ,nameJoinColumn="ISO3V10"
                                 ,regionType="Stern"
                                 ,FUN="mean"
                                 )
print(sternEnvHealth)

par(mai=c(0,0,0.2,0),xaxs="i",yaxs="i")
mapByRegion( countryExData
             , nameDataColumn="CLIMATE"
             , joinCode="ISO3"
             , nameJoinColumn="ISO3V10"
             , regionType="Stern"
             , FUN="mean"
             )


# Map display options common across the plotting methods
#The following arguments can be specified to alter the appearance of your plots.
#❼ catMethod method for categorisation of data ”pretty”, ”fixedWidth”, ”diverging”,”logFixedWidth”,”quantiles”#,”categorical”,
#or a numeric vector defining breaks.
#❼ numCats number of categories to classify the data into, may be modified if that
#exact number is not possible for the chosen catMethod.
#❼ colourPalette a string describing the colour palette to use, choice of :
#  1. ”palette” for the current palette
#2. a vector of valid colours, e.g. c(”red”,”white”,”blue”) or output from RColourBrewer
#3. one of ”heat”, ”diverging”, ”white2Black”, ”black2White”, ”topo”, ”rainbow”,
#”terrain”, ”negpos8”, ”negpos9”
#❼ addLegend set to TRUE for a default legend, if set to FALSE the function addMapLegend()
#or addMapLegendBoxes() can be used to create a more flexible
#legend.
#❼ mapRegion a region to zoom in on, can be set to a country name from getMap()$NAME
#or one of ”eurasia”,”africa”,”latin america”,”uk”,”oceania”,”asia”


par(mai=c(0,0,0.2,0),xaxs="i",yaxs="i")
#joining the data to a map
sPDF <- joinCountryData2Map(countryExData,
                                joinCode = "ISO3",
                                nameJoinColumn = "ISO3V10"
                                )
#creating a user defined colour palette
op <- palette(c('green','yellow','orange','red'))
#find quartile breaks
cutVector <- quantile(sPDF@data[["BIODIVERSITY"]],na.rm=TRUE)
#classify the data to a factor
sPDF@data[["BIOcategories"]] <- cut(sPDF@data[["BIODIVERSITY"]]
                                        , cutVector
                                        , include.lowest=TRUE )
#rename the categories
levels(sPDF@data[["BIOcategories"]]) <- c('low', 'med', 'high', 'vhigh')
#mapping
mapCountryData( sPDF
                    , nameColumnToPlot='BIOcategories'
                    , catMethod='categorical'
                    , mapTitle='Biodiversity categories'
                    , colourPalette='palette'
                    , oceanCol='lightblue'
                    , missingCountryCol='white'
                    )


par(mai=c(0,0,0.2,0),xaxs="i",yaxs="i")
mapCountryData( sPDF
                  , nameColumnToPlot='BIOcategories'
                  , catMethod='categorical'
                  , mapTitle='Biodiversity categories'
                  , colourPalette='palette'
                  , oceanCol='lightblue'
                  , missingCountryCol='white'
                  , mapRegion='Eurasia'
                  , borderCol='black'
                  )
## At end of plotting, reset palette to previous settings:
palette(op)

#Bubble plots
par(mai=c(0,0,0.2,0),xaxs="i",yaxs="i")
mapBubbles( dF=mPDF
              , nameZSize="Total"
              , nameZColour="Iso2"
              , colourPalette='rainbow'
              )

