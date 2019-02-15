pklist <- c("tidyverse", "data.table", "pryr", "benchmarkme", 
            "readxl", "curl", "stringr", "readstata13")
source("https://fgeerolf.github.io/code/load-packages.R")

cat("Model:", get_cpu()$model_name, 
    "\nMemory:", round(get_ram()/2^30, digits = 3), 
    "Go\nNumber of cores:", get_cpu()$no_of_cores, 
    "\nStart: ", format(Sys.time(), "%a %b %d, %Y - %X"), "\n")

kaopen_2015 <- read.dta13("http://web.pdx.edu/~ito/kaopen_2015.dta")

save(kaopen_2015, file = "kaopen_2015.RData")
