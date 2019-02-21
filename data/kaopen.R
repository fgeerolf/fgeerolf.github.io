pklist <- c("tidyverse", "data.table", "readstata13")
source("http://fgeerolf.com/code/load-packages.R")

# kaopen_2015 -------

kaopen_2015 <- read.dta13("http://web.pdx.edu/~ito/kaopen_2015.dta")

save(kaopen_2015, file = "kaopen_2015.RData")

# trilemma -------

trilemma <- "trilemma_indexes_update2014.csv" %>%
  fread

save(trilemma, file = "trilemma.RData")
