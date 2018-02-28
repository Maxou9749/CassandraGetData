
#               Maxime ROUSSEAU
#     Operation sur la base de donnees
#                 21/02/2018

# ---- Definition des variables utilisees ----
jr_mois <- c(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
mois <- c("Janvier", "Fevrier", "Mars", "Avril", "Mai", "Juin", "Juillet", "Aout", "Septembre", "Octobre", "Novembre", "Decembre")
annee <- c("2012", "2013", "2014", "2015", "2016", "2017","2018")
Liste_lieu <- c("La Possession", "Moufia Bois de Nèfle", "Saint Andre", "Saint Leu", "Saint Pierre")
Abrv_lieu <- c("LP_G", "MBDN_G", "SA_G", "SL_G", "SP_G", "LP_D", "MBDN_D", "SA_D", "SL_D", "SP_D")
Donnees_LP_G <- 0
Donnees_MBDN_G <- 0
Donnees_SA_G <- 0
Donnees_SL_G <- 0
Donnees_SP_G <- 0
Donnees_LP_D <- 0
Donnees_MBDN_D <- 0
Donnees_SA_D <- 0
Donnees_SL_D <- 0
Donnees_SP_D <- 0


# ---- Creation des dossiers de stockage ----
setwd(dir = "~/Base de données")
dir.create(path = "Moyennes")
setwd(dir = "Moyennes")


# ---- Moyenne ----
setwd(dir = "~/Base de données/")

for (j in seq(1,12)) {
  for (i in seq(1,7)) {
    setwd(dir = annee[i])
    if (dir.exists(mois[j]) == FALSE) {} else {
      setwd(dir = mois[j])
      
      # Lecture des fichiers des mois de novembre de 2012 à 2018
      lecture_list_LP_G <- read.table(file = "Global_La_Possession.txt", sep = ";")
      lecture_list_MBDN_G <- read.table(file = "Global_Moufia_BDN.txt", sep = ";")
      lecture_list_SA_G <- read.table(file = "Global_Saint_Andre.txt", sep = ";")
      lecture_list_SL_G <- read.table(file = "Global_Saint_Leu.txt", sep = ";")
      lecture_list_SP_G <- read.table(file = "Global_Saint_Pierre.txt", sep = ";")
      lecture_list_LP_D <- read.table(file = "Diffus_La_Possession.txt", sep = ";")
      lecture_list_MBDN_D <- read.table(file = "Diffus_Moufia_BDN.txt", sep = ";")
      lecture_list_SA_D <- read.table(file = "Diffus_Saint_Andre.txt", sep = ";")
      lecture_list_SL_D <- read.table(file = "Diffus_Saint_Leu.txt", sep = ";")
      lecture_list_SP_D <- read.table(file = "Diffus_Saint_Pierre.txt", sep = ";")
      
      # Omission des valeurs de rayonnement en dessous d'un certain seuil
      for (i in seq(1,nrow(lecture_list_LP_G))) {if (lecture_list_LP_G[i,2] < 20) {lecture_list_LP_G[i,2] <- NA}}
        lecture_list_LP_G <- na.omit(lecture_list_LP_G)
      for (i in seq(1,nrow(lecture_list_MBDN_G))) {if (lecture_list_MBDN_G[i,2] < 20) {lecture_list_MBDN_G[i,2] <- NA}}
        lecture_list_MBDN_G <- na.omit(lecture_list_MBDN_G)
      for (i in seq(1,nrow(lecture_list_SA_G))) {if (lecture_list_SA_G[i,2] < 20) {lecture_list_SA_G[i,2] <- NA}}
        lecture_list_SA_G <- na.omit(lecture_list_SA_G)
      for (i in seq(1,nrow(lecture_list_SL_G))) {if (lecture_list_SL_G[i,2] < 20) {lecture_list_SL_G[i,2] <- NA}}
        lecture_list_SL_G <- na.omit(lecture_list_SL_G)
      for (i in seq(1,nrow(lecture_list_SP_G))) {if (lecture_list_SP_G[i,2] < 20) {lecture_list_SP_G[i,2] <- NA}}
        lecture_list_SP_G <- na.omit(lecture_list_SP_G)
      for (i in seq(1,nrow(lecture_list_LP_D))) {if (lecture_list_LP_D[i,2] < 20) {lecture_list_LP_D[i,2] <- NA}}
        lecture_list_LP_D <- na.omit(lecture_list_LP_D)
      for (i in seq(1,nrow(lecture_list_MBDN_D))) {if (lecture_list_MBDN_D[i,2] < 20) {lecture_list_MBDN_D[i,2] <- NA}}
        lecture_list_MBDN_D <- na.omit(lecture_list_MBDN_D)
      for (i in seq(1,nrow(lecture_list_SA_D))) {if (lecture_list_SA_D[i,2] < 20) {lecture_list_SA_D[i,2] <- NA}}
        lecture_list_SA_D <- na.omit(lecture_list_SA_D)
      for (i in seq(1,nrow(lecture_list_SL_D))) {if (lecture_list_SL_D[i,2] < 20) {lecture_list_SL_D[i,2] <- NA}}
        lecture_list_SL_D <- na.omit(lecture_list_SL_D)
      for (i in seq(1,nrow(lecture_list_SP_D))) {if (lecture_list_SP_D[i,2] < 20) {lecture_list_SP_D[i,2] <- NA}}
        lecture_list_SP_D <- na.omit(lecture_list_SP_D)
      
      # Moyenne
      moy_LP_G <- mean(x = lecture_list_LP_G$value)
      moy_MBDN_G <- mean(x = lecture_list_MBDN_G$value)
      moy_SA_G <- mean(x = lecture_list_SA_G$value)
      moy_SL_G <- mean(x = lecture_list_SL_G$value)
      moy_SP_G <- mean(x = lecture_list_SP_G$value)
      moy_LP_D <- mean(x = lecture_list_LP_D$value)
      moy_MBDN_D <- mean(x = lecture_list_MBDN_D$value)
      moy_SA_D <- mean(x = lecture_list_SA_D$value)
      moy_SL_D <- mean(x = lecture_list_SL_D$value)
      moy_SP_D <- mean(x = lecture_list_SP_D$value)
      
      # Ecriture dans un fichier externe
      setwd(dir = "~/Base de données/Moyennes")
      Moy_G <- c(moy_LP_G, moy_MBDN_G, moy_SA_G, moy_SL_G, moy_SP_G)
      Moy_D <- c(moy_LP_D, moy_MBDN_D, moy_SA_D, moy_SL_D, moy_SP_D)
      Moy_G <- as.data.frame(x = Moy_G)
      Moy_D <- as.data.frame(x = Moy_D)
      fusion <- c(Moy_G, Moy_D)
      write.table(x = fusion, file = paste("Moy_Ray_Global_", mois[j], ".txt", sep = ""), col.names = TRUE)
      
    }
    setwd(dir = "~/Base de données/")
  }
  # Remise à zero des variables utilisees
  Donnees_LP_G <- 0
  Donnees_MBDN_G <- 0
  Donnees_SA_G <- 0
  Donnees_SL_G <- 0
  Donnees_SP_G <- 0
  Donnees_LP_D <- 0
  Donnees_MBDN_D <- 0
  Donnees_SA_D <- 0
  Donnees_SL_D <- 0
  Donnees_SP_D <- 0
  Moy_G <- 0
  Moy_D <- 0
}