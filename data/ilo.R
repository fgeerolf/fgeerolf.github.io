pklist <- c("tidyverse", "data.table", "benchmarkme", "pryr")
source("https://fgeerolf.github.io/code/load-packages.R")

cat("Model:", get_cpu()$model_name,
    "\nMemory:", round(get_ram()/2^30, digits = 3),
    "Go\nNumber of cores:", get_cpu()$no_of_cores,
    "\nStart: ", format(Sys.time(), "%a %b %d, %Y - %X"), "\n")

# List Datasets ---------

url.folder <- "https://www.ilo.org/ilostat-files/WEB_bulk_download/indicator/"
file <- "table_of_contents_en.csv"

datasets <- paste0(url.folder, file) %>%
  fread

save(datasets, file = "datasets.RData")

# Example 1 ---------

file <- "EMP_TSRV_NOC_RT_A.csv.gz"

data_manuf <- paste0(url.folder, file) %>%
  fread

save(data_manuf, file = "data_manuf.RData")

# Example 2 ----------

file <- "UNE_TUNE_SEX_AGE_DUR_NB_Q.csv.gz"

data_unemp <- paste0(url.folder, file) %>%
  fread

save(data_unemp, file = "data_unemp.RData")
