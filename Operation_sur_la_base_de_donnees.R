
#               Maxime ROUSSEAU
#     Operation sur la base de donnees
#                 16/03/2018

# ---- Chargement des librairies ----
library(suncalc)
library(lubridate)


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
dir.create(path = "Opérations")
setwd(dir = "Opérations")


# ---- Operations sur la base de donnees ----
setwd(dir = "~/Base de données/")

for (j in seq(1,12)) {
  for (i in seq(1,7)) {
    setwd(dir = annee[i])
    if (dir.exists(mois[j]) == FALSE) {} else {
      setwd(dir = mois[j])
      # ---- Lecture des fichiers de donnees du mois et de l'annee correspondant ----
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
      
      
      # ---- Omission des valeurs de rayonnement en fonction de l'heure du lever et coucher du soleil ----
      # ---- La Possession ----
        # ---- Global ----
      # Initialisation des variables
      sunrise <- 0
      sunset <- 0
      save_k <- 1
      # Initialisation de la premiere date
      date_prec <- as.Date(substr(x = lecture_list_LP_G$date[1], 1, 10))
      k = 1
      # Calcul de l'heure de lever (sunrise) et coucher (sunset) du soleil
      Sun_Time <- getSunlightTimes(date = date_prec, lat = L, lon = l, keep = c("sunrise", "sunset"))
      # Ajout de (4 * 3600), car nous sommes à UTC+04
      sunrise[1] <- as.character(Sun_Time$sunrise + 4 * 3600)
      sunset[1] <- as.character(Sun_Time$sunset + 4 * 3600)
      # Tant qu'on ne change pas de jour ne rien faire sinon stocker la valeur k, sunset et sunrise
      repeat{
        date_suiv <- as.Date(substr(x = lecture_list_LP_G$date[k], 1, 10))
        if (date_prec < date_suiv) {
          date_prec <- date_suiv
          # Calcul de l'heure de lever (sunrise) et coucher (sunset) du soleil
          Sun_Time <- getSunlightTimes(date = date_prec, lat = L, lon = l, keep = c("sunrise", "sunset"))
          # Ajout de (4 * 3600), car nous sommes à UTC+04
          sunrise[k] <- as.character(Sun_Time$sunrise + 4 * 3600)
          # Ajout de (4 * 3600), car nous sommes à UTC+04
          sunset[k] <- as.character(Sun_Time$sunset + 4 * 3600)
          # Stockage de la variable k (representation du changement de jour)
          save_k[k] <- k
          if (date_prec == paste(annee[i], "-", mois_ch[j], "-", jr_mois[j], sep = "")) {break()}
        }
        k <- k + 1
      }
      # Suppression des NA
      save_k <- na.omit(save_k)
      sunrise <- na.omit(object = sunrise)
      sunset <- na.omit(object = sunset)
      # Enlever la dernière itération de STOP auto (cette boucle s'arrete d'elle même mais applique "k <- k + 1" avant)
      k <- k - 1 
      # Balayage des heures de toutes la journee de tous les jours (-1) pour eliminer les heures et valeurs en dehors des heures ou le soleil n'est plus
      for (m in seq(2,length(save_k))) {
        for (o in seq(save_k[m-1],save_k[m]-1)) {
          verif <- as.character(lecture_list_LP_G$date[o])
          if (is.na(verif) == TRUE) {break()}
          if ((verif < sunrise[m-1]) || (verif > sunset[m-1])) {
            lecture_list_LP_G$date[o] <- NA
            lecture_list_LP_G$value[o] <- NA
          }
        }
      }
      for (o in seq(save_k[m],length(lecture_list_LP_G$value))) {
        verif <- as.character(lecture_list_LP_G$date[o])
        if (is.na(verif) == TRUE) {break()}
        if ((verif < sunrise[m]) || (verif > sunset[m])) {
          lecture_list_LP_G$date[o] <- NA
          lecture_list_LP_G$value[o] <- NA
        }
      }
      # Elimination des NA pour avoir un stockage propre
      lecture_list_LP_G <- na.omit(lecture_list_LP_G)
      
        # ---- Diffus ----
      # Initialisation des variables
      sunrise <- 0
      sunset <- 0
      save_k <- 1
      # Initialisation de la premiere date
      date_prec <- as.Date(substr(x = lecture_list_LP_D$date[1], 1, 10))
      k = 1
      # Calcul de l'heure de lever (sunrise) et coucher (sunset) du soleil
      Sun_Time <- getSunlightTimes(date = date_prec, lat = L, lon = l, keep = c("sunrise", "sunset"))
      # Ajout de (4 * 3600), car nous sommes à UTC+04
      sunrise[1] <- as.character(Sun_Time$sunrise + 4 * 3600)
      sunset[1] <- as.character(Sun_Time$sunset + 4 * 3600)
      # Tant qu'on ne change pas de jour ne rien faire sinon stocker la valeur k, sunset et sunrise
      repeat{
        date_suiv <- as.Date(substr(x = lecture_list_LP_D$date[k], 1, 10))
        if (date_prec < date_suiv) {
          date_prec <- date_suiv
          # Calcul de l'heure de lever (sunrise) et coucher (sunset) du soleil
          Sun_Time <- getSunlightTimes(date = date_prec, lat = L, lon = l, keep = c("sunrise", "sunset"))
          # Ajout de (4 * 3600), car nous sommes à UTC+04
          sunrise[k] <- as.character(Sun_Time$sunrise + 4 * 3600)
          # Ajout de (4 * 3600), car nous sommes à UTC+04
          sunset[k] <- as.character(Sun_Time$sunset + 4 * 3600)
          # Stockage de la variable k (representation du changement de jour)
          save_k[k] <- k
          if (date_prec == paste(annee[i], "-", mois_ch[j], "-", jr_mois[j], sep = "")) {break()}
        }
        k <- k + 1
      }
      # Suppression des NA
      save_k <- na.omit(save_k)
      sunrise <- na.omit(object = sunrise)
      sunset <- na.omit(object = sunset)
      # Enlever la dernière itération de STOP auto (cette boucle s'arrete d'elle même mais applique "k <- k + 1" avant)
      k <- k - 1 
      # Balayage des heures de toutes la journee de tous les jours (-1) pour eliminer les heures et valeurs en dehors des heures ou le soleil n'est plus
      for (m in seq(2,length(save_k))) {
        for (o in seq(save_k[m-1],save_k[m]-1)) {
          verif <- as.character(lecture_list_LP_D$date[o])
          if (is.na(verif) == TRUE) {break()}
          if ((verif < sunrise[m-1]) || (verif > sunset[m-1])) {
            lecture_list_LP_D$date[o] <- NA
            lecture_list_LP_D$value[o] <- NA
          }
        }
      }
      for (o in seq(save_k[m],length(lecture_list_LP_D$value))) {
        verif <- as.character(lecture_list_LP_D$date[o])
        if (is.na(verif) == TRUE) {break()}
        if ((verif < sunrise[m]) || (verif > sunset[m])) {
          lecture_list_LP_D$date[o] <- NA
          lecture_list_LP_D$value[o] <- NA
        }
      }
      # Elimination des NA pour avoir un stockage propre
      lecture_list_LP_D <- na.omit(lecture_list_LP_D)
      
      # ---- Moufia Bois de Nefle ----
        # ---- Global ----
      # Initialisation des variables
      sunrise <- 0
      sunset <- 0
      save_k <- 1
      # Initialisation de la premiere date
      date_prec <- as.Date(substr(x = lecture_list_MBDN_G$date[1], 1, 10))
      k = 1
      # Calcul de l'heure de lever (sunrise) et coucher (sunset) du soleil
      Sun_Time <- getSunlightTimes(date = date_prec, lat = L, lon = l, keep = c("sunrise", "sunset"))
      # Ajout de (4 * 3600), car nous sommes à UTC+04
      sunrise[1] <- as.character(Sun_Time$sunrise + 4 * 3600)
      sunset[1] <- as.character(Sun_Time$sunset + 4 * 3600)
      # Tant qu'on ne change pas de jour ne rien faire sinon stocker la valeur k, sunset et sunrise
      repeat{
        date_suiv <- as.Date(substr(x = lecture_list_MBDN_G$date[k], 1, 10))
        if (date_prec < date_suiv) {
          date_prec <- date_suiv
          # Calcul de l'heure de lever (sunrise) et coucher (sunset) du soleil
          Sun_Time <- getSunlightTimes(date = date_prec, lat = L, lon = l, keep = c("sunrise", "sunset"))
          # Ajout de (4 * 3600), car nous sommes à UTC+04
          sunrise[k] <- as.character(Sun_Time$sunrise + 4 * 3600)
          # Ajout de (4 * 3600), car nous sommes à UTC+04
          sunset[k] <- as.character(Sun_Time$sunset + 4 * 3600)
          # Stockage de la variable k (representation du changement de jour)
          save_k[k] <- k
          if (date_prec == paste(annee[i], "-", mois_ch[j], "-", jr_mois[j], sep = "")) {break()}
        }
        k <- k + 1
      }
      # Suppression des NA
      save_k <- na.omit(save_k)
      sunrise <- na.omit(object = sunrise)
      sunset <- na.omit(object = sunset)
      # Enlever la dernière itération de STOP auto (cette boucle s'arrete d'elle même mais applique "k <- k + 1" avant)
      k <- k - 1 
      # Balayage des heures de toutes la journee de tous les jours (-1) pour eliminer les heures et valeurs en dehors des heures ou le soleil n'est plus
      for (m in seq(2,length(save_k))) {
        for (o in seq(save_k[m-1],save_k[m]-1)) {
          verif <- as.character(lecture_list_MBDN_G$date[o])
          if (is.na(verif) == TRUE) {break()}
          if ((verif < sunrise[m-1]) || (verif > sunset[m-1])) {
            lecture_list_MBDN_G$date[o] <- NA
            lecture_list_MBDN_G$value[o] <- NA
          }
        }
      }
      for (o in seq(save_k[m],length(lecture_list_MBDN_G$value))) {
        verif <- as.character(lecture_list_MBDN_G$date[o])
        if (is.na(verif) == TRUE) {break()}
        if ((verif < sunrise[m]) || (verif > sunset[m])) {
          lecture_list_MBDN_G$date[o] <- NA
          lecture_list_MBDN_G$value[o] <- NA
        }
      }
      # Elimination des NA pour avoir un stockage propre
      lecture_list_MBDN_G <- na.omit(lecture_list_MBDN_G)
      
      
        # ---- Diffus ----
      # Initialisation des variables
      sunrise <- 0
      sunset <- 0
      save_k <- 1
      # Initialisation de la premiere date
      date_prec <- as.Date(substr(x = lecture_list_MBDN_D$date[1], 1, 10))
      k = 1
      # Calcul de l'heure de lever (sunrise) et coucher (sunset) du soleil
      Sun_Time <- getSunlightTimes(date = date_prec, lat = L, lon = l, keep = c("sunrise", "sunset"))
      # Ajout de (4 * 3600), car nous sommes à UTC+04
      sunrise[1] <- as.character(Sun_Time$sunrise + 4 * 3600)
      sunset[1] <- as.character(Sun_Time$sunset + 4 * 3600)
      # Tant qu'on ne change pas de jour ne rien faire sinon stocker la valeur k, sunset et sunrise
      repeat{
        date_suiv <- as.Date(substr(x = lecture_list_MBDN_D$date[k], 1, 10))
        if (date_prec < date_suiv) {
          date_prec <- date_suiv
          # Calcul de l'heure de lever (sunrise) et coucher (sunset) du soleil
          Sun_Time <- getSunlightTimes(date = date_prec, lat = L, lon = l, keep = c("sunrise", "sunset"))
          # Ajout de (4 * 3600), car nous sommes à UTC+04
          sunrise[k] <- as.character(Sun_Time$sunrise + 4 * 3600)
          # Ajout de (4 * 3600), car nous sommes à UTC+04
          sunset[k] <- as.character(Sun_Time$sunset + 4 * 3600)
          # Stockage de la variable k (representation du changement de jour)
          save_k[k] <- k
          if (date_prec == paste(annee[i], "-", mois_ch[j], "-", jr_mois[j], sep = "")) {break()}
        }
        k <- k + 1
      }
      # Suppression des NA
      save_k <- na.omit(save_k)
      sunrise <- na.omit(object = sunrise)
      sunset <- na.omit(object = sunset)
      # Enlever la dernière itération de STOP auto (cette boucle s'arrete d'elle même mais applique "k <- k + 1" avant)
      k <- k - 1 
      # Balayage des heures de toutes la journee de tous les jours (-1) pour eliminer les heures et valeurs en dehors des heures ou le soleil n'est plus
      for (m in seq(2,length(save_k))) {
        for (o in seq(save_k[m-1],save_k[m]-1)) {
          verif <- as.character(lecture_list_MBDN_D$date[o])
          if (is.na(verif) == TRUE) {break()}
          if ((verif < sunrise[m-1]) || (verif > sunset[m-1])) {
            lecture_list_MBDN_D$date[o] <- NA
            lecture_list_MBDN_D$value[o] <- NA
          }
        }
      }
      for (o in seq(save_k[m],length(lecture_list_MBDN_D$value))) {
        verif <- as.character(lecture_list_MBDN_D$date[o])
        if (is.na(verif) == TRUE) {break()}
        if ((verif < sunrise[m]) || (verif > sunset[m])) {
          lecture_list_MBDN_D$date[o] <- NA
          lecture_list_MBDN_D$value[o] <- NA
        }
      }
      # Elimination des NA pour avoir un stockage propre
      lecture_list_MBDN_D <- na.omit(lecture_list_MBDN_D)
      
      
      # ---- Saint Andre ----
        # ---- Global ----
      # Initialisation des variables
      sunrise <- 0
      sunset <- 0
      save_k <- 1
      # Initialisation de la premiere date
      date_prec <- as.Date(substr(x = lecture_list_SA_G$date[1], 1, 10))
      k = 1
      # Calcul de l'heure de lever (sunrise) et coucher (sunset) du soleil
      Sun_Time <- getSunlightTimes(date = date_prec, lat = L, lon = l, keep = c("sunrise", "sunset"))
      # Ajout de (4 * 3600), car nous sommes à UTC+04
      sunrise[1] <- as.character(Sun_Time$sunrise + 4 * 3600)
      sunset[1] <- as.character(Sun_Time$sunset + 4 * 3600)
      # Tant qu'on ne change pas de jour ne rien faire sinon stocker la valeur k, sunset et sunrise
      repeat{
        date_suiv <- as.Date(substr(x = lecture_list_SA_G$date[k], 1, 10))
        if (date_prec < date_suiv) {
          date_prec <- date_suiv
          # Calcul de l'heure de lever (sunrise) et coucher (sunset) du soleil
          Sun_Time <- getSunlightTimes(date = date_prec, lat = L, lon = l, keep = c("sunrise", "sunset"))
          # Ajout de (4 * 3600), car nous sommes à UTC+04
          sunrise[k] <- as.character(Sun_Time$sunrise + 4 * 3600)
          # Ajout de (4 * 3600), car nous sommes à UTC+04
          sunset[k] <- as.character(Sun_Time$sunset + 4 * 3600)
          # Stockage de la variable k (representation du changement de jour)
          save_k[k] <- k
          if (date_prec == paste(annee[i], "-", mois_ch[j], "-", jr_mois[j], sep = "")) {break()}
        }
        k <- k + 1
      }
      # Suppression des NA
      save_k <- na.omit(save_k)
      sunrise <- na.omit(object = sunrise)
      sunset <- na.omit(object = sunset)
      # Enlever la dernière itération de STOP auto (cette boucle s'arrete d'elle même mais applique "k <- k + 1" avant)
      k <- k - 1 
      # Balayage des heures de toutes la journee de tous les jours (-1) pour eliminer les heures et valeurs en dehors des heures ou le soleil n'est plus
      for (m in seq(2,length(save_k))) {
        for (o in seq(save_k[m-1],save_k[m]-1)) {
          verif <- as.character(lecture_list_SA_G$date[o])
          if (is.na(verif) == TRUE) {break()}
          if ((verif < sunrise[m-1]) || (verif > sunset[m-1])) {
            lecture_list_SA_G$date[o] <- NA
            lecture_list_SA_G$value[o] <- NA
          }
        }
      }
      for (o in seq(save_k[m],length(lecture_list_SA_G$value))) {
        verif <- as.character(lecture_list_SA_G$date[o])
        if (is.na(verif) == TRUE) {break()}
        if ((verif < sunrise[m]) || (verif > sunset[m])) {
          lecture_list_SA_G$date[o] <- NA
          lecture_list_SA_G$value[o] <- NA
        }
      }
      # Elimination des NA pour avoir un stockage propre
      lecture_list_SA_G <- na.omit(lecture_list_SA_G)
      
        # ---- Diffus ----
      # Initialisation des variables
      sunrise <- 0
      sunset <- 0
      save_k <- 1
      # Initialisation de la premiere date
      date_prec <- as.Date(substr(x = lecture_list_SA_D$date[1], 1, 10))
      k = 1
      # Calcul de l'heure de lever (sunrise) et coucher (sunset) du soleil
      Sun_Time <- getSunlightTimes(date = date_prec, lat = L, lon = l, keep = c("sunrise", "sunset"))
      # Ajout de (4 * 3600), car nous sommes à UTC+04
      sunrise[1] <- as.character(Sun_Time$sunrise + 4 * 3600)
      sunset[1] <- as.character(Sun_Time$sunset + 4 * 3600)
      # Tant qu'on ne change pas de jour ne rien faire sinon stocker la valeur k, sunset et sunrise
      repeat{
        date_suiv <- as.Date(substr(x = lecture_list_SA_D$date[k], 1, 10))
        if (date_prec < date_suiv) {
          date_prec <- date_suiv
          # Calcul de l'heure de lever (sunrise) et coucher (sunset) du soleil
          Sun_Time <- getSunlightTimes(date = date_prec, lat = L, lon = l, keep = c("sunrise", "sunset"))
          # Ajout de (4 * 3600), car nous sommes à UTC+04
          sunrise[k] <- as.character(Sun_Time$sunrise + 4 * 3600)
          # Ajout de (4 * 3600), car nous sommes à UTC+04
          sunset[k] <- as.character(Sun_Time$sunset + 4 * 3600)
          # Stockage de la variable k (representation du changement de jour)
          save_k[k] <- k
          if (date_prec == paste(annee[i], "-", mois_ch[j], "-", jr_mois[j], sep = "")) {break()}
        }
        k <- k + 1
      }
      # Suppression des NA
      save_k <- na.omit(save_k)
      sunrise <- na.omit(object = sunrise)
      sunset <- na.omit(object = sunset)
      # Enlever la dernière itération de STOP auto (cette boucle s'arrete d'elle même mais applique "k <- k + 1" avant)
      k <- k - 1 
      # Balayage des heures de toutes la journee de tous les jours (-1) pour eliminer les heures et valeurs en dehors des heures ou le soleil n'est plus
      for (m in seq(2,length(save_k))) {
        for (o in seq(save_k[m-1],save_k[m]-1)) {
          verif <- as.character(lecture_list_SA_D$date[o])
          if (is.na(verif) == TRUE) {break()}
          if ((verif < sunrise[m-1]) || (verif > sunset[m-1])) {
            lecture_list_SA_D$date[o] <- NA
            lecture_list_SA_D$value[o] <- NA
          }
        }
      }
      for (o in seq(save_k[m],length(lecture_list_SA_D$value))) {
        verif <- as.character(lecture_list_SA_D$date[o])
        if (is.na(verif) == TRUE) {break()}
        if ((verif < sunrise[m]) || (verif > sunset[m])) {
          lecture_list_SA_D$date[o] <- NA
          lecture_list_SA_D$value[o] <- NA
        }
      }
      # Elimination des NA pour avoir un stockage propre
      lecture_list_SA_D <- na.omit(lecture_list_SA_D)
      
      
      # ---- Saint Leu ----
        # ---- Global ----
      # Initialisation des variables
      sunrise <- 0
      sunset <- 0
      save_k <- 1
      # Initialisation de la premiere date
      date_prec <- as.Date(substr(x = lecture_list_SL_G$date[1], 1, 10))
      k = 1
      # Calcul de l'heure de lever (sunrise) et coucher (sunset) du soleil
      Sun_Time <- getSunlightTimes(date = date_prec, lat = L, lon = l, keep = c("sunrise", "sunset"))
      # Ajout de (4 * 3600), car nous sommes à UTC+04
      sunrise[1] <- as.character(Sun_Time$sunrise + 4 * 3600)
      sunset[1] <- as.character(Sun_Time$sunset + 4 * 3600)
      # Tant qu'on ne change pas de jour ne rien faire sinon stocker la valeur k, sunset et sunrise
      repeat{
        date_suiv <- as.Date(substr(x = lecture_list_SL_G$date[k], 1, 10))
        if (date_prec < date_suiv) {
          date_prec <- date_suiv
          # Calcul de l'heure de lever (sunrise) et coucher (sunset) du soleil
          Sun_Time <- getSunlightTimes(date = date_prec, lat = L, lon = l, keep = c("sunrise", "sunset"))
          # Ajout de (4 * 3600), car nous sommes à UTC+04
          sunrise[k] <- as.character(Sun_Time$sunrise + 4 * 3600)
          # Ajout de (4 * 3600), car nous sommes à UTC+04
          sunset[k] <- as.character(Sun_Time$sunset + 4 * 3600)
          # Stockage de la variable k (representation du changement de jour)
          save_k[k] <- k
          if (date_prec == paste(annee[i], "-", mois_ch[j], "-", jr_mois[j], sep = "")) {break()}
        }
        k <- k + 1
      }
      # Suppression des NA
      save_k <- na.omit(save_k)
      sunrise <- na.omit(object = sunrise)
      sunset <- na.omit(object = sunset)
      # Enlever la dernière itération de STOP auto (cette boucle s'arrete d'elle même mais applique "k <- k + 1" avant)
      k <- k - 1 
      # Balayage des heures de toutes la journee de tous les jours (-1) pour eliminer les heures et valeurs en dehors des heures ou le soleil n'est plus
      for (m in seq(2,length(save_k))) {
        for (o in seq(save_k[m-1],save_k[m]-1)) {
          verif <- as.character(lecture_list_SL_G$date[o])
          if (is.na(verif) == TRUE) {break()}
          if ((verif < sunrise[m-1]) || (verif > sunset[m-1])) {
            lecture_list_SL_G$date[o] <- NA
            lecture_list_SL_G$value[o] <- NA
          }
        }
      }
      for (o in seq(save_k[m],length(lecture_list_SL_G$value))) {
        verif <- as.character(lecture_list_SL_G$date[o])
        if (is.na(verif) == TRUE) {break()}
        if ((verif < sunrise[m]) || (verif > sunset[m])) {
          lecture_list_SL_G$date[o] <- NA
          lecture_list_SL_G$value[o] <- NA
        }
      }
      # Elimination des NA pour avoir un stockage propre
      lecture_list_SL_G <- na.omit(lecture_list_SL_G)
      
        # ---- Diffus ----
      # Initialisation des variables
      sunrise <- 0
      sunset <- 0
      save_k <- 1
      # Initialisation de la premiere date
      date_prec <- as.Date(substr(x = lecture_list_SL_D$date[1], 1, 10))
      k = 1
      # Calcul de l'heure de lever (sunrise) et coucher (sunset) du soleil
      Sun_Time <- getSunlightTimes(date = date_prec, lat = L, lon = l, keep = c("sunrise", "sunset"))
      # Ajout de (4 * 3600), car nous sommes à UTC+04
      sunrise[1] <- as.character(Sun_Time$sunrise + 4 * 3600)
      sunset[1] <- as.character(Sun_Time$sunset + 4 * 3600)
      # Tant qu'on ne change pas de jour ne rien faire sinon stocker la valeur k, sunset et sunrise
      repeat{
        date_suiv <- as.Date(substr(x = lecture_list_SL_D$date[k], 1, 10))
        if (date_prec < date_suiv) {
          date_prec <- date_suiv
          # Calcul de l'heure de lever (sunrise) et coucher (sunset) du soleil
          Sun_Time <- getSunlightTimes(date = date_prec, lat = L, lon = l, keep = c("sunrise", "sunset"))
          # Ajout de (4 * 3600), car nous sommes à UTC+04
          sunrise[k] <- as.character(Sun_Time$sunrise + 4 * 3600)
          # Ajout de (4 * 3600), car nous sommes à UTC+04
          sunset[k] <- as.character(Sun_Time$sunset + 4 * 3600)
          # Stockage de la variable k (representation du changement de jour)
          save_k[k] <- k
          if (date_prec == paste(annee[i], "-", mois_ch[j], "-", jr_mois[j], sep = "")) {break()}
        }
        k <- k + 1
      }
      # Suppression des NA
      save_k <- na.omit(save_k)
      sunrise <- na.omit(object = sunrise)
      sunset <- na.omit(object = sunset)
      # Enlever la dernière itération de STOP auto (cette boucle s'arrete d'elle même mais applique "k <- k + 1" avant)
      k <- k - 1 
      # Balayage des heures de toutes la journee de tous les jours (-1) pour eliminer les heures et valeurs en dehors des heures ou le soleil n'est plus
      for (m in seq(2,length(save_k))) {
        for (o in seq(save_k[m-1],save_k[m]-1)) {
          verif <- as.character(lecture_list_SL_D$date[o])
          if (is.na(verif) == TRUE) {break()}
          if ((verif < sunrise[m-1]) || (verif > sunset[m-1])) {
            lecture_list_SL_D$date[o] <- NA
            lecture_list_SL_D$value[o] <- NA
          }
        }
      }
      for (o in seq(save_k[m],length(lecture_list_SL_D$value))) {
        verif <- as.character(lecture_list_SL_D$date[o])
        if (is.na(verif) == TRUE) {break()}
        if ((verif < sunrise[m]) || (verif > sunset[m])) {
          lecture_list_SL_D$date[o] <- NA
          lecture_list_SL_D$value[o] <- NA
        }
      }
      # Elimination des NA pour avoir un stockage propre
      lecture_list_SL_D <- na.omit(lecture_list_SL_D)
      
      
      # ---- Saint Pierre ----
        # ---- Global ----
      # Initialisation des variables
      sunrise <- 0
      sunset <- 0
      save_k <- 1
      # Initialisation de la premiere date
      date_prec <- as.Date(substr(x = lecture_list_SP_G$date[1], 1, 10))
      k = 1
      # Calcul de l'heure de lever (sunrise) et coucher (sunset) du soleil
      Sun_Time <- getSunlightTimes(date = date_prec, lat = L, lon = l, keep = c("sunrise", "sunset"))
      # Ajout de (4 * 3600), car nous sommes à UTC+04
      sunrise[1] <- as.character(Sun_Time$sunrise + 4 * 3600)
      sunset[1] <- as.character(Sun_Time$sunset + 4 * 3600)
      # Tant qu'on ne change pas de jour ne rien faire sinon stocker la valeur k, sunset et sunrise
      repeat{
        date_suiv <- as.Date(substr(x = lecture_list_SP_G$date[k], 1, 10))
        if (date_prec < date_suiv) {
          date_prec <- date_suiv
          # Calcul de l'heure de lever (sunrise) et coucher (sunset) du soleil
          Sun_Time <- getSunlightTimes(date = date_prec, lat = L, lon = l, keep = c("sunrise", "sunset"))
          # Ajout de (4 * 3600), car nous sommes à UTC+04
          sunrise[k] <- as.character(Sun_Time$sunrise + 4 * 3600)
          # Ajout de (4 * 3600), car nous sommes à UTC+04
          sunset[k] <- as.character(Sun_Time$sunset + 4 * 3600)
          # Stockage de la variable k (representation du changement de jour)
          save_k[k] <- k
          if (date_prec == paste(annee[i], "-", mois_ch[j], "-", jr_mois[j], sep = "")) {break()}
        }
        k <- k + 1
      }
      # Suppression des NA
      save_k <- na.omit(save_k)
      sunrise <- na.omit(object = sunrise)
      sunset <- na.omit(object = sunset)
      # Enlever la dernière itération de STOP auto (cette boucle s'arrete d'elle même mais applique "k <- k + 1" avant)
      k <- k - 1 
      # Balayage des heures de toutes la journee de tous les jours (-1) pour eliminer les heures et valeurs en dehors des heures ou le soleil n'est plus
      for (m in seq(2,length(save_k))) {
        for (o in seq(save_k[m-1],save_k[m]-1)) {
          verif <- as.character(lecture_list_SP_G$date[o])
          if (is.na(verif) == TRUE) {break()}
          if ((verif < sunrise[m-1]) || (verif > sunset[m-1])) {
            lecture_list_SP_G$date[o] <- NA
            lecture_list_SP_G$value[o] <- NA
          }
        }
      }
      for (o in seq(save_k[m],length(lecture_list_SP_G$value))) {
        verif <- as.character(lecture_list_SP_G$date[o])
        if (is.na(verif) == TRUE) {break()}
        if ((verif < sunrise[m]) || (verif > sunset[m])) {
          lecture_list_SP_G$date[o] <- NA
          lecture_list_SP_G$value[o] <- NA
        }
      }
      # Elimination des NA pour avoir un stockage propre
      lecture_list_SP_G <- na.omit(lecture_list_SP_G)
      
        # ---- Diffus ----
      # Initialisation des variables
      sunrise <- 0
      sunset <- 0
      save_k <- 1
      # Initialisation de la premiere date
      date_prec <- as.Date(substr(x = lecture_list_SP_D$date[1], 1, 10))
      k = 1
      # Calcul de l'heure de lever (sunrise) et coucher (sunset) du soleil
      Sun_Time <- getSunlightTimes(date = date_prec, lat = L, lon = l, keep = c("sunrise", "sunset"))
      # Ajout de (4 * 3600), car nous sommes à UTC+04
      sunrise[1] <- as.character(Sun_Time$sunrise + 4 * 3600)
      sunset[1] <- as.character(Sun_Time$sunset + 4 * 3600)
      # Tant qu'on ne change pas de jour ne rien faire sinon stocker la valeur k, sunset et sunrise
      repeat{
        date_suiv <- as.Date(substr(x = lecture_list_SP_D$date[k], 1, 10))
        if (date_prec < date_suiv) {
          date_prec <- date_suiv
          # Calcul de l'heure de lever (sunrise) et coucher (sunset) du soleil
          Sun_Time <- getSunlightTimes(date = date_prec, lat = L, lon = l, keep = c("sunrise", "sunset"))
          # Ajout de (4 * 3600), car nous sommes à UTC+04
          sunrise[k] <- as.character(Sun_Time$sunrise + 4 * 3600)
          # Ajout de (4 * 3600), car nous sommes à UTC+04
          sunset[k] <- as.character(Sun_Time$sunset + 4 * 3600)
          # Stockage de la variable k (representation du changement de jour)
          save_k[k] <- k
          if (date_prec == paste(annee[i], "-", mois_ch[j], "-", jr_mois[j], sep = "")) {break()}
        }
        k <- k + 1
      }
      # Suppression des NA
      save_k <- na.omit(save_k)
      sunrise <- na.omit(object = sunrise)
      sunset <- na.omit(object = sunset)
      # Enlever la dernière itération de STOP auto (cette boucle s'arrete d'elle même mais applique "k <- k + 1" avant)
      k <- k - 1 
      # Balayage des heures de toutes la journee de tous les jours (-1) pour eliminer les heures et valeurs en dehors des heures ou le soleil n'est plus
      for (m in seq(2,length(save_k))) {
        for (o in seq(save_k[m-1],save_k[m]-1)) {
          verif <- as.character(lecture_list_SP_D$date[o])
          if (is.na(verif) == TRUE) {break()}
          if ((verif < sunrise[m-1]) || (verif > sunset[m-1])) {
            lecture_list_SP_D$date[o] <- NA
            lecture_list_SP_D$value[o] <- NA
          }
        }
      }
      for (o in seq(save_k[m],length(lecture_list_SP_D$value))) {
        verif <- as.character(lecture_list_SP_D$date[o])
        if (is.na(verif) == TRUE) {break()}
        if ((verif < sunrise[m]) || (verif > sunset[m])) {
          lecture_list_SP_D$date[o] <- NA
          lecture_list_SP_D$value[o] <- NA
        }
      }
      # Elimination des NA pour avoir un stockage propre
      lecture_list_SP_D <- na.omit(lecture_list_SP_D)
      
      
      # ---- Mémoire (accumulation des informations dans une variable) ----
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
  # ---- Moyenne ----
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
  
  # ---- Ecart-type ----
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
  
  # ---- Valeur min et max ----
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
  
  # ---- Ecriture dans un fichier externe ----
  # Moyenne
  setwd(dir = "~/Base de données/Opérations")
  Moy_G <- as.data.frame(x =c(moy_LP_G, moy_MBDN_G, moy_SA_G, moy_SL_G, moy_SP_G))
  Moy_D <- as.data.frame(x =c(moy_LP_D, moy_MBDN_D, moy_SA_D, moy_SL_D, moy_SP_D))
  fusion_1 <- c(Moy_G, Moy_D)
  write.table(x = fusion_1, file = paste("Moy_Ray_G_D", mois[j], ".txt", sep = ""), col.names = TRUE)
  # Min, Ecart-Type et max
  LP <- as.data.frame(x = c(min_LP_G, ET_LP_G, max_LP_G, min_LP_D, ET_LP_D, max_LP_D))
  MBDN <- as.data.frame(x = c(min_MBDN_G, ET_MBDN_G, max_MBDN_G, min_MBDN_D, ET_MBDN_D, max_MBDN_D))
  SA <- as.data.frame(x = c(min_SA_G, ET_SA_G, max_SA_G, min_SA_D, ET_SA_D, max_SA_D))
  SL <- as.data.frame(x = c(min_SL_G, ET_SL_G, max_SL_G, min_SL_D, ET_SL_D, max_SL_D))
  SP <- as.data.frame(x = c(min_SP_G, ET_SP_G, max_SP_G, min_SP_D, ET_SP_D, max_SP_D))
  fusion_2 <- c(LP, MBDN, SA, SL, SP)
  write.table(x = fusion_2, file = paste("Min_Ecart-type_Max_Global_et_Diffus", mois[j], ".txt", sep = ""), col.names = TRUE)
  
  # ---- Remise à zero des variables utilisees ----
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

