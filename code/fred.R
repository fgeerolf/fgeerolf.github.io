rm(list = ls())
pklist <- c("tidyverse", "fredr", "lubridate")
source("https://fgeerolf.github.io/datasets/load-packages.R")

fredr_set_key("564a4e78cdf46ceeaf913616a77a13cb")

fred <- map_dfr(c("UNRATE", 
                  "FEDFUNDS",
                  "CSUSHPINSA",
                  "MDSP"), 
                fredr)

save(fred, file = "fred.RData")
