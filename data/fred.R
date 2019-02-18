pklist <- c("tidyverse", "fredr", "lubridate")
source("http://fgeerolf.com/code/load-packages.R")

fredr_set_key(fred_key) # fred_key <- "Your FRED Key"

fred <- map_dfr(c("UNRATE", 
                  "FEDFUNDS",
                  "CSUSHPINSA",
                  "MDSP"), 
                fredr)

save(fred, file = "fred.RData")
