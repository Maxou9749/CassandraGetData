
#                         Maxime ROUSSEAU
#     Controle de la qualite de la donnee (precision du BSRN)
#                           08/03/2018

# ---- Chargement des librairies ----
library(suncalc)
library(lubridate)


# ---- Définition des variables ----
L <- -21.06          # Latitude
l <- 55.31           # Longitude
date <- Sys.Date()
date_1 <- substr(Sys.time(), 1, 20)


# ---- Calculs ----
Sun_Time <- getSunlightTimes(date = date, lat = L, lon = l, keep = c("sunrise", "sunset"))

lever_du_soleil <-Sun_Time$sunrise + 3600*4     # Application de UTC+04 à l'heure du lever du soleil
coucher_du_soleil <- Sun_Time$sunset + 3600*4   # Application de UTC+04 à l'heure du coucher du soleil


# ---- Boucle de test (variation sur une journée) ----
long <- as.numeric(coucher_du_soleil-lever_du_soleil)*3600
date_boucle <- lever_du_soleil
for (i in seq(1,long)) {
  Sun_Position <- getSunlightPosition(date = date_boucle, lat = L, lon = l)
  altitude[i] <- Sun_Position$altitude * 180/pi      # Altitude converti en degré
  azimuth[i] <- Sun_Position$azimuth * 180/pi        # Azimuth converti en degré
  date_boucle <- date_boucle + 1
}