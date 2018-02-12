# ---------------------------------------------------------
#                      Maxime ROUSSEAU
#         Interroger la base de donnees CASSANDRA
#                        08/02/2018
# ---------------------------------------------------------

# Chargement de la library rLE2P
library(rLE2P)


# --- Recuperer de toutes les metadonnees des capteurs ----
tr <- CassandraGetTransactionList()

# Creation des matrices de stockage
Base_de_donnees <- matrix(nrow = 610, ncol = 5)
L <- matrix()

# Recuperation des meta pour chaque capteur
for (j in seq(1,27)) {
  myTr <- as.character(tr[j,1])
  ntr <- CassandraGetSensorFromTransaction(myTr)
  L[j] <- length(ntr)
  l <- sum(L)+1
  t <- sum(L)-L[j]+1
  for (i in seq(1,l)) {
    myNtr <- as.character(ntr[i])
    mtd <- CassandraGetMetadata(myTr, myNtr)
    if(is.null(mtd$sensor_id)) {Base_de_donnees[t+i-1, 1] <- "0"}    else {Base_de_donnees[t+i-1, 1] <- mtd$sensor_id}
    if(is.null(mtd$transaction_id)) {Base_de_donnees[t+i-1, 2] <- "0"}    else {Base_de_donnees[t+i-1, 2] <- mtd$transaction_id}
    if(is.null(mtd$trans_text_locality_name)) {Base_de_donnees[t+i-1, 3] <- "0"}    else {Base_de_donnees[t+i-1, 3] <- mtd$trans_text_locality_name}
    if(is.null(mtd$date_system_timeStart)) {Base_de_donnees[t+i-1, 4] <- "0"}    else {Base_de_donnees[t+i-1, 4] <- mtd$date_system_timeStart}
    if(is.null(mtd$date_system_timeEnd)) {Base_de_donnees[t+i-1, 5] <- "0"}    else {Base_de_donnees[t+i-1, 5] <- mtd$date_system_timeEnd}
  }
}


# ------- Ecriture des meta dans un fichier externe -------
write.table(Base_de_donnees, "/home/maxime/Bureau/Base_de_donnees.txt", sep=";")
write.table(L, "/home/maxime/Bureau/nombre_de_capteur_par_transaction.txt", sep=";")


# Classification des capteurs par zones pluviales
#Zone1 <- data.frame(c(tr[10,], tr[25,], tr[19,], tr[2,], tr[5,], tr[11,]))
#Zone2 <- data.frame(c(tr[3,], tr[13,], tr[15,], tr[1,], tr[9,], tr[8,], tr[14,], tr[26,], tr[16,]))
#Zone3 <- "vide"
#Zone4 <- data.frame(tr[6,])
#Zone5 <- data.frame(c(tr[4,], tr[20,], tr[24,], tr[21,]))
#Zone6 <- data.frame(tr[17,])
#Zone7 <- data.frame(tr[27,])