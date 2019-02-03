rm(list = ls())
pklist <- c("tidyverse", "curl", "fredr", "data.table", "pryr", "benchmarkme")
source("https://fgeerolf.github.io/code/load-packages.R")

cat("Model:", get_cpu()$model_name, 
    "\nMemory:", round(get_ram()/2^30, digits = 3), 
    "Go\nNumber of cores:", get_cpu()$no_of_cores, 
    "\nStart: ", format(Sys.time(), "%a %b %d, %Y - %X"), "\n")

CountyCrossWalk_Zillow <- "http://files.zillowstatic.com/research/public/CountyCrossWalk_Zillow.csv" %>%
  fread %>%
  select(CountyRegionID_Zillow, fips = FIPS)

save(CountyCrossWalk_Zillow, file = "CountyCrossWalk_Zillow.RData")

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
           gather(variable, value, matches("[0-9][0-9][0-9][0-9]-[0-9][0-9]")))
  do.call(save, list(file, file = paste0(file, ".RData")))
  rm(list = file)
}

unlink("County", recursive = TRUE)