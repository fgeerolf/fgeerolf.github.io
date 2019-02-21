pklist <- c("tidyverse", "curl", "fredr", "data.table")
source("http://fgeerolf.com/code/load-packages.R")

CountyCrossWalk_Zillow <- "http://files.zillowstatic.com/research/public/CountyCrossWalk_Zillow.csv" %>%
  fread

save(CountyCrossWalk_Zillow, file = "CountyCrossWalk_Zillow.RData")
