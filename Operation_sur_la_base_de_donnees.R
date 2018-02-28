
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
list_LP_G <- 0
list_MBDN_G <- 0
list_SA_G <- 0
list_SL_G <- 0
list_SP_G <- 0
list_LP_D <- 0
list_MBDN_D <- 0
list_SA_D <- 0
list_SL_D <- 0
list_SP_D <- 0



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
      for (k in seq(1,nrow(lecture_list_LP_G))) {if (lecture_list_LP_G$value[k] < 20) {lecture_list_LP_G$value[k] <- NA}}
      omit_list_LP_G <- na.omit(lecture_list_LP_G$value)
      for (l in seq(1,nrow(lecture_list_MBDN_G))) {if (lecture_list_MBDN_G$value[l] < 20) {lecture_list_MBDN_G$value[l] <- NA}}
      omit_list_MBDN_G <- na.omit(lecture_list_MBDN_G$value)
      for (m in seq(1,nrow(lecture_list_SA_G))) {if (lecture_list_SA_G$value[m] < 20) {lecture_list_SA_G$value[m] <- NA}}
      omit_list_SA_G <- na.omit(lecture_list_SA_G$value)
      for (n in seq(1,nrow(lecture_list_SL_G))) {if (lecture_list_SL_G$value[n] < 20) {lecture_list_SL_G$value[n] <- NA}}
      omit_list_SL_G <- na.omit(lecture_list_SL_G$value)
      for (o in seq(1,nrow(lecture_list_SP_G))) {if (lecture_list_SP_G$value[o] < 20) {lecture_list_SP_G$value[o] <- NA}}
      omit_list_SP_G <- na.omit(lecture_list_SP_G$value)
      for (p in seq(1,nrow(lecture_list_LP_D))) {if (lecture_list_LP_D$value[p] < 20) {lecture_list_LP_D$value[p] <- NA}}
      omit_list_LP_D <- na.omit(lecture_list_LP_D$value)
      for (q in seq(1,nrow(lecture_list_MBDN_D))) {if (lecture_list_MBDN_D$value[q] < 20) {lecture_list_MBDN_D$value[q] <- NA}}
      omit_list_MBDN_D <- na.omit(lecture_list_MBDN_D$value)
      for (r in seq(1,nrow(lecture_list_SA_D))) {if (lecture_list_SA_D$value[r] < 20) {lecture_list_SA_D$value[r] <- NA}}
      omit_list_SA_D <- na.omit(lecture_list_SA_D$value)
      for (s in seq(1,nrow(lecture_list_SL_D))) {if (lecture_list_SL_D$value[s] < 20) {lecture_list_SL_D$value[s] <- NA}}
      omit_list_SL_D <- na.omit(lecture_list_SL_D$value)
      for (t in seq(1,nrow(lecture_list_SP_D))) {if (lecture_list_SP_D$value[t] < 20) {lecture_list_SP_D$value[t] <- NA}}
      omit_list_SP_D <- na.omit(lecture_list_SP_D$value)
      
      # Mémoire
      list_LP_G <- c(list_LP_G, omit_list_LP_G)
      list_MBDN_G <- c(list_MBDN_G,omit_list_MBDN_G)
      list_SA_G <- c(list_SA_G,omit_list_SA_G)
      list_SL_G <- c(list_SL_G,omit_list_SL_G)
      list_SP_G <- c(list_SP_G,omit_list_SP_G)
      list_LP_D <- c(list_LP_D,omit_list_LP_D)
      list_MBDN_D <- c(list_MBDN_D,omit_list_MBDN_D)
      list_SA_D <- c(list_SA_D,omit_list_SA_D)
      list_SL_D <- c(list_SL_D,omit_list_SL_D)
      list_SP_D <- c(list_SP_D,omit_list_SP_D)
    }
    setwd(dir = "~/Base de données/")
  }
  # Moyenne
  moy_LP_G <- mean(x = list_LP_G)
  moy_MBDN_G <- mean(x = list_MBDN_G)
  moy_SA_G <- mean(x = list_SA_G)
  moy_SL_G <- mean(x = list_SL_G)
  moy_SP_G <- mean(x = list_SP_G)
  moy_LP_D <- mean(x = list_LP_D)
  moy_MBDN_D <- mean(x = list_MBDN_D)
  moy_SA_D <- mean(x = list_SA_D)
  moy_SL_D <- mean(x = list_SL_D)
  moy_SP_D <- mean(x = list_SP_D)
  
  # Ecriture dans un fichier externe
  setwd(dir = "~/Base de données/Moyennes")
  Moy_G <- c(moy_LP_G, moy_MBDN_G, moy_SA_G, moy_SL_G, moy_SP_G)
  Moy_D <- c(moy_LP_D, moy_MBDN_D, moy_SA_D, moy_SL_D, moy_SP_D)
  Moy_G <- as.data.frame(x = Moy_G)
  Moy_D <- as.data.frame(x = Moy_D)
  fusion <- c(Moy_G, Moy_D)
  write.table(x = fusion, file = paste("Moy_Ray_Global_", mois[j], ".txt", sep = ""), col.names = TRUE)
  
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
  list_LP_G <- 0
  list_MBDN_G <- 0
  list_SA_G <- 0
  list_SL_G <- 0
  list_SP_G <- 0
  list_LP_D <- 0
  list_MBDN_D <- 0
  list_SA_D <- 0
  list_SL_D <- 0
  list_SP_D <- 0
}
