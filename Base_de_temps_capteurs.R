# ---------------------------------------------------------
#                      Maxime ROUSSEAU
#            Tracer la base de temps des capteurs
#                        12/02/2018
# ---------------------------------------------------------


Base_de_donnees_m <- read.table(file = "/home/maxime/CassandraGetData/Base_de_donnees.txt", sep = ";")
Debut <- Base_de_donnees_m[,4]
Fin <- Base_de_donnees_m[,5]

Debut <- as.character(Debut)
Fin <- as.character(Fin)

D <- matrix(610,1)
F <- matrix(610,1)

for (i in seq(1, 610)) {
  chr_d <- Debut[i]
  chr_f <- Fin[i]
  date_d <- substr(chr_d, 1, 10)
  date_f <- substr(chr_f, 1, 10)
  D[i] <- date_d
  F[i] <- date_f
}

time <- strptime(D)
plot(D[2])
axis.Date(1, D[2], at = "2001/01/01", format = "%Y-%m-%d")