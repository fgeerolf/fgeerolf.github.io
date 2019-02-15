rm(list = ls())
pklist <- c("tidyverse", "data.table", "zoo")
source("/Users/geerolf/Drive/work/code-sample/R/load-packages.R")

setwd("/Users/geerolf/Drive/work/datasets/fama-french/data")

frenchFTP <- "http://mba.tuck.dartmouth.edu/pages/faculty/ken.french/ftp/"

colnames1 <- c("date","Mkt-RF","SMB","HML","RF")
colnames2 <- c("date","Mkt-RF","SMB","HML","RMW","CMA","RF")
colnames3 <- c("date","Neg", "Lo30","Med40","Hi30",
               "Lo20","Qnt2","Qnt3","Qnt4","Hi20",
               "Lo10","Dec2","Dec3","Dec4","Dec5",
               "Dec6","Dec7","Dec8","Dec9","Hi10")
colnames4 <- c("date","Lo30","Med40","Hi30",
               "Lo20","Qnt2","Qnt3","Qnt4","Hi20",
               "Lo10","Dec2","Dec3","Dec4","Dec5",
               "Dec6","Dec7","Dec8","Dec9","Hi10")
colnames5 <- c("date","Lo20","Qnt2","Qnt3","Qnt4","Hi20",
               "Lo10","Dec2","Dec3","Dec4","Dec5",
               "Dec6","Dec7","Dec8","Dec9","Hi10")
colnames6 <- c("date","Neg","Zero",
               "Lo20","Qnt2","Qnt3","Qnt4","Hi20",
               "Lo10","Dec2","Dec3","Dec4","Dec5",
               "Dec6","Dec7","Dec8","Dec9","Hi10")
colnames7 <- c("date","Momentum Factor")
colnames8 <- c("date",
               "SmallMom1","SmallMom2","SmallMom3",
               "BigMom1","BigMom2","BigMom3")
colnames9 <- c("date","S1M1","S1M2","S1M3","S1M4","S1M5","S2M1","S2M2","S2M3","S2M4","S2M5",
               "S3M1","S3M2","S3M3","S3M4","S3M5","S4M1","S4M2","S4M3","S4M4","S4M5",
               "S5M1","S5M2","S5M3","S5M4","S5M5")
colnames10 <- c("date","Mom1","Mom2","Mom3","Mom4","Mom5","Mom6","Mom7","Mom8","Mom9","Mom10")

# read.csv("/Users/geerolf/Documents/Portfolios_Formed_on_BE-ME.CSV", skip = 23)

DownloadFF <- function(series, colnames = NULL){
  # series <- "Portfolios_Formed_on_BE-ME"
  file.zip <- paste0(series, "_TXT.zip")
  download.file(paste0(frenchFTP, series, "_TXT.zip"), file.zip)
  unzip(file.zip)
  
  dt <- fread(paste0(series, ".txt"), header = FALSE) %>%
    as.data.frame %>%
    mutate(year = V1 %/% 100,
           month = V1 %% 100,
           V1 = as.yearmon(paste(year, month, sep = "-"))) %>%
    dplyr::select(-year, -month)
  
  if (!is.null(colnames)) names(dt) <- colnames else names(dt)[1] <- "date"
  
  file.remove(paste0(series, ".txt"))
  return(dt)
}

# FF 3 factors ----------------

FF3 <- DownloadFF("F-F_Research_Data_Factors", colnames1)
save(FF3, file = "../FF3.RData")

# FF 5 factors ----------------

FF5 <- DownloadFF("F-F_Research_Data_5_Factors_2x3", colnames2)
save(FF5, file = "../FF5.RData")

# Portfolios formed on ME ----------------

FF_ME <- DownloadFF("Portfolios_Formed_on_ME", colnames3)
save(FF_ME, file = "../FF_ME.RData")

# Portfolios formed on BE-ME ----------------

FF_BEME <- DownloadFF("Portfolios_Formed_on_BE-ME", colnames3)
save(FF_BEME, file = "../FF_BEME.RData")

# Portfolios formed on INV ----------------

FF_INV <- DownloadFF("Portfolios_Formed_on_INV", colnames4)
save(FF_INV, file = "../FF_INV.RData")

# Portfolios formed on OP ----------------

FF_OP <- DownloadFF("Portfolios_Formed_on_OP", colnames4)
save(FF_OP, file = "../FF_OP.RData")

# Portfolios formed on AC (Accruals) ----------------

FF_AC <- DownloadFF("Portfolios_Formed_on_AC", colnames5)
save(FF_AC, file = "../FF_AC.RData")

# Portfolios formed on BETA ----------------

FF_BETA <- DownloadFF("Portfolios_Formed_on_BETA", colnames5)
save(FF_BETA, file = "../FF_BETA.RData")

# Portfolios formed on NI (Net Issuances) ----------------

FF_NI <- DownloadFF("Portfolios_Formed_on_NI", colnames6)
save(FF_NI, file = "../FF_NI.RData")

# Portfolios formed on VAR (Variance) ----------------

FF_VAR <- DownloadFF("Portfolios_Formed_on_VAR", colnames6)
save(FF_VAR, file = "../FF_VAR.RData")

# Portfolios formed on RESVAR (Residual Variance) ----------------

FF_RESVAR <- DownloadFF("Portfolios_Formed_on_RESVAR", colnames5)
save(FF_RESVAR, file = "../FF_RESVAR.RData")

# Momentum Factor (Mom) --------------

FF_MOMENTUM <- DownloadFF("F-F_Momentum_Factor", colnames7)
save(FF_MOMENTUM, file = "../FF_MOMENTUM.RData")

# FF_MOM6 (Mom) --------------

FF_MOM6 <- DownloadFF("6_Portfolios_ME_Prior_12_2", colnames8)
save(FF_MOM6, file = "../FF_MOM6.RData")

# Momentum Factor (Mom) --------------

FF_SIZEMOM25 <- DownloadFF("25_Portfolios_ME_Prior_12_2", colnames9)
save(FF_SIZEMOM25, file = "../FF_SIZEMOM25.RData")

# Momentum Factor (Mom) --------------

FF_MOM10 <- DownloadFF("10_Portfolios_Prior_12_2", colnames10)
save(FF_MOM10, file = "../FF_MOM10.RData")

