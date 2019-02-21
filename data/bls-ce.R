pklist <- c("tidyverse", "curl", "fredr", "data.table", "rvest")
source("http://fgeerolf.com/code/load-packages.R")

datasets <- read_html("https://download.bls.gov/pub/time.series/ce/") %>% 
  html_nodes("a") %>%
  html_text(trim = TRUE) %>%
  as.data.frame %>%
  rename(X0 = ".") %>%
  cbind(read_html("https://download.bls.gov/pub/time.series/ce/") %>%
          str_match_all("<a href=\"(.*?)\"") %>%
          as.data.frame %>%
          mutate(X2 = paste0("https://download.bls.gov", X2))) %>%
  mutate_all(paste)

datasets %>% as.tibble %>% print

for (i in 3:64){
  file <- datasets[i, "X0"]
  cat("\nDownloading from BLS Website - Current Employment Statistics:", file)
  assign(file, fread(datasets[i, "X2"], sep = "\t"))
  do.call(save, list(file, file = paste0(file, ".RData")))
}
