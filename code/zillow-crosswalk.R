rm(list = ls())
pklist <- c("tidyverse", "curl", "fredr", "data.table", "pryr", "benchmarkme")
source("https://fgeerolf.github.io/code/load-packages.R")

cat("Model:", get_cpu()$model_name, 
    "\nMemory:", round(get_ram()/2^30, digits = 3), 
    "Go\nNumber of cores:", get_cpu()$no_of_cores, 
    "\nStart: ", format(Sys.time(), "%a %b %d, %Y - %X"), "\n")


CountyCrossWalk_Zillow <- "http://files.zillowstatic.com/research/public/CountyCrossWalk_Zillow.csv" %>%
  fread

save(CountyCrossWalk_Zillow, file = "CountyCrossWalk_Zillow.RData")
