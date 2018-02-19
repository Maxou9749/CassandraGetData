# Decembre 2012
dir.create("Decembre 2012")

# Global
G_SL <- CassandraGetData(idTransaction = Liste_tr[1], idSensor = Ray_G, timeStart = "2012-12-01 00:01:00", timeEnd = "2012-12-31 23:59:00")
write.table(G_SL, "C:/Users/max97/Documents/Decembre 2012/dec2012_Global_Saint_Leu.txt", sep=";")
G_SL <- read.table("C:/Users/max97/Documents/Decembre 2012/dec2012_Global_Saint_Leu.txt", sep=";")
G_SL <- na.omit(object = G_SL)
Moy_Dec_G_SL <- mean(G_SL$value)
G_SA <- CassandraGetData(idTransaction = Liste_tr[2], idSensor = Ray_G, timeStart = "2012-12-01 00:01:00", timeEnd = "2012-12-31 23:59:00")
write.table(G_SA, "C:/Users/max97/Documents/Decembre 2012/dec2012_Global_Saint_Andre.txt", sep=";")
G_SA <- read.table("C:/Users/max97/Documents/Decembre 2012/dec2012_Global_Saint_Andre.txt", sep=";")
G_SA <- na.omit(object = G_SA)
Moy_Dec_G_SA <- mean(G_SA$value)
G_SP <- CassandraGetData(idTransaction = Liste_tr[3], idSensor = Ray_G, timeStart = "2012-12-01 00:01:00", timeEnd = "2012-12-31 23:59:00")
write.table(G_SP, "C:/Users/max97/Documents/Decembre 2012/dec2012_Global_Saint_Pierre.txt", sep=";")
G_SP <- read.table("C:/Users/max97/Documents/Decembre 2012/dec2012_Global_Saint_Leu.txt", sep=";")
G_SP <- na.omit(object = G_SP)
Moy_Dec_G_SP <- mean(G_SP$value)
G_MBDN <- CassandraGetData(idTransaction = Liste_tr[4], idSensor = Ray_G, timeStart = "2012-12-01 00:01:00", timeEnd = "2012-12-31 23:59:00")
write.table(G_MBDN, "C:/Users/max97/Documents/Decembre 2012/dec2012_Global_Moufia_BDN.txt", sep=";")
G_MBDN <- read.table("C:/Users/max97/Documents/Decembre 2012/dec2012_Global_Saint_Leu.txt", sep=";")
G_MBDN <- na.omit(object = G_MBDN)
Moy_Dec_G_MBDN <- mean(G_MBDN$value)
G_LP <- CassandraGetData(idTransaction = Liste_tr[5], idSensor = Ray_G, timeStart = "2012-12-01 00:01:00", timeEnd = "2012-12-31 23:59:00")
write.table(G_LP, "C:/Users/max97/Documents/Decembre 2012/dec2012_Global_La_Possession.txt", sep=";")
G_LP <- read.table("C:/Users/max97/Documents/Decembre 2012/dec2012_Global_Saint_Leu.txt", sep=";")
G_LP <- na.omit(object = G_LP)
Moy_Dec_G_LP <- mean(G_LP$value)

# Diffus
D_SL <- CassandraGetData(idTransaction = Liste_tr[1], idSensor = Ray_D, timeStart = "2012-12-01 00:01:00", timeEnd = "2012-12-31 23:59:00")
dir.create("Decembre 2012")
write.table(D_SL, "C:/Users/max97/Documents/Decembre 2012/dec2012_Diffus_Saint_Leu.txt", sep=";")
D_SL <- read.table("C:/Users/max97/Documents/Decembre 2012/dec2012_Diffus_Saint_Leu.txt", sep=";")
D_SL <- na.omit(object = D_SL)
Moy_Dec_D_SL <- mean(D_SL$value)
D_SA <- CassandraGetData(idTransaction = Liste_tr[2], idSensor = Ray_D, timeStart = "2012-12-01 00:01:00", timeEnd = "2012-12-31 23:59:00")
write.table(D_SA, "C:/Users/max97/Documents/Decembre 2012/dec2012_Diffus_Saint_Andre.txt", sep=";")
D_SA <- read.table("C:/Users/max97/Documents/Decembre 2012/dec2012_Diffus_Saint_Andre.txt", sep=";")
D_SA <- na.omit(object = D_SA)
Moy_Dec_D_SA <- mean(D_SA$value)
D_SP <- CassandraGetData(idTransaction = Liste_tr[3], idSensor = Ray_D, timeStart = "2012-12-01 00:01:00", timeEnd = "2012-12-31 23:59:00")
write.table(D_SP, "C:/Users/max97/Documents/Decembre 2012/dec2012_Diffus_Saint_Pierre.txt", sep=";")
D_SP <- read.table("C:/Users/max97/Documents/Decembre 2012/dec2012_Diffus_Saint_Leu.txt", sep=";")
D_SP <- na.omit(object = D_SP)
Moy_Dec_D_SP <- mean(D_SP$value)
D_MBDN <- CassandraGetData(idTransaction = Liste_tr[4], idSensor = Ray_D, timeStart = "2012-12-01 00:01:00", timeEnd = "2012-12-31 23:59:00")
write.table(D_MBDN, "C:/Users/max97/Documents/Decembre 2012/dec2012_Diffus_Moufia_BDN.txt", sep=";")
D_MBDN <- read.table("C:/Users/max97/Documents/Decembre 2012/dec2012_Diffus_Saint_Leu.txt", sep=";")
D_MBDN <- na.omit(object = D_MBDN)
Moy_Dec_D_MBDN <- mean(D_MBDN$value)
D_LP <- CassandraGetData(idTransaction = Liste_tr[5], idSensor = Ray_D, timeStart = "2012-12-01 00:01:00", timeEnd = "2012-12-31 23:59:00")
write.table(D_LP, "C:/Users/max97/Documents/Decembre 2012/dec2012_Diffus_La_Possession.txt", sep=";")
D_LP <- read.table("C:/Users/max97/Documents/Decembre 2012/dec2012_Diffus_Saint_Leu.txt", sep=";")
D_LP <- na.omit(object = D_LP)
Moy_Dec_D_LP <- mean(D_LP$value)


for (an in seq(2013,2017)) {
  # Janvier
  for (jan in seq(1,31)) {
    
  }
  # Fevrier
  if (an == 2014) {for (fev in seq(1,29)) {}} else {for (fev in seq(1,28)) {}}
  # Mars
  for (mars in seq(1,31)) {
    
  }
  # Avril
  for (avr in seq(1,30)) {
    
  }
  # Mai
  for (mai in seq(1,31)) {
    
  }
  # Juin
  for (juin in seq(1,30)) {
    
  }
  # Juillet
  for (juill in seq(1,31)) {
    
  }
  # Aout
  for (aou in seq(1,31)) {
    
  }
  # Septembre
  for (sept in seq(1,30)) {
    
  }
  # Octobre
  for (oct in seq(1,31)) {
    
  }
  # Novembre
  for (nov in seq(1,30)) {
    
  }
  # Decembre
  for (dece in seq(1,31)) {
    
  }
}
# Janvier 2018
for (jan in seq(1,31)) {
  
}