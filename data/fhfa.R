rm(list = ls())
pklist <- c("tidyverse", "curl", "fredr", "data.table", "pryr", "benchmarkme")
source("https://fgeerolf.github.io/code/load-packages.R")

cat("Model:", get_cpu()$model_name, 
    "\nMemory:", round(get_ram()/2^30, digits = 3), 
    "Go\nNumber of cores:", get_cpu()$no_of_cores, 
    "\nStart: ", format(Sys.time(), "%a %b %d, %Y - %X"), "\n")

# fhfa --------

fhfa <- "https://www.fhfa.gov/DataTools/Downloads/Documents/HPI/HPI_master.csv" %>%
  fread

save(fhfa, file = "fhfa.RData")

# fhfa_monthly --------

fhfa_monthly <-  fhfa %>%
  filter(frequency == "monthly") %>%
  mutate(date = yr + (period - 1)/12) %>%
  select(-yr, -period)

save(fhfa_monthly, file = "fhfa_monthly.RData")

# fhfa_quarterly --------

fhfa_quarterly <-  fhfa %>%
  filter(frequency == "quarterly",
         hpi_type == "traditional",
         hpi_flavor == "all-transactions") %>%
  mutate(date = yr + (period - 1)/4) %>%
  select(-yr, -period) %>%
  filter(level == "MSA") %>%
  select(place_name, place_id, date, index_nsa, index_sa)

save(fhfa_quarterly, file = "fhfa_quarterly.RData")
