rm(list = ls())
pklist <- c("tidyverse", "data.table", "pryr", "benchmarkme")
source("https://fgeerolf.github.io/code/load-packages.R")

cat("Model:", get_cpu()$model_name, 
    "\nMemory:", round(get_ram()/2^30, digits = 3), 
    "Go\nNumber of cores:", get_cpu()$no_of_cores, 
    "\nStart: ", format(Sys.time(), "%a %b %d, %Y - %X"), "\n")

# freddie ---------

freddie <- "http://www.freddiemac.com/research/docs/fmhpi_master_file.csv" %>%
  fread %>%
  mutate(date = Year + (Month-1)/12) %>%
  select(-Year, -Month)

save(freddie, file = "freddie.RData")

# freddie_msa ---------

freddie_msa <- freddie %>%
  filter(GEO_Type == "CBSA")

save(freddie_msa, file = "freddie_msa.RData")
