pklist <- c("tidyverse", "curl", "fredr", "data.table")
source("http://fgeerolf.com/code/load-packages.R")

curl_download("http://files.zillowstatic.com/research/public/Zip.zip", 
              destfile = "Zip.zip", 
              quiet = FALSE)
unzip("Zip.zip")
unlink("Zip.zip")
list_files_csv <- list.files(path = "Zip")
list_files <- list_files_csv %>% str_sub(., 1, -5)
list_files

for (file in list_files){
  cat("Loading:", file, "\n")
  assign(file, paste0("Zip/", file, ".csv") %>% 
           fread %>% 
           gather(date, value, matches("[0-9][0-9][0-9][0-9]-[0-9][0-9]")))
  do.call(save, list(file, file = paste0(file, ".RData")))
  rm(list = file)
}

unlink("Zip", recursive = TRUE)
