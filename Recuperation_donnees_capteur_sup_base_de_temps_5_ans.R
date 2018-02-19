# ---------------------------------------------------------
#                      Maxime ROUSSEAU
#      Recuperation des donnees sur 5 ans des capteurs
#                        13/02/2018
# ---------------------------------------------------------

# Chargement de la library rLE2P
library(rLE2P)

Liste <- read.table("C:/Users/max97/Documents/Espace de travail Git/CassandraGetData/Global_Diffus_solaire_sup_5_ans.txt", sep = "\t")

# Selection des capteurs solaires pour chaque transaction
Ray_D <- "FD_Avg"
Ray_G <- "FG_Avg"

Saint_Leu <- "1465986548"
Saint_Andre <- "1465986253"
Saint_Pierre <- "1465989663"
Moufia_BDN <- "1465986423"
La_Possession <- "1465986484"

Liste_tr <- c(Saint_Leu, Saint_Andre, Saint_Pierre, Moufia_BDN, La_Possession)


# Rayonnement Global
# Recuperation du mois de novembre
Global_1 <- CassandraGetData(idTransaction = Liste_tr[1], idSensor = Ray_G, timeStart = "2012-11-01 05:30:00", timeEnd = "2012-11-01 20:00:00")
write.table(Global_1, "C:/Users/max97/Desktop/nov2012_Global_Saint_Leu.txt", sep=";")
Global_2 <- CassandraGetData(idTransaction = Liste_tr[2], idSensor = Ray_G, timeStart = "2012-11-01 05:30:00", timeEnd = "2012-11-01 20:00:00")
write.table(Global_2, "C:/Users/max97/Desktop/nov2012_Global_Saint_Andre.txt", sep=";")
Global_3 <- CassandraGetData(idTransaction = Liste_tr[3], idSensor = Ray_G, timeStart = "2012-11-01 05:30:00", timeEnd = "2012-11-01 20:00:00")
write.table(Global_3, "C:/Users/max97/Desktop/nov2012_Global_Saint_Pierre.txt", sep=";")
Global_4 <- CassandraGetData(idTransaction = Liste_tr[4], idSensor = Ray_G, timeStart = "2012-11-01 05:30:00", timeEnd = "2012-11-01 20:00:00")
write.table(Global_4, "C:/Users/max97/Desktop/nov2012_Global_Moufia_BDN.txt", sep=";")
Global_5 <- CassandraGetData(idTransaction = Liste_tr[5], idSensor = Ray_G, timeStart = "2012-11-01 05:30:00", timeEnd = "2012-11-01 20:00:00")
write.table(Global_5, "C:/Users/max97/Desktop/nov2012_Global_La_Possession.txt", sep=";")


# Rayonnement Diffus
Diffus_1 <- CassandraGetData(idTransaction = Liste_tr[1], idSensor = Ray_D, timeStart = "2012-11-01 05:30:00", timeEnd = "2012-11-01 20:00:00")
write.table(Diffus_1, "C:/Users/max97/Desktop/nov2012_Diffus_Saint_Leu.txt", sep=";")
Diffus_2 <- CassandraGetData(idTransaction = Liste_tr[2], idSensor = Ray_D, timeStart = "2012-11-01 05:30:00", timeEnd = "2012-11-01 20:00:00")
write.table(Diffus_2, "C:/Users/max97/Desktop/nov2012_Diffus_Saint_Andre.txt", sep=";")
Diffus_3 <- CassandraGetData(idTransaction = Liste_tr[3], idSensor = Ray_D, timeStart = "2012-11-01 05:30:00", timeEnd = "2012-11-01 20:00:00")
write.table(Diffus_3, "C:/Users/max97/Desktop/nov2012_Diffus_Saint_Pierre.txt", sep=";")
Diffus_4 <- CassandraGetData(idTransaction = Liste_tr[4], idSensor = Ray_D, timeStart = "2012-11-01 05:30:00", timeEnd = "2012-11-01 20:00:00")
write.table(Diffus_4, "C:/Users/max97/Desktop/nov2012_Diffus_Moufia_BDN.txt", sep=";")
Diffus_5 <- CassandraGetData(idTransaction = Liste_tr[5], idSensor = Ray_D, timeStart = "2012-11-01 05:30:00", timeEnd = "2012-11-01 20:00:00")
write.table(Diffus_5, "C:/Users/max97/Desktop/nov2012_Diffus_La_Possession.txt", sep=";")



# Afficher les donnees
#temps <- Diffus_1$date
#temps <- sub(pattern="H", replacement=":",temps, fixed=TRUE)
#temps <- strptime(temps, format="%Y-%m-%d %H:%M:%S")

#plot(temps, Global_1$value, type = "l")
#lines(temps, Diffus_1$value, type = "l", col = 2)