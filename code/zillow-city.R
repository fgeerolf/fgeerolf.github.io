pklist <- c("tidyverse", "curl", "fredr", "data.table")
source("http://fgeerolf.com/code/load-packages.R")

curl_download("http://files.zillowstatic.com/research/public/City.zip", 
              destfile = "City.zip", 
              quiet = FALSE)
unzip("City.zip")
unlink("City.zip")
list_files_csv <- list.files(path = "City")
list_files <- list_files_csv %>% str_sub(., 1, -5)
list_files

for (file in list_files){
  cat("Loading:", file, "\n")
  assign(file, paste0("City/", file, ".csv") %>% 
           fread %>% 
           gather(date, value, matches("[0-9][0-9][0-9][0-9]-[0-9][0-9]")))
  do.call(save, list(file, file = paste0(file, ".RData")))
  rm(list = file)
}

unlink("City", recursive = TRUE)
