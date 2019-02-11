pklist <- c("tidyverse", "gdata")
source("https://fgeerolf.github.io/code/load-packages.R")

cat("Model:", get_cpu()$model_name, 
    "\nMemory:", round(get_ram()/2^30, digits = 3), 
    "Go\nNumber of cores:", get_cpu()$no_of_cores, 
    "\nStart: ", format(Sys.time(), "%a %b %d, %Y - %X"), "\n")

# shiller -----------

shiller <- "http://www.econ.yale.edu/~shiller/data/ie_data.xls" %>%
  read.xls(skip = 6) %>%
  head(-1) %>% # remove last obs
  mutate(CPI = CPI %>% as.numeric(CPI))

save(shiller, file = "shiller.RData")
