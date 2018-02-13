# ---------------------------------------------------------
#                      Maxime ROUSSEAU
#      Recuperation des donnees sur 5 ans des capteurs
#                        13/02/2018
# ---------------------------------------------------------

# Chargement de la library rLE2P
library(rLE2P)

Liste <- read.table("C:/Users/max97/Documents/Espace de travail Git/CassandraGetData/Liste_capteurs_base_de_temps_sup_5_ans.txt", sep = "\t")

# Selection des capteurs solaires pour chaque transaction
Ray_D <- c("FD_Avg", "FDnum_Avg")
Ray_G <- c("FG_Avg", "FGnum_Avg")

Saint_Leu <- "1465986548"
Saint_Andre <- "1465986253"
Saint_Pierre <- "1465989663"
Moufia_BDN <- "1465986423"
La_Possession <- "1465986484"

Liste_tr <- c(Saint_Leu, Saint_Andre, Saint_Pierre, Moufia_BDN, La_Possession)

# Rayonnement Diffus
Diffus_1 <- CassandraGetData(idTransaction = Liste_tr[1], idSensor = Ray_D[1], timeStart = "2012-11-01 00:01:00", timeEnd = "2012-12-01 00:00:00")
Diffus_2 <- CassandraGetData(idTransaction = Liste_tr[2], idSensor = Ray_D[1], timeStart = "2012-11-01 00:01:00", timeEnd = "2012-12-01 00:00:00")
Diffus_3 <- CassandraGetData(idTransaction = Liste_tr[3], idSensor = Ray_D[1], timeStart = "2012-11-01 00:01:00", timeEnd = "2012-12-01 00:00:00")
Diffus_4 <- CassandraGetData(idTransaction = Liste_tr[4], idSensor = Ray_D[1], timeStart = "2012-11-01 00:01:00", timeEnd = "2012-12-01 00:00:00")
Diffus_5 <- CassandraGetData(idTransaction = Liste_tr[5], idSensor = Ray_D[1], timeStart = "2012-11-01 00:01:00", timeEnd = "2012-12-01 00:00:00")

# Rayonnement Global
# Recuperation du mois de novembre
Global_1 <- CassandraGetData(idTransaction = Liste_tr[1], idSensor = Ray_G[1], timeStart = "2012-11-01 00:01:00", timeEnd = "2012-12-01 00:00:00")
Global_2 <- CassandraGetData(idTransaction = Liste_tr[2], idSensor = Ray_G[1], timeStart = "2012-11-01 00:01:00", timeEnd = "2012-12-01 00:00:00")
Global_3 <- CassandraGetData(idTransaction = Liste_tr[3], idSensor = Ray_G[1], timeStart = "2012-11-01 00:01:00", timeEnd = "2012-12-01 00:00:00")
Global_4 <- CassandraGetData(idTransaction = Liste_tr[4], idSensor = Ray_G[1], timeStart = "2012-11-01 00:01:00", timeEnd = "2012-12-01 00:00:00")
Global_5 <- CassandraGetData(idTransaction = Liste_tr[5], idSensor = Ray_G[1], timeStart = "2012-11-01 00:01:00", timeEnd = "2012-12-01 00:00:00")


temps <- Diffus_1$date
temps <- sub(pattern="H", replacement=":",temps, fixed=TRUE)
temps <- strptime(temps, format="%Y-%m-%d %H:%M:%S")

plot(temps, Global_1$value, type = "l")
lines(temps, Diffus_1$value, type = "l", col = 2)

length(temps)

