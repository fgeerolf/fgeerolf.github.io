pklist <- c("tidyverse", "curl", "readstata13")
source("http://fgeerolf.com/code/load-packages.R")

# DPI 2015 ---------

curl_download(url = "https://publications.iadb.org/bitstream/handle/11319/7408/The-Database-of-Political-Institutions-2015-DPI2015.zip",
              "database.zip",
              quiet = FALSE)
unzip("database.zip")
unlink("database.zip")
DPI2015 <- read.dta13("DPI2015/DPI2015.dta")
unlink("DPI2015", recursive = TRUE)

save(DPI2015, file = "DPI2015.RData")
