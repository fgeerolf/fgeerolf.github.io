pklist <- c("tidyverse", "curl", "fredr", "data.table")
source("http://fgeerolf.com/code/load-packages.R")

curl_download("http://files.zillowstatic.com/research/public/County.zip", 
              destfile = "County.zip", 
              quiet = FALSE)
unzip("County.zip")
unlink("County.zip")
list_files_csv <- list.files(path = "County")
list_files <- list_files_csv %>% str_sub(., 1, -5)
list_files

for (file in list_files){
  cat("Loading:", file, "\n")
  assign(file, paste0("County/", file, ".csv") %>% 
           fread %>% 
           gather(date, value, matches("[0-9][0-9][0-9][0-9]-[0-9][0-9]")))
  do.call(save, list(file, file = paste0(file, ".RData")))
  rm(list = file)
}

unlink("County", recursive = TRUE)