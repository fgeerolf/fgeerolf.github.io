rm(list = ls())
pklist <- c("tidyverse", "curl", "fredr", "data.table", "pryr", "benchmarkme")
source("https://fgeerolf.github.io/code/load-packages.R")

cat("Model:", get_cpu()$model_name, 
    "\nMemory:", round(get_ram()/2^30, digits = 3), 
    "Go\nNumber of cores:", get_cpu()$no_of_cores, 
    "\nStart: ", format(Sys.time(), "%a %b %d, %Y - %X"), "\n")

names <- c("11incyallagi", "irs_2011", 
           "12cyallagi", "irs_2012", 
           "13incyallagi", "irs_2013", 
           "14incyallagi", "irs_2014",
           "15incyallagi", "irs_2015",
           "16incyallagi", "irs_2016") %>%
  matrix(byrow = TRUE, ncol = 2)

# IRS (2011 - 2016) ----------

for (i in 1:nrow(names)){
  cat("\nDownloading", names[i, 1], "and saving as", names[i, 2], "\n")
  assign(names[i, 2], names[i, 1] %>%
           paste0("https://www.irs.gov/pub/irs-soi/", ., ".csv") %>%
           fread)
  do.call(save, list(names[i, 2], file = paste0(names[i, 2], ".RData")))
}

irs_2011 %>% str
irs_2011 %>% head

# Zipcode (2005 - 2016) ----------

for (year in 2005:2016){
  cat("\nDownloading Zipcode from year", year, "\n")
  assign(paste0("zipcode_", year), paste0(year) %>%
           paste0("http://www.nber.org/tax-stats/zipcode/", ., "/zipcode", ., ".csv") %>%
           fread)
  do.call(save, list(paste0("zipcode_", year), file = paste0("zipcode", year, ".RData")))
}