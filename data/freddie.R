pklist <- c("tidyverse", "data.table")
source("http://fgeerolf.com/code/load-packages.R")

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
