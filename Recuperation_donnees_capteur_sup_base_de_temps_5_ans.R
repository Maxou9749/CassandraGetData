
#                               Maxime ROUSSEAU
#     Recuperation des donnees de rayonnement solaire (Global et Diffus) sur 5 ans
#                                 21/02/2018


# Chargement de la library rLE2P
library(rLE2P)


# ---- Définition des variables utilisees ----
Ray_D <- "FD_Avg"
Ray_G <- "FG_Avg"

Saint_Leu <- "1465986548"
Saint_Andre <- "1465986253"
Saint_Pierre <- "1465989663"
Moufia_BDN <- "1465986423"
La_Possession <- "1465986484"

Liste_tr <- c(Saint_Leu, Saint_Andre, Saint_Pierre, Moufia_BDN, La_Possession)

jr_mois <- c(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
mois <- c("Janvier", "Fevrier", "Mars", "Avril", "Mai", "Juin", "Juillet", "Aout", "Septembre", "Octobre", "Novembre", "Decembre")
annee <- c("2012", "2013", "2014", "2015", "2016", "2017","2018")

# ---- Création des temps de début et de fin ----
time_d <- matrix(nrow = 12, ncol = 7)
time_f <- matrix(nrow = 12, ncol = 7)

for (j in seq(2012,2018)) {
  for (i in seq(1,12)) {
    moi <- i
    an <- j
    if (moi < 10) {moi <- paste(0, moi, sep ="")} else {moi <- paste(moi)}
    date_d <- paste(an, moi, "01", sep = "-")
    date_d <- paste(date_d, "00:01:00", sep = " ")
    jour <- jr_mois[i]
    date_f <- paste(an, moi, as.character(jour), sep = "-")
    date_f <- paste(date_f,"23:59:00", sep = " ")
    time_d[i,j-2011] <- date_d
    time_f[i,j-2011] <- date_f
  }
}


# ---- Création des dossiers ----
setwd(dir = "~")
dir.create("Base de données")
setwd(dir = "Base de données")
dir.create("2012")
dir.create("2013")
dir.create("2014")
dir.create("2015")
dir.create("2016")
dir.create("2017")
dir.create("2018")

for (j in seq(2,6)) {
  setwd(dir = "~/Base de données")
  setwd(dir = annee[j])
  for (i in seq(1,12)) {
    dir.create(mois[i])
  }
}

setwd(dir = "~/Base de données/2012")
dir.create("Novembre")
dir.create("Decembre")
setwd(dir = "~/Base de données/2018")
dir.create("Janvier")
setwd(dir = "~/Base de données")


# ---- Recuperation des donnees et mise dans leur dossier respectif ----
for (j in seq(1,12)) {
  for (i in seq(1,7)) {
    setwd(dir = "~/Base de données")
    setwd(dir = annee[i])
    if (dir.exists(mois[j]) == FALSE) {} else {
      setwd(dir = mois[j])
      # Global
      G_SL <- CassandraGetData(idTransaction = Liste_tr[1], idSensor = Ray_G, timeStart = time_d[j,i], timeEnd = time_f[j,i])
      write.table(G_SL, "Global_Saint_Leu.txt", sep=";")
      G_SL <- read.table("Global_Saint_Leu.txt", sep=";")
      G_SL <- na.omit(object = G_SL)
      write.table(G_SL, "Global_Saint_Leu.txt", sep=";")
      
      G_SA <- CassandraGetData(idTransaction = Liste_tr[2], idSensor = Ray_G, timeStart = time_d[j,i], timeEnd = time_f[j,i])
      write.table(G_SA, "Global_Saint_Andre.txt", sep=";")
      G_SA <- read.table("Global_Saint_Andre.txt", sep=";")
      G_SA <- na.omit(object = G_SA)
      write.table(G_SA, "Global_Saint_Andre.txt", sep=";")
      
      G_SP <- CassandraGetData(idTransaction = Liste_tr[3], idSensor = Ray_G, timeStart = time_d[j,i], timeEnd = time_f[j,i])
      write.table(G_SP, "Global_Saint_Pierre.txt", sep=";")
      G_SP <- read.table("Global_Saint_Pierre.txt", sep=";")
      G_SP <- na.omit(object = G_SP)
      write.table(G_SP, "Global_Saint_Pierre.txt", sep=";")
      
      G_MBDN <- CassandraGetData(idTransaction = Liste_tr[4], idSensor = Ray_G, timeStart = time_d[j,i], timeEnd = time_f[j,i])
      write.table(G_MBDN, "Global_Moufia_BDN.txt", sep=";")
      G_MBDN <- read.table("Global_Moufia_BDN.txt", sep=";")
      G_MBDN <- na.omit(object = G_MBDN)
      write.table(G_MBDN, "Global_Moufia_BDN.txt", sep=";")
      
      G_LP <- CassandraGetData(idTransaction = Liste_tr[5], idSensor = Ray_G, timeStart = time_d[j,i], timeEnd = time_f[j,i])
      write.table(G_LP, "Global_La_Possession.txt", sep=";")
      G_LP <- read.table("Global_La_Possession.txt", sep=";")
      G_LP <- na.omit(object = G_LP)
      write.table(G_LP, "Global_La_Possession.txt", sep=";")
      
      # Diffus
      D_SL <- CassandraGetData(idTransaction = Liste_tr[1], idSensor = Ray_D, timeStart = time_d[j,i], timeEnd = time_f[j,i])
      write.table(D_SL, "Diffus_Saint_Leu.txt", sep=";")
      D_SL <- read.table("Diffus_Saint_Leu.txt", sep=";")
      D_SL <- na.omit(object = D_SL)
      write.table(D_SL, "Diffus_Saint_Leu.txt", sep=";")
      
      D_SA <- CassandraGetData(idTransaction = Liste_tr[2], idSensor = Ray_D, timeStart = time_d[j,i], timeEnd = time_f[j,i])
      write.table(D_SA, "Diffus_Saint_Andre.txt", sep=";")
      D_SA <- read.table("Diffus_Saint_Andre.txt", sep=";")
      D_SA <- na.omit(object = D_SA)
      write.table(D_SA, "Diffus_Saint_Andre.txt", sep=";")
      
      D_SP <- CassandraGetData(idTransaction = Liste_tr[3], idSensor = Ray_D, timeStart = time_d[j,i], timeEnd = time_f[j,i])
      write.table(D_SP, "Diffus_Saint_Pierre.txt", sep=";")
      D_SP <- read.table("Diffus_Saint_Pierre.txt", sep=";")
      D_SP <- na.omit(object = D_SP)
      write.table(D_SP, "Diffus_Saint_Pierre.txt", sep=";")
      
      D_MBDN <- CassandraGetData(idTransaction = Liste_tr[4], idSensor = Ray_D, timeStart = time_d[j,i], timeEnd = time_f[j,i])
      write.table(D_MBDN, "Diffus_Moufia_BDN.txt", sep=";")
      D_MBDN <- read.table("Diffus_Moufia_BDN.txt", sep=";")
      D_MBDN <- na.omit(object = D_MBDN)
      write.table(D_MBDN, "Diffus_Moufia_BDN.txt", sep=";")
      
      D_LP <- CassandraGetData(idTransaction = Liste_tr[5], idSensor = Ray_D, timeStart = time_d[j,i], timeEnd = time_f[j,i])
      write.table(D_LP, "Diffus_La_Possession.txt", sep=";")
      D_LP <- read.table("Diffus_La_Possession.txt", sep=";")
      D_LP <- na.omit(object = D_LP)
      write.table(D_LP, "Diffus_La_Possession.txt", sep=";")
      
      setwd(dir = "~/Base de données")
      
    }
  }
}