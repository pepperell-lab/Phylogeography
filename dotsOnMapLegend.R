map("world", fill=FALSE, xlim=c(-80,179), ylim=c(-50, 80))
map.axes()

mapDat2 <- mapDat2[order(mapDat2$total, decreasing=TRUE),]

for(i in 1:nrow(mapDat2)) {
  row <- mapDat2[i,]
  add.pie(x = row$Longitude, y = row$Latitude, 
          z=c(row$Lin1,row$Lin3,row$Lin3,row$Lin4,row$Lin5,row$Lin6,row$Lin7), 
          labels = NA, radius=(log2(row$total)+2), 
          col=c("pink", "blue", "darkmagenta", "red", "darkred", "darkgreen", "yellow3"))
}

legend("topleft", 
       legend = c("Lineage 1", "Lineage 2", "Lineage 3", "Lineage 4", "Lineage 5", "Lineage 6", "Lineage 7"),
       col=c("pink", "blue", "darkmagenta", "red", "darkred", "darkgreen", "yellow3"),
       pch = 16, cex = 0.8, pt.cex = 1.5)

#Size legend
add.pie(x=-65, y=-40, z=1, labels = "32", radius=(log2(32)+2), col = "black")
add.pie(x=-65, y=-25, z=1, labels = "16", radius=(log2(16)+2), col = "black")
add.pie(x=-65, y=-12, z=1, labels = "8", radius=(log2(8)+2), col = "black")
add.pie(x=-65, y=-0, z=1, labels = "4", radius=(log2(4)+2), col = "black")
add.pie(x=-65, y=10, z=1, labels = "2", radius=(log2(2)+2), col = "black")
add.pie(x=-65, y=18, z=1, labels = "1", radius=(log2(1)+2), col = "black")




#lineage 1

map("world", fill=FALSE, xlim=c(-80,179), ylim=c(-50, 80))
map.axes()

lin1 <- mapDat2[,1:3]
lin1[lin1 == 0] <- NA
lin1 <- lin1[complete.cases(lin1),]

for(i in 1:nrow(lin1)) {
  row <- lin1[i,]
  add.pie(x = row$Longitude, y = row$Latitude, 
          z=c(row$Lin1), 
          labels = NA, radius=(log2(row$Lin1)+2), 
          col=c("pink"))
}

#lineage 2
map("world", fill=FALSE, xlim=c(-80,179), ylim=c(-50, 80))
map.axes()

Lin2 <- mapDat2[,c(1:2, 4)]
Lin2[Lin2 == 0] <- NA
Lin2 <- Lin2[complete.cases(Lin2),]

for(i in 1:nrow(Lin2)) {
  row <- Lin2[i,]
  add.pie(x = row$Longitude, y = row$Latitude, 
          z=c(row$Lin2), 
          labels = NA, radius=(log2(row$Lin2)+2), 
          col=c("blue"))
}

#lineage 3
map("world", fill=FALSE, xlim=c(-80,179), ylim=c(-50, 80))
map.axes()

Lin3 <- mapDat2[,c(1:2, 5)]
Lin3[Lin3 == 0] <- NA
Lin3 <- Lin3[complete.cases(Lin3),]

for(i in 1:nrow(Lin3)) {
  row <- Lin3[i,]
  add.pie(x = row$Longitude, y = row$Latitude, 
          z=c(row$Lin3), 
          labels = NA, radius=(log2(row$Lin3)+2), 
          col=c("darkmagenta"))
}

#lineage 4
map("world", fill=FALSE, xlim=c(-80,179), ylim=c(-50, 80))
map.axes()

Lin4 <- mapDat2[,c(1:2, 6)]
Lin4[Lin4 == 0] <- NA
Lin4 <- Lin4[complete.cases(Lin4),]

for(i in 1:nrow(Lin4)) {
  row <- Lin4[i,]
  add.pie(x = row$Longitude, y = row$Latitude, 
          z=c(row$Lin4), 
          labels = NA, radius=(log2(row$Lin4)+2), 
          col=c("red"))
}

#lineage 5
map("world", fill=FALSE, xlim=c(-80,179), ylim=c(-50, 80))
map.axes()

Lin5 <- mapDat2[,c(1:2, 7)]
Lin5[Lin5 == 0] <- NA
Lin5 <- Lin5[complete.cases(Lin5),]

for(i in 1:nrow(Lin5)) {
  row <- Lin5[i,]
  add.pie(x = row$Longitude, y = row$Latitude, 
          z=c(row$Lin5), 
          labels = NA, radius=(log2(row$Lin5)+2), 
          col=c("darkred"))
}


#lineage 6
map("world", fill=FALSE, xlim=c(-80,179), ylim=c(-50, 80))
map.axes()

Lin6 <- mapDat2[,c(1:2, 8)]
Lin6[Lin6 == 0] <- NA
Lin6 <- Lin6[complete.cases(Lin6),]

