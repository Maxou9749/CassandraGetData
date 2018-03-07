
#                         Maxime ROUSSEAU
#     Controle de la qualite de la donnee (precision du BSRN)
#                           07/03/2018

# ---- Definition des variables ----
jr_mois <- c(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
mois <- c("Janvier", "Fevrier", "Mars", "Avril", "Mai", "Juin", "Juillet", "Aout", "Septembre", "Octobre", "Novembre", "Decembre")
annee <- c("2012", "2013", "2014", "2015", "2016", "2017","2018")


# ---- Definition des constantes ----
SZA <- 60                         # [°] , Angle zenithal solaire
SZA <- SZA*pi/180                 # Conversion en radian
if (SZA > 90) {µ0 <- 0} else {
  µ0 <- cos(SZA)                  # [SI] , 
}
S0 <- 1361                        # [SI] , Constante solaire (KOPP & LEAN 2011)
AU <- 1                           # [SI] , Distance Terre-Soleil
Sa <- S0/(AU^2)                   # [SI] , Constante solaire ajustee a la distance Terre-Soleil


# ---- Calcul des bornes min et max ----
# Limites physiques Global SWdn [W.m-²]
GlimP_inf <- -4
GlimP_sup <- Sa * 1.5 * µ0*10^(0.5) + 100
# Limites physiques Diffuse SW
DlimP_inf <- -4
DlimP_sup <- Sa * 0.95 * µ0*10^(0.5) + 50

# Limites rares Global SWdn [W.m-²]
GlimR_inf <- -2
GlimR_sup <- Sa * 1.2 * µ0*10^(0.5) + 50
# Limites rares Diffuse SW [W.m-²]
DlimR_inf <- -2
DlimR_sup <- Sa * 0.75 * µ0*10^(0.5) + 30

# ---- Programme Principal ----
setwd(dir = "~/Base de données/")
for (i in seq(1,12)) {
  for (j in seq(1,7)) {
    setwd(dir = annee[j])
    if (dir.exists(mois[j]) == FALSE) {} else {
      Diff_LP <- read.table(file = "Diffus_La_Possession.txt", sep =";")
      Diff_MBDN <- read.table(file = "Diffus_Moufia_BDN.txt", sep =";")
      Diff_SA <- read.table(file = "Diffus_Saint_Andre.txt", sep =";")
      Diff_SL <- read.table(file = "Diffus_Saint_Leu.txt", sep =";")
      Diff_SP <- read.table(file = "Diffus_Saint_Pierre.txt", sep =";")
      Global_LP <- read.table("Global_La_Possession.txt", sep =";")
      Global_LP <- read.table("Global_Moufia_BDN.txt", sep =";")
      Global_LP <- read.table("Global_Saint_Andre.txt", sep =";")
      Global_LP <- read.table("Global_Saint_Leu.txt", sep =";")
      Global_LP <- read.table("Global_Saint_Pierre.txt", sep =";")
    }
  }
}
