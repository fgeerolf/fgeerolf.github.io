rm(list = ls())
pklist <- c("curl", "tidyverse", "data.table", "benchmarkme", "pryr")
source("https://fgeerolf.github.io/code/load-packages.R")

cat("Model:", get_cpu()$model_name, 
    "\nMemory:", round(get_ram()/2^30, digits = 3), 
    "Go\nNumber of cores:", get_cpu()$no_of_cores, 
    "\nStart: ", format(Sys.time(), "%a %b %d, %Y - %X"), "\n")

for (year in 1986:2016){
  yearD <- year %>% paste %>% substr(3, 4)
  
  cat("CBP", year, ": Currently downloading...\n")
  curl_download(paste0("https://www2.census.gov/programs-surveys/cbp/datasets/", year, "/cbp", yearD, "co.zip"), 
                destfile = paste0("cbp", yearD, "co.zip"), 
                quiet = FALSE, 
                mode = "wb")
  unzip(paste0("cbp", yearD, "co.zip"))
  unlink(paste0("cbp", yearD, "co.zip"))
  
  cat("Reading...")
  
  if (!year %in% c(2002, 2007)){
    assign(paste0("cbp_", year), fread(paste0("cbp", yearD, "co.txt")))
  } else{
    assign(paste0("cbp_", year), fread(paste0("Cbp", yearD, "co.txt")))
  }
  
  unlink(paste0("cbp", yearD, "co.txt"))
  
  cat(" Saving...\n")
  save(list = paste0("cbp_", year), file = paste0("cbp_", year, ".RData"))
  rm(list = paste0("cbp_", year))
}
