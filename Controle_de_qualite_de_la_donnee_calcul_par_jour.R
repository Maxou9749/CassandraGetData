
#                         Maxime ROUSSEAU
#     Controle de la qualite de la donnee (precision du BSRN)
#                           19/03/2018

library(raster)
library(sp)
library(satellite)

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


