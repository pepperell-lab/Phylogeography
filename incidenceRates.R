#CDC Incidence Rates

require(ggplot2)



setwd("C:/Users/Mary/PepLab/data/Phylogeography")
filename <- "sampleScheme/TB_burden_countries_2015-12-01.csv"
cdc <- read.csv(filename, header=T)

#subset the dataset to only retain columns of interest and data from the year 2014
cdc.2014 <- subset(cdc, year == 2014, c(country, iso2, iso3, g_whoregion, e_prev_num, e_prev_num_lo, e_prev_num_hi))

#give incidence by WHO region
reg <- aggregate(e_prev_num ~ g_whoregion, data = cdc.2014, FUN=sum)
reg$e_prev_num_lo <- aggregate(e_prev_num_lo ~ g_whoregion, data = cdc.2014, FUN=sum)[,2]
reg$e_prev_num_hi <- aggregate(e_prev_num_hi ~ g_whoregion, data = cdc.2014, FUN=sum)[,2]

#order the datasets by decreasing incidence
reg[order(reg$e_prev_num, decreasing = TRUE),]
cdc.2014[order(cdc.2014$e_prev_num, decreasing = TRUE),]

cdc.2014 <- cdc.2014[order(cdc.2014$e_prev_num, decreasing = TRUE),]

#how to order the country factor by the prevelance!
cdc.2014$iso2 <- factor(cdc.2014$iso2, levels = cdc.2014[order(cdc.2014$e_prev_num, decreasing = TRUE), "iso2"])

p.reg <- ggplot(reg, aes(x=g_whoregion, y=e_prev_num)) +
  geom_point() +
  geom_errorbar(aes(ymin=e_prev_num_lo, ymax=e_prev_num_hi), colour="black", width=.1)
p.reg

p.all <- ggplot(cdc.2014, aes(x=iso2, y=e_prev_num)) +
  geom_point() +
  geom_errorbar(aes(ymin=e_prev_num_lo, ymax=e_prev_num_hi), coulour="black", width=.1)
p.all


#### Lets ditch the AMR 
oldWorld <- subset(cdc.2014, g_whoregion != "AMR")

p.ow <- ggplot(oldWorld, aes(x=iso2, y=e_prev_num)) +
  geom_point() +
  geom_errorbar(aes(ymin=e_prev_num_lo, ymax=e_prev_num_hi), coulour="black", width=.1)
p.ow

total <- sum(oldWorld$e_prev_num)
totalAll <- sum(cdc.2014$e_prev_num)
oldWorld$fracA <- oldWorld$e_prev_num/totalAll


### Add in lat & long data for countries
latLongFile = "sampleScheme/Country_List_ISO_3166_Codes_Latitude_Longitude.csv"
loc <- read.csv(latLongFile, header=TRUE)

oldWorld$lat <- loc[match(oldWorld$iso2, loc$Alpha.2.code), 'Latitude..average.']
oldWorld$long <- loc[match(oldWorld$iso2, loc$Alpha.2.code), 'Longitude..average.']


### Add sample info
linFile <- "sampleScheme/lineageBreakdown_latlong.txt"
lin <- read.table(linFile, header=T, sep='\t')

lin$iso2 <- loc[match(lin$Country, loc$Country), 'Alpha.2.code']

namingProblems <- subset(lin, is.na(iso2))
lin[which(lin$Country == 'Vietnam'), 'iso2'] = as.factor("VN")
lin[which(lin$Country == 'Tanzania'), 'iso2'] = as.factor("TZ")
lin[which(lin$Country == 'Russia'), 'iso2'] = as.factor("RU")
lin[which(lin$Country == 'Republic of Kiribati'), 'iso2'] = as.factor("KI")
lin[which(lin$Country == 'South Korea'), 'iso2'] = as.factor("KR")
lin[which(lin$Country == 'Laos'), 'iso2'] = as.factor("LA")
lin[which(lin$Country == 'Iran'), 'iso2'] = as.factor("IR")
lin[which(lin$Country == 'Laos'), 'iso2'] = as.factor("LA")
lin[which(lin$Country == 'Burma'), 'iso2'] = as.factor("MM") #Myanmar
lin[which(lin$Country == 'Bosnia'), 'iso2'] = as.factor("BA")
lin[which(lin$Country == 'Comoro Islands'), 'iso2'] = as.factor("KM")
lin[which(lin$Country == 'New Guinea'), 'iso2'] = as.factor("PG")
namingProblems <- subset(lin, is.na(iso2)) #should be 0 if resolved


oldWorld$n <- lin[match(oldWorld$iso2, lin$iso2), 'n']
