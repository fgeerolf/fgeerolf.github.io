rm(list = ls())
pklist <- c("tidyverse", "rvest", "curl", "gdata", 
            "pryr", "benchmarkme", "utils", "data.table")
source("https://fgeerolf.github.io/code/load-packages.R")
options(tibble.print_max = 100)

cat("Model:", get_cpu()$model_name, 
    "\nMemory:", round(get_ram()/2^30, digits = 3), 
    "Go\nNumber of cores:", get_cpu()$no_of_cores, 
    "\nStart: ", format(Sys.time(), "%a %b %d, %Y - %X"), "\n")


# SIC- based (1975-2000) ----------------------

for (year in 1975:2000){
  # year <- 1975
  cat("\nCurrently downloading BLS, SIC", year, 
      "/ Memory use:", round(mem_used()/2^20), "Mo", 
      "/ Time:", format(Sys.time(), "%a %b %d, %Y - %X"), "\n")
  
  curl_download(url = paste0("https://data.bls.gov/cew/data/files/", year, "/sic/csv/sic_", year, "_qtrly_singlefile.zip"),
                destfile = paste0("sic_", year, "_qtrly_singlefile.zip"),
                quiet = FALSE, 
                mode = "wb")
  
  unzip(paste0("sic_", year, "_qtrly_singlefile.zip"))
  unlink(paste0("sic_", year, "_qtrly_singlefile.zip"))
  
  assign(paste0("sic_", year), fread(paste0("sic.", year, ".q1-q4.singlefile.csv")))
  unlink(paste0("sic.", year, ".q1-q4.singlefile.csv"))
  
  save(list = paste0("sic_", year), file = paste0("sic_", year, ".RData"))
  rm(list = paste0("sic_", year))
  gc()
}

# NAICS - based (1990-2018) ----------------------

for (year in 1990:2018){
  
  cat("\nCurrently downloading BLS, NAICS", year, 
      "/ Memory use:", round(mem_used()/2^20), "Mo", 
      "/ Time:", format(Sys.time(), "%a %b %d, %Y - %X"), "\n")
  
  curl_download(url = paste0("https://data.bls.gov/cew/data/files/", year, "/csv/", year, "_qtrly_singlefile.zip"),
                destfile = paste0(year, "_qtrly_singlefile.zip"),
                quiet = FALSE, 
                mode = "wb")
  
  unzip(paste0(year, "_qtrly_singlefile.zip"))
  unlink(paste0(year, "_qtrly_singlefile.zip"))
  
  assign(paste0("naics_", year), fread(paste0(year, ".q1-q4.singlefile.csv")))
  unlink(paste0(year, ".q1-q4.singlefile.csv"))
  
  save(list = paste0("naics_", year), file = paste0("naics_", year, ".RData"))
  rm(list = paste0("naics_", year))
  gc()
}