for(i in 1:nrow(Lin6)) {
  row <- Lin6[i,]
  add.pie(x = row$Longitude, y = row$Latitude, 
          z=c(row$Lin6), 
          labels = NA, radius=(log2(row$Lin6)+2), 
          col=c("darkgreen"))
}


#lineage 7
map("world", fill=FALSE, xlim=c(-80,179), ylim=c(-50, 80))
map.axes()

Lin7 <- mapDat2[,c(1:2, 9)]
Lin7[Lin7 == 0] <- NA
Lin7 <- Lin7[complete.cases(Lin7),]

for(i in 1:nrow(Lin7)) {
  row <- Lin7[i,]
  add.pie(x = row$Longitude, y = row$Latitude, 
          z=c(row$Lin7), 
          labels = NA, radius=(log2(row$Lin7)+2), 
          col=c("yellow3"))
}






#############################
#lineage 1

map("world", fill=FALSE, xlim=c(-80,179), ylim=c(-50, 80))
map.axes()

lin1 <- mapDat2[,1:3]
lin1[lin1 == 0] <- NA
lin1 <- lin1[complete.cases(lin1),]
lin1$


for(i in 1:nrow(lin1)) {
  row <- lin1[i,]
  add.pie(x = row$Longitude, y = row$Latitude, 
          z=c(row$Lin1), 
          labels = NA, radius=(log2(row$Lin1)+2), 
          col=c("pink"))
}

#lineage 2
map("world", fill=FALSE, xlim=c(-80,179), ylim=c(-50, 80))
map.axes()

Lin2 <- mapDat2[,c(1:2, 4)]
Lin2[Lin2 == 0] <- NA
Lin2 <- Lin2[complete.cases(Lin2),]

for(i in 1:nrow(Lin2)) {
  row <- Lin2[i,]
  add.pie(x = row$Longitude, y = row$Latitude, 
          z=c(row$Lin2), 
          labels = NA, radius=(log2(row$Lin2)+2), 
          col=c("blue"))
}

#lineage 3
map("world", fill=FALSE, xlim=c(-80,179), ylim=c(-50, 80))
map.axes()

Lin3 <- mapDat2[,c(1:2, 5)]
Lin3[Lin3 == 0] <- NA
Lin3 <- Lin3[complete.cases(Lin3),]

for(i in 1:nrow(Lin3)) {
  row <- Lin3[i,]
  add.pie(x = row$Longitude, y = row$Latitude, 
          z=c(row$Lin3), 
          labels = NA, radius=(log2(row$Lin3)+2), 
          col=c("darkmagenta"))
}

#lineage 4
map("world", fill=FALSE, xlim=c(-80,179), ylim=c(-50, 80))
map.axes()

Lin4 <- mapDat2[,c(1:2, 6)]
Lin4[Lin4 == 0] <- NA
Lin4 <- Lin4[complete.cases(Lin4),]

for(i in 1:nrow(Lin4)) {
  row <- Lin4[i,]
  add.pie(x = row$Longitude, y = row$Latitude, 
          z=c(row$Lin4), 
          labels = NA, radius=(log2(row$Lin4)+2), 
          col=c("red"))
}

#lineage 5
map("world", fill=FALSE, xlim=c(-80,179), ylim=c(-50, 80))
map.axes()

Lin5 <- mapDat2[,c(1:2, 7)]
Lin5[Lin5 == 0] <- NA
Lin5 <- Lin5[complete.cases(Lin5),]

for(i in 1:nrow(Lin5)) {
  row <- Lin5[i,]
  add.pie(x = row$Longitude, y = row$Latitude, 
          z=c(row$Lin5), 
          labels = NA, radius=(log2(row$Lin5)+2), 
          col=c("darkred"))
}


#lineage 6
map("world", fill=FALSE, xlim=c(-80,179), ylim=c(-50, 80))
map.axes()

Lin6 <- mapDat2[,c(1:2, 8)]
Lin6[Lin6 == 0] <- NA
Lin6 <- Lin6[complete.cases(Lin6),]

for(i in 1:nrow(Lin6)) {
  row <- Lin6[i,]
  add.pie(x = row$Longitude, y = row$Latitude, 
          z=c(row$Lin6), 
          labels = NA, radius=(log2(row$Lin6)+2), 
          col=c("darkgreen"))
}


#lineage 7
map("world", fill=FALSE, xlim=c(-80,179), ylim=c(-50, 80))
map.axes()

Lin7 <- mapDat2[,c(1:2, 9)]
Lin7[Lin7 == 0] <- NA
Lin7 <- Lin7[complete.cases(Lin7),]

for(i in 1:nrow(Lin7)) {
  row <- Lin7[i,]
  add.pie(x = row$Longitude, y = row$Latitude, 
          z=c(row$Lin7), 
          labels = NA, radius=(log2(row$Lin7)+2), 
          col=c("yellow3"))
}