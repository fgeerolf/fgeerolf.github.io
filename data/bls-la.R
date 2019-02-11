rm(list = ls())
pklist <- c("tidyverse", "curl", "fredr", "data.table", 
            "pryr", "benchmarkme", "rvest")
source("https://fgeerolf.github.io/code/load-packages.R")

cat("Model:", get_cpu()$model_name, 
    "\nMemory:", round(get_ram()/2^30, digits = 3), 
    "Go\nNumber of cores:", get_cpu()$no_of_cores, 
    "\nStart: ", format(Sys.time(), "%a %b %d, %Y - %X"), "\n")

datasets <- read_html("https://download.bls.gov/pub/time.series/la/") %>% 
  html_nodes("a") %>%
  html_text(trim = TRUE) %>%
  as.data.frame %>%
  rename(X0 = ".") %>%
  cbind(read_html("https://download.bls.gov/pub/time.series/la/") %>%
          str_match_all("<a href=\"(.*?)\"") %>%
          as.data.frame %>%
          mutate(X2 = paste0("https://download.bls.gov", X2))) %>%
  mutate_all(paste)

options(tibble.print_max = 100)
datasets %>% as_tibble %>% print

for (i in 2:81){
  file <- datasets[i, "X0"]
  cat("Downloading from BLS Website LA:", file, "\n")
  assign(file, datasets[i, "X2"] %>% fread)
  do.call(save, list(file, file = paste0(file, ".RData")))
}

# la.data.0 ---------------

`la.data.0.CurrentU05-09` <- `la.data.0.CurrentU05-09` %>%
  mutate(value = value %>% as.numeric) # For some reason value was a character

la.data.0 <- `la.data.0.CurrentU90-94` %>%
  bind_rows(`la.data.0.CurrentU95-99`) %>%
  bind_rows(`la.data.0.CurrentU00-04`) %>%
  bind_rows(`la.data.0.CurrentU05-09`) %>%
  bind_rows(`la.data.0.CurrentU10-14`) %>%
  bind_rows(`la.data.0.CurrentU15-19`)

save(la.data.0, file = "la.data.0.RData")
