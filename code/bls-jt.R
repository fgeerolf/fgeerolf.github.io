rm(list = ls())
pklist <- c("tidyverse", "curl", "fredr", "data.table", "pryr", "benchmarkme", "rvest")
source("https://fgeerolf.github.io/code/load-packages.R")

cat("Model:", get_cpu()$model_name, 
    "\nMemory:", round(get_ram()/2^30, digits = 3), 
    "Go\nNumber of cores:", get_cpu()$no_of_cores, 
    "\nStart: ", format(Sys.time(), "%a %b %d, %Y - %X"), "\n")

datasets <- read_html("https://download.bls.gov/pub/time.series/jt/") %>% 
  html_nodes("a") %>%
  html_text(trim = TRUE) %>%
  as.data.frame %>%
  rename(X0 = ".") %>%
  cbind(read_html("https://download.bls.gov/pub/time.series/jt/") %>%
          str_match_all("<a href=\"(.*?)\"") %>%
          as.data.frame %>%
          mutate(X2 = paste0("https://download.bls.gov", X2))) %>%
  mutate_all(paste)

datasets %>% as_tibble

for (i in 2:18){
  file <- datasets[i, "X0"]
  cat("Downloading from BLS Website JOLTS:", file, "\n")
  assign(file, datasets[i, "X2"] %>% fread)
  do.call(save, list(file, file = paste0(file, ".RData")))
}
