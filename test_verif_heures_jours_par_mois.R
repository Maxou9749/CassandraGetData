setwd(dir = "~/Base de données/2012/Novembre/")
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

lon <- nrow(lecture_list_LP_G)

# Passage au jour suivant
date_prec <- as.Date(substr(x = lecture_list_LP_G$date[1], 1, 10))
k = 1
sunrise <- 0
sunset <- 0
Sun_Time <- getSunlightTimes(date = date_prec, lat = L, lon = l, keep = c("sunrise", "sunset"))
sunrise[1] <- as.character(Sun_Time$sunrise + 4 * 3600)
sunset[1] <- as.character(Sun_Time$sunset + 4 * 3600)
repeat{
  repeat{
    date_suiv <- as.Date(substr(x = lecture_list_LP_G$date[k], 1, 10))
    if (date_prec < date_suiv) {
      date_prec <- date_suiv
      Sun_Time <- getSunlightTimes(date = date_prec, lat = L, lon = l, keep = c("sunrise", "sunset"))
      sunrise[k] <- as.character(Sun_Time$sunrise + 4 * 3600)
      sunset[k] <- as.character(Sun_Time$sunset + 4 * 3600)
      break()
    }
    k <- k + 1
  }
}
sunrise <- na.omit(object = sunrise)
sunset <- na.omit(object = sunset)
k <- k - 1 # Enlever la dernière itération de STOP auto