pklist <- c("tidyverse", "fredr")
source("https://fgeerolf.github.io/code/load-packages.R")

fredr_set_key(fred_key)

fred <- map_dfr(c("UNRATE", 
                  "FEDFUNDS",
                  "CSUSHPINSA",
                  "MDSP"), 
                fredr)

save(fred, file = "fred.RData")
