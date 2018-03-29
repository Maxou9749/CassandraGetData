
#                               Maxime ROUSSEAU
#     Recuperation des donnees de rayonnement solaire (Global et Diffus) sur 5 ans
#                                 21/02/2018


# ---- Chargement de la library rLE2P ----
library(rLE2P)


# ---- Definition des variables utilisees ----
Ray_G <- c("FG", "FG_Avg","GHI_014_Avg")
Ray_D <- c("FD", "FD_Avg","DHI_014_Avg")

Moufia_UR <- "1487856319"

jr_mois <- c(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
mois <- c("Janvier", "Fevrier", "Mars", "Avril", "Mai", "Juin", "Juillet", "Aout", "Septembre", "Octobre", "Novembre", "Decembre")
annee <- c("2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017","2018")


# ---- Création de la matrice de temps de debut et de fin ----
time_d <- matrix(nrow = 12, ncol = 10)
time_f <- matrix(nrow = 12, ncol = 10)

for (j in seq(2009,2018)) {
  for (i in seq(1,12)) {
    moi <- i
    an <- j
    if (moi < 10) {moi <- paste(0, moi, sep ="")} else {moi <- paste(moi)}
    date_d <- paste(an, moi, "01", sep = "-")
    date_d <- paste(date_d, "00:00:00", sep = " ")
    jour <- jr_mois[i]
    date_f <- paste(an, moi, as.character(jour), sep = "-")
    date_f <- paste(date_f,"23:59:00", sep = " ")
    time_d[i,j-2008] <- date_d
    time_f[i,j-2008] <- date_f
  }
}


# ---- Création des dossiers ----
setwd(dir = "~")
dir.create("Base de données")
setwd(dir = "Base de données")
dir.create("2009")
dir.create("2010")
dir.create("2011")
dir.create("2012")
dir.create("2013")
dir.create("2014")
dir.create("2015")
dir.create("2016")
dir.create("2017")
dir.create("2018")

for (j in seq(1,7)) {
  setwd(dir = "~/Base de données")
  setwd(dir = annee[j])
  for (i in seq(1,12)) {
    dir.create(mois[i])
  }
}

setwd(dir = "~/Base de données/2016")
for (i in seq(1,9)) {
  dir.create(mois[i])
}
setwd(dir = "~/Base de données/2017")
for (i in seq(7,12)) {
  dir.create(mois[i])
}
setwd(dir = "~/Base de données/2018")
dir.create(mois[1])
setwd(dir = "~/Base de données")


# ---- Recuperation des donnees 2009 à 2012 ----
for (j in seq(1,12)) {
  for (i in seq(1,4)) {
    setwd(dir = "~/Base de données")
    setwd(dir = annee[i])
    # Si le mois n'existe pas, passer au mois suivant etc .
    if (dir.exists(mois[j]) == FALSE) {} else {
      setwd(dir = mois[j])
      # ---- Global ----
      
      G_MUR <- CassandraGetData(idTransaction = Moufia_UR, idSensor = Ray_G[1], timeStart = time_d[j,i], timeEnd = time_f[j,i])
      write.table(G_MUR, "Global_Moufia_UR.txt", sep=";")
      G_MUR <- read.table("Global_Moufia_UR.txt", sep=";")
      G_MUR <- na.omit(object = G_MUR)
      write.table(G_MUR, "Global_Moufia_UR.txt", sep=";")
      
      # ---- Diffus ----
      D_MUR <- CassandraGetData(idTransaction = Moufia_UR, idSensor = Ray_D[1], timeStart = time_d[j,i], timeEnd = time_f[j,i])
      write.table(D_MUR, "Diffus_Moufia_UR.txt", sep=";")
      D_MUR <- read.table("Diffus_Moufia_UR.txt", sep=";")
      D_MUR <- na.omit(object = D_MUR)
      write.table(D_MUR, "Diffus_Moufia_UR.txt", sep=";")
      
      setwd(dir = "~/Base de données")
      
    }
  }
}
# ---- Recuperation des donnees 2013 à 2016 ----
for (j in seq(1,12)) {
  for (i in seq(5,8)) {
    setwd(dir = "~/Base de données")
    setwd(dir = annee[i])
    # Si le mois n'existe pas, passer au mois suivant etc .
    if (dir.exists(mois[j]) == FALSE) {} else {
      setwd(dir = mois[j])
      # ---- Global ----
      
      G_MUR <- CassandraGetData(idTransaction = Moufia_UR, idSensor = Ray_G[2], timeStart = time_d[j,i], timeEnd = time_f[j,i])
      write.table(G_MUR, "Global_Moufia_UR.txt", sep=";")
      G_MUR <- read.table("Global_Moufia_UR.txt", sep=";")
      G_MUR <- na.omit(object = G_MUR)
      write.table(G_MUR, "Global_Moufia_UR.txt", sep=";")
      
      # ---- Diffus ----
      D_MUR <- CassandraGetData(idTransaction = Moufia_UR, idSensor = Ray_D[2], timeStart = time_d[j,i], timeEnd = time_f[j,i])
      write.table(D_MUR, "Diffus_Moufia_UR.txt", sep=";")
      D_MUR <- read.table("Diffus_Moufia_UR.txt", sep=";")
      D_MUR <- na.omit(object = D_MUR)
      write.table(D_MUR, "Diffus_Moufia_UR.txt", sep=";")
      
      setwd(dir = "~/Base de données")
      
    }
  }
}
# ---- Recuperation des donnees 2017 à 2018 ----
for (j in seq(1,12)) {
  for (i in seq(9,10)) {
    setwd(dir = "~/Base de données")
    setwd(dir = annee[i])
    # Si le mois n'existe pas, passer au mois suivant etc .
    if (dir.exists(mois[j]) == FALSE) {} else {
      setwd(dir = mois[j])
      # ---- Global ----
      
      G_MUR <- CassandraGetData(idTransaction = Moufia_UR, idSensor = Ray_G[3], timeStart = time_d[j,i], timeEnd = time_f[j,i])
      write.table(G_MUR, "Global_Moufia_UR.txt", sep=";")
      G_MUR <- read.table("Global_Moufia_UR.txt", sep=";")
      G_MUR <- na.omit(object = G_MUR)
      write.table(G_MUR, "Global_Moufia_UR.txt", sep=";")
      
      # ---- Diffus ----
      D_MUR <- CassandraGetData(idTransaction = Moufia_UR, idSensor = Ray_D[3], timeStart = time_d[j,i], timeEnd = time_f[j,i])
      write.table(D_MUR, "Diffus_Moufia_UR.txt", sep=";")
      D_MUR <- read.table("Diffus_Moufia_UR.txt", sep=";")
      D_MUR <- na.omit(object = D_MUR)
      write.table(D_MUR, "Diffus_Moufia_UR.txt", sep=";")
      
      setwd(dir = "~/Base de données")
      
    }
  }
}