# ---------------------------------------------------------
#                      Maxime ROUSSEAU
#      Recuperation des donnees sur 5 ans des capteurs
#                        13/02/2018
# ---------------------------------------------------------

# Chargement de la library rLE2P
library(rLE2P)

Liste <- read.table("C:/Users/max97/Documents/Espace de travail Git/CassandraGetData/Liste_capteurs_base_de_temps_sup_5_ans.txt", sep = "\t")

# Selection des capteurs solaires pour chaque transaction
Ray_D <- c("FD_Avg", "FDnum_Avg")
Ray_G <- c("FG_Avg", "FGnum_Avg")

Saint_Leu <- "1465986548"
Saint_Andre <- "1465986253"
Saint_Pierre <- "1465989663"
Moufia_BDN <- "1465986423"
La_Possession <- "1465986484"

CassandraGetData(idTransaction = Saint_Leu, idSensor = Ray_D[1], timeStart = )