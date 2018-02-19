jr_mois <- c(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
mois <- c("Janvier", "Fevrier", "Mars", "Avril", "Mai", "Juin", "Juillet", "Aout", "Septembre", "Octobre", "Novembre", "Decembre")
annee <- c("2012", "2013", "2014", "2015", "2016", "2017")

# Création des dossiers
setwd(dir = "~")
dir.create("Base de données")
setwd(dir = "Base de données")
dir.create("2012")
dir.create("2013")
dir.create("2014")
dir.create("2015")
dir.create("2016")
dir.create("2017")

for (j in seq(1,6)) {
  setwd(dir = "~/Base de données")
  setwd(dir = annee[j])
  for (i in seq(1,12)) {
    dir.create(mois[i])
  }
}
setwd(dir = "~/Base de données")

# Recuperation des donnees et mise dans leur dossier respectifs
for (j in seq(1,12)) {
  date_debut <- c("2012-12-01 00:01:00", "2013-12-01 00:01:00", "2014-12-01 00:01:00", "2015-12-01 00:01:00", "2016-12-01 00:01:00", "2017-12-01 00:01:00")
  date_fin <- c("2012-12-31 23:59:00", "2013-12-31 23:59:00", "2014-12-31 23:59:00", "2015-12-31 23:59:00", "2016-12-31 23:59:00", "2017-12-31 23:59:00")
  for (i in seq(1,6)) {
    # Global
    setwd(dir = annee[i])
    G_SL <- CassandraGetData(idTransaction = Liste_tr[1], idSensor = Ray_G, timeStart = date_debut[i], timeEnd = date_fin[i])
    write.table(G_SL, "Global_Saint_Leu.txt", sep=";")
    G_SL <- read.table("Global_Saint_Leu.txt", sep=";")
    G_SL <- na.omit(object = G_SL)
    write.table(G_SL, "Global_Saint_Leu.txt", sep=";")
    
    G_SA <- CassandraGetData(idTransaction = Liste_tr[2], idSensor = Ray_G, timeStart = date_debut[i], timeEnd = date_fin[i])
    write.table(G_SA, "Global_Saint_Andre.txt", sep=";")
    G_SA <- read.table("Global_Saint_Andre.txt", sep=";")
    G_SA <- na.omit(object = G_SA)
    write.table(G_SA, "Global_Saint_Andre.txt", sep=";")
    
    G_SP <- CassandraGetData(idTransaction = Liste_tr[3], idSensor = Ray_G, timeStart = date_debut[i], timeEnd = date_fin[i])
    write.table(G_SP, "Global_Saint_Pierre.txt", sep=";")
    G_SP <- read.table("Global_Saint_Leu.txt", sep=";")
    G_SP <- na.omit(object = G_SP)
    write.table(G_SP, "Global_Saint_Pierre.txt", sep=";")
    
    G_MBDN <- CassandraGetData(idTransaction = Liste_tr[4], idSensor = Ray_G, timeStart = date_debut[i], timeEnd = date_fin[i])
    write.table(G_MBDN, "Global_Moufia_BDN.txt", sep=";")
    G_MBDN <- read.table("Global_Saint_Leu.txt", sep=";")
    G_MBDN <- na.omit(object = G_MBDN)
    write.table(G_MBDN, "Global_Moufia_BDN.txt", sep=";")
    
    G_LP <- CassandraGetData(idTransaction = Liste_tr[5], idSensor = Ray_G, timeStart = date_debut[i], timeEnd = date_fin[i])
    write.table(G_LP, "Global_La_Possession.txt", sep=";")
    G_LP <- read.table("Global_Saint_Leu.txt", sep=";")
    G_LP <- na.omit(object = G_LP)
    write.table(G_LP, "Global_La_Possession.txt", sep=";")
    
    # Diffus
    D_SL <- CassandraGetData(idTransaction = Liste_tr[1], idSensor = Ray_D, timeStart = date_debut[i], timeEnd = date_fin[i])
    write.table(D_SL, "Diffus_Saint_Leu.txt", sep=";")
    D_SL <- read.table("Diffus_Saint_Leu.txt", sep=";")
    D_SL <- na.omit(object = D_SL)
    write.table(D_SL, "Diffus_Saint_Leu.txt", sep=";")
    
    D_SA <- CassandraGetData(idTransaction = Liste_tr[2], idSensor = Ray_D, timeStart = date_debut[i], timeEnd = date_fin[i])
    write.table(D_SA, "Diffus_Saint_Andre.txt", sep=";")
    D_SA <- read.table("Diffus_Saint_Andre.txt", sep=";")
    D_SA <- na.omit(object = D_SA)
    write.table(D_SA, "Diffus_Saint_Andre.txt", sep=";")
    
    D_SP <- CassandraGetData(idTransaction = Liste_tr[3], idSensor = Ray_D, timeStart = date_debut[i], timeEnd = date_fin[i])
    write.table(D_SP, "Diffus_Saint_Pierre.txt", sep=";")
    D_SP <- read.table("Diffus_Saint_Leu.txt", sep=";")
    D_SP <- na.omit(object = D_SP)
    write.table(D_SP, "Diffus_Saint_Pierre.txt", sep=";")
    
    D_MBDN <- CassandraGetData(idTransaction = Liste_tr[4], idSensor = Ray_D, timeStart = date_debut[i], timeEnd = date_fin[i])
    write.table(D_MBDN, "Diffus_Moufia_BDN.txt", sep=";")
    D_MBDN <- read.table("Diffus_Saint_Leu.txt", sep=";")
    D_MBDN <- na.omit(object = D_MBDN)
    write.table(D_MBDN, "Diffus_Moufia_BDN.txt", sep=";")
    
    D_LP <- CassandraGetData(idTransaction = Liste_tr[5], idSensor = Ray_D, timeStart = date_debut[i], timeEnd = date_fin[i])
    write.table(D_LP, "Diffus_La_Possession.txt", sep=";")
    D_LP <- read.table("Diffus_Saint_Leu.txt", sep=";")
    D_LP <- na.omit(object = D_LP)
    write.table(D_LP, "Diffus_La_Possession.txt", sep=";")
    
    setwd(dir = "~/Base de données")
  }
}
