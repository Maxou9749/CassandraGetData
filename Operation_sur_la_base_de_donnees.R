
#               Maxime ROUSSEAU
#     Operation sur la base de donnees
#                 21/02/2018

library(suncalc)
library(lubridate)

heure_lim_inf <- 6
heure_lim_sup <- 20

# ---- Definition des variables utilisees ----
L <- -21.06          # Latitude
l <- 55.31           # Longitude
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


# ---- Operations sur la base de donnees ----
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
      
      
      
      # Mise en place de la verif pour chaque jour
      date_prec <- as.Date(substr(x = lecture_list_LP_G$date[1], 1, 10))
      k = 1
      sunrise <- 0
      sunset <- 0
      Sun_Time <- getSunlightTimes(date = date_prec, lat = L, lon = l, keep = c("sunrise", "sunset"))
      sunrise[1] <- as.character(Sun_Time$sunrise + 4 * 3600)
      sunset[1] <- as.character(Sun_Time$sunset + 4 * 3600)
      repeat{
        repeat{
          date_suiv <- as.Date(substr(x = lecture_list_LP_G$date[k], 1, 10))
          if (date_prec < date_suiv) {
            date_prec <- date_suiv
            Sun_Time <- getSunlightTimes(date = date_prec, lat = L, lon = l, keep = c("sunrise", "sunset"))
            sunrise[k] <- as.character(Sun_Time$sunrise + 4 * 3600)
            sunset[k] <- as.character(Sun_Time$sunset + 4 * 3600)
            break()
          }
          k <- k + 1
        }
      }
      sunrise <- na.omit(object = sunrise)
      sunset <- na.omit(object = sunset)
      k <- k - 1 # Enlever la dernière itération de STOP auto
      for (l in seq(1, jr_mois[j])) {
        
      }
      
      
      
      
      
      
      
      # Omission des valeurs de rayonnement en fonction de l'heure du lever et coucher du soleil
      
      for (k in seq(1,nrow(lecture_list_LP_G))) {
        A <- as.numeric(substring(lecture_list_LP_G$date[k], 12, 13))
        if ((A > heure_lim_sup) || (A < heure_lim_inf)) {
          lecture_list_LP_G$date[k] <- NA
          lecture_list_LP_G$value[k] <- NA
        }
      }
      omit_list_LP_G <- na.omit(lecture_list_LP_G$value)
      
      for (k in seq(1,nrow(lecture_list_MBDN_G))) {
        A <- as.numeric(substring(lecture_list_MBDN_G$date[k], 12, 13))
        if ((A > heure_lim_sup) || (A < heure_lim_inf)) {
          lecture_list_MBDN_G$date[k] <- NA
          lecture_list_MBDN_G$value[k] <- NA
        }
      }
      omit_list_MBDN_G <- na.omit(lecture_list_MBDN_G$value)
      
      for (k in seq(1,nrow(lecture_list_SA_G))) {
        A <- as.numeric(substring(lecture_list_SA_G$date[k], 12, 13))
        if ((A > heure_lim_sup) || (A < heure_lim_inf)) {
          lecture_list_SA_G$date[k] <- NA
          lecture_list_SA_G$value[k] <- NA
        }
      }
      omit_list_SA_G <- na.omit(lecture_list_SA_G$value)
      
      for (k in seq(1,nrow(lecture_list_SL_G))) {
        A <- as.numeric(substring(lecture_list_SL_G$date[k], 12, 13))
        if ((A > heure_lim_sup) || (A < heure_lim_inf)) {
          lecture_list_SL_G$date[k] <- NA
          lecture_list_SL_G$value[k] <- NA
        }
      }
      omit_list_SL_G <- na.omit(lecture_list_SL_G$value)
      
      for (k in seq(1,nrow(lecture_list_SP_G))) {
        A <- as.numeric(substring(lecture_list_SP_G$date[k], 12, 13))
        if ((A > heure_lim_sup) || (A < heure_lim_inf)) {
          lecture_list_SP_G$date[k] <- NA
          lecture_list_SP_G$value[k] <- NA
        }
      }
      omit_list_SP_G <- na.omit(lecture_list_SP_G$value)
      
      for (k in seq(1,nrow(lecture_list_LP_D))) {
        A <- as.numeric(substring(lecture_list_LP_D$date[k], 12, 13))
        if ((A > heure_lim_sup) || (A < heure_lim_inf)) {
          lecture_list_LP_D$date[k] <- NA
          lecture_list_LP_D$value[k] <- NA
        }
      }
      omit_list_LP_D <- na.omit(lecture_list_LP_D$value)
      
      for (k in seq(1,nrow(lecture_list_MBDN_D))) {
        A <- as.numeric(substring(lecture_list_MBDN_D$date[k], 12, 13))
        if ((A > heure_lim_sup) || (A < heure_lim_inf)) {
          lecture_list_MBDN_D$date[k] <- NA
          lecture_list_MBDN_D$value[k] <- NA
        }
      }
      omit_list_MBDN_D <- na.omit(lecture_list_MBDN_D$value)
      
      for (k in seq(1,nrow(lecture_list_SA_D))) {
        A <- as.numeric(substring(lecture_list_SA_D$date[k], 12, 13))
        if ((A > heure_lim_sup) || (A < heure_lim_inf)) {
          lecture_list_SA_D$date[k] <- NA
          lecture_list_SA_D$value[k] <- NA
        }
      }
      omit_list_SA_D <- na.omit(lecture_list_SA_D$value)
      
      for (k in seq(1,nrow(lecture_list_SL_D))) {
        A <- as.numeric(substring(lecture_list_SL_D$date[k], 12, 13))
        if ((A > heure_lim_sup) || (A < heure_lim_inf)) {
          lecture_list_SL_D$date[k] <- NA
          lecture_list_SL_D$value[k] <- NA
        }
      }
      omit_list_SL_D <- na.omit(lecture_list_SL_D$value)
      
      for (k in seq(1,nrow(lecture_list_SP_D))) {
        A <- as.numeric(substring(lecture_list_SP_D$date[k], 12, 13))
        if ((A > heure_lim_sup) || (A < heure_lim_inf)) {
          lecture_list_SP_D$date[k] <- NA
          lecture_list_SP_D$value[k] <- NA
        }
      }
      omit_list_SP_D <- na.omit(lecture_list_SP_D$value)
      
      # Mémoire (accumulation des informations dans une variable)
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
      
      setwd(dir = "~/Base de données/")
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
  
  # Ecart-type
  ET_LP_G <- sd(x = list_LP_G)
  ET_MBDN_G <- sd(x = list_MBDN_G)
  ET_SA_G <- sd(x = list_SA_G)
  ET_SL_G <- sd(x = list_SL_G)
  ET_SP_G <- sd(x = list_SP_G)
  ET_LP_D <- sd(x = list_LP_D)
  ET_MBDN_D <- sd(x = list_MBDN_D)
  ET_SA_D <- sd(x = list_SA_D)
  ET_SL_D <- sd(x = list_SL_D)
  ET_SP_D <- sd(x = list_SP_D)
  
  # Valeur min et max
  min_LP_G <- min(x = list_LP_G)
  min_MBDN_G <- min(x = list_MBDN_G)
  min_SA_G <- min(x = list_SA_G)
  min_SL_G <- min(x = list_SL_G)
  min_SP_G <- min(x = list_SP_G)
  min_LP_D <- min(x = list_LP_D)
  min_MBDN_D <- min(x = list_MBDN_D)
  min_SA_D <- min(x = list_SA_D)
  min_SL_D <- min(x = list_SL_D)
  min_SP_D <- min(x = list_SP_D)
  max_LP_G <- max(x = list_LP_G)
  max_MBDN_G <- max(x = list_MBDN_G)
  max_SA_G <- max(x = list_SA_G)
  max_SL_G <- max(x = list_SL_G)
  max_SP_G <- max(x = list_SP_G)
  max_LP_D <- max(x = list_LP_D)
  max_MBDN_D <- max(x = list_MBDN_D)
  max_SA_D <- max(x = list_SA_D)
  max_SL_D <- max(x = list_SL_D)
  max_SP_D <- max(x = list_SP_D)
  
  # Ecriture dans un fichier externe
  # Moyenne
  setwd(dir = "~/Base de données/Moyennes")
  Moy_G <- as.data.frame(x =c(moy_LP_G, moy_MBDN_G, moy_SA_G, moy_SL_G, moy_SP_G))
  Moy_D <- as.data.frame(x =c(moy_LP_D, moy_MBDN_D, moy_SA_D, moy_SL_D, moy_SP_D))
  fusion_1 <- c(Moy_G, Moy_D)
  write.table(x = fusion_1, file = paste("Moy_Ray_G_D", mois[j], ".txt", sep = ""), col.names = TRUE)
  # Ecart-type, min et max
  LP <- as.data.frame(x = c(min_LP_G, ET_LP_G, max_LP_G, min_LP_D, ET_LP_D, max_LP_D))
  MBDN <- as.data.frame(x = c(min_MBDN_G, ET_MBDN_G, max_MBDN_G, min_MBDN_D, ET_MBDN_D, max_MBDN_D))
  SA <- as.data.frame(x = c(min_SA_G, ET_SA_G, max_SA_G, min_SA_D, ET_SA_D, max_SA_D))
  SL <- as.data.frame(x = c(min_SL_G, ET_SL_G, max_SL_G, min_SL_D, ET_SL_D, max_SL_D))
  SP <- as.data.frame(x = c(min_SP_G, ET_SP_G, max_SP_G, min_SP_D, ET_SP_D, max_SP_D))
  fusion_2 <- c(LP, MBDN, SA, SL, SP)
  write.table(x = fusion_2, file = paste("Min_Ecart-type_max_G_D", mois[j], ".txt", sep = ""), col.names = TRUE)
  
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
  setwd(dir = "~/Base de données/")
}
