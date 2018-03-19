
#                         Maxime ROUSSEAU
#     Controle de la qualite de la donnee (precision du BSRN)
#                           19/03/2018

library(sp)
library(raster)
library(satellite)
library(suncalc)

# ---- Definition des variables ----
jr_mois <- c(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
mois <- c("Janvier", "Fevrier", "Mars", "Avril", "Mai", "Juin", "Juillet", "Aout", "Septembre", "Octobre", "Novembre", "Decembre")
annee <- c("2012", "2013", "2014", "2015", "2016", "2017","2018")
GlimP_inf <- 0
GlimP_sup <- 0
DlimP_inf <- 0
DlimP_sup <- 0
GlimR_inf <- 0
GlimR_sup <- 0
DlimR_inf <- 0
DlimR_sup <- 0

# ---- Definition des constantes ----
SZA <- 60                             # [°] , Angle zenithal solaire
SZA <- SZA*pi/180                     # Conversion en radian
if (SZA > 90) {µ0 <- 0} else {
  µ0 <- cos(SZA)                   
}
S0 <- 1361                            # [W.m²] , Constante solaire (KOPP & LEAN 2011)
AU[1] <- 147100000/149597870.691      # [SI] , Distance Terre-Soleil minimale (Périhélie)
AU[2] <- 149597870.691/149597870.691  # [SI] , Distance Terre-Soleil (Demi-Grand Axe)
AU[3] <- 152100000/149597870.691      # [SI] , Distance Terre-Soleil maximale (Aphélie)
AU <- c (0.99, 1, 1.01)               

# Variation de la distance Terre Soleil de 0.99 à 1.01
for (i in seq(1,3)) {
  Sa <- S0/(AU[i]^2)                  # [SI] , Constante solaire ajustee a la distance Terre-Soleil
  
  # ---- Calcul des bornes min et max ----
  # Limites physiques Global SWdn [W.m-²]
  GlimP_inf[i] <- -4
  GlimP_sup[i] <- Sa * 1.5 * µ0*10^(0.5) + 100
  # Limites physiques Diffuse SW
  DlimP_inf[i] <- -4
  DlimP_sup[i] <- Sa * 0.95 * µ0*10^(0.5) + 50
  
  # Limites rares Global SWdn [W.m-²]
  GlimR_inf[i] <- -2
  GlimR_sup[i] <- Sa * 1.2 * µ0*10^(0.5) + 50
  # Limites rares Diffuse SW [W.m-²]
  DlimR_inf[i] <- -2
  DlimR_sup[i] <- Sa * 0.75 * µ0*10^(0.5) + 30
  
}


# Implémentation dans le programme d'opération
setwd(dir = "~/Base de données/2013/Janvier/")
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
    A <- length(lecture_list_LP_G$date)
    if (date_prec == as.Date(substr(x = lecture_list_LP_G$date[A], 1, 10))) {break()}
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



--------------------------------------------------------------------------------------------------------
library(sp)
library(raster)

# ---- Mise en place de la boucle pour le controle de la donnees (BSRN) ----
for (p in seq(1, "longeur de se qui reste dans lecture_list_LP_G"))) {
  AU <- calcEarthSunDist(date = substr(x = lecture_list_LP_G$date[p], 1, 10))
  SLP <- getSunlightPosition(date = as.character(lecture_list_LP_G$date[p]),  lat = L, lon = l)
  SZA <- SLP$altitude*180/pi
  if (SZA > 90) {µ0 <- 0} else {
    µ0 <- cos(SZA)                   
  }
  S0 <- 1361                          # [W.m²] , Constante solaire (KOPP & LEAN 2011)
  Sa <- S0/(AU^2)                  # [SI] , Constante solaire ajustee a la distance Terre-Soleil
  
  # ---- Calcul des bornes min et max ----
  # Limites rares Global SWdn [W.m-²]
  GlimR_inf <- -2
  GlimR_sup <- Sa * 1.2 * µ0*10^(0.5) + 50
  verif_BSRN <- lecture_list_LP_G$value[p]
  if ((verif_BSRN < GlimR_inf) || (verif_BSRN > GlimR_sup)) {
    lecture_list_LP_G$date[p] <- NA
    lecture_list_LP_G$value[p] <- NA
  }
}
lecture_list_LP_G <- na.omit(lecture_list_LP_G)

--------------------------------------------------------------------------------------------------------

# ---- Mémoire (accumulation des informations dans une variable) ----
list_LP_G <- c(list_LP_G, lecture_list_LP_G$value)
list_MBDN_G <- c(list_MBDN_G,lecture_list_MBDN_G$value)
list_SA_G <- c(list_SA_G,lecture_list_SA_G$value)
list_SL_G <- c(list_SL_G,lecture_list_SL_G$value)
list_SP_G <- c(list_SP_G,lecture_list_SP_G$value)
list_LP_D <- c(list_LP_D,lecture_list_LP_D$value)
list_MBDN_D <- c(list_MBDN_D,lecture_list_MBDN_D$value)
list_SA_D <- c(list_SA_D,lecture_list_SA_D$value)
list_SL_D <- c(list_SL_D,lecture_list_SL_D$value)
list_SP_D <- c(list_SP_D,lecture_list_SP_D$value)

setwd(dir = "~/Base de données/")

setwd(dir = "~/Base de données/")
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
