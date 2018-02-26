
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


# ---- Novembre ----
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
      
      # Selection de la colonne numero 2 (Donnees solaire)
      select_col_LP_G <- lecture_list_LP_G[2]
      select_col_MBDN_G <- lecture_list_MBDN_G[2]
      select_col_SA_G <- lecture_list_SA_G[2]
      select_col_SL_G <- lecture_list_SL_G[2]
      select_col_SP_G <- lecture_list_SP_G[2]
      select_col_LP_D <- lecture_list_LP_D[2]
      select_col_MBDN_D <- lecture_list_MBDN_D[2]
      select_col_SA_D <- lecture_list_SA_D[2]
      select_col_SL_D <- lecture_list_SL_D[2]
      select_col_SP_D <- lecture_list_SP_D[2]

      # Conversion des listes en format numerique
      conv_num_LP_G <- as.numeric(unlist(select_col_LP_G))
      conv_num_MBDN_G <- as.numeric(unlist(select_col_MBDN_G))
      conv_num_SA_G <- as.numeric(unlist(select_col_SA_G))
      conv_num_SL_G <- as.numeric(unlist(select_col_SL_G))
      conv_num_SP_G <- as.numeric(unlist(select_col_SP_G))
      conv_num_LP_D <- as.numeric(unlist(select_col_LP_D))
      conv_num_MBDN_D <- as.numeric(unlist(select_col_MBDN_D))
      conv_num_SA_D <- as.numeric(unlist(select_col_SA_D))
      conv_num_SL_D <- as.numeric(unlist(select_col_SL_D))
      conv_num_SP_D <- as.numeric(unlist(select_col_SP_D))
      
      # Variable de stockage 
      Donnees_LP_G <- c(Donnees_LP_G, conv_num_LP_G)
      Donnees_MBDN_G <- c(Donnees_MBDN_G, conv_num_MBDN_G)
      Donnees_SA_G <- c(Donnees_SA_G, conv_num_SA_G)
      Donnees_SL_G <- c(Donnees_SL_G, conv_num_SL_G)
      Donnees_SP_G <- c(Donnees_SP_G, conv_num_SP_G)
      Donnees_LP_D <- c(Donnees_LP_D, conv_num_LP_D)
      Donnees_MBDN_D <- c(Donnees_MBDN_D, conv_num_MBDN_D)
      Donnees_SA_D <- c(Donnees_SA_D, conv_num_SA_D)
      Donnees_SL_D <- c(Donnees_SL_D, conv_num_SL_D)
      Donnees_SP_D <- c(Donnees_SP_D, conv_num_SP_D)
      
      
      # Stockage des valeurs moyennes 
      moy_LP_G <- mean(x = Donnees_LP_G)
      moy_MBDN_G <- mean(x = Donnees_MBDN_G)
      moy_SA_G <- mean(x = Donnees_SA_G)
      moy_SL_G <- mean(x = Donnees_SL_G)
      moy_SP_G <- mean(x = Donnees_SP_G)
      moy_LP_D <- mean(x = Donnees_LP_D)
      moy_MBDN_D <- mean(x = Donnees_MBDN_D)
      moy_SA_D <- mean(x = Donnees_SA_D)
      moy_SL_D <- mean(x = Donnees_SL_D)
      moy_SP_D <- mean(x = Donnees_SP_D)
      
      # Ecriture dans un fichier externe
      setwd(dir = "~/Base de données/Moyennes")
      Moyenne_G <- c(moy_LP_G, moy_MBDN_G, moy_SA_G, moy_SL_G, moy_SP_G)
      Moyenne_D <- c(moy_LP_D, moy_MBDN_D, moy_SA_D, moy_SL_D, moy_SP_D)
      write.table(x = Moyenne_G, file = paste("Moy_Ray_Global_", mois[j], ".txt", sep = ""))
      write.table(x = Moyenne_D, file = paste("Moy_Ray_Diffus_", mois[j], ".txt", sep = ""))
      
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
}