pklist <- c("tidyverse", "data.table", "curl")
source("https://fgeerolf.github.io/code/load-packages.R")

cat("Model:", get_cpu()$model_name, 
    "\nMemory:", round(get_ram()/2^30, digits = 3), 
    "Go\nNumber of cores:", get_cpu()$no_of_cores, 
    "\nStart: ", format(Sys.time(), "%a %b %d, %Y - %X"), "\n")

curl_download("https://www.ffiec.gov/hmdarawdata/LAR/National/2016HMDALAR%20-%20National.zip",
              destfile = "2016HMDALAR - National.zip",
              quiet = FALSE)

unzip("2016HMDALAR - National.zip")

hmda_2016 <- "2016HMDALAR - National.csv" %>%
  fread

unlink("2016HMDALAR - National.csv")
unlink("2016HMDALAR - National.zip")

save(hmda_2016, file = "hmda_2016.RData")
