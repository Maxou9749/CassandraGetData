
#                         Maxime ROUSSEAU
#     Controle de la qualite de la donnee (precision du BSRN)
#                           08/03/2018

# ---- Définition des variables ----
L <- -21        # Latitude
j <- 100        # Jour julien


# ---- Calcul de l'heure du lever du soleil ----
zeta <- 23.45 * sin( (0.980 * (j + 284))*pi/180 )
TS1 <- 12 - (180/pi)*acos( - tan(L*pi/180) * tan(zeta*pi/180) ) / 15
TS1_h <- as.Date(x = TS1)


# ---- Calcul de l'heure du coucher du soleil ----
TS2 <- TS1 + 2 * (180/pi) * acos( - tan(L*pi/180) * tan(zeta*pi/180) ) / 15
