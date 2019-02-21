pklist <- c("tidyverse", "gdata")
source("http://fgeerolf.com/code/load-packages.R")

# shiller -----------

shiller <- "http://www.econ.yale.edu/~shiller/data/ie_data.xls" %>%
  read.xls(skip = 6) %>%
  head(-1) %>% # remove last obs
  mutate(CPI = CPI %>% as.numeric(CPI))

save(shiller, file = "shiller.RData")
