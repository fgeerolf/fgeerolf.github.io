pklist <- c("tidyverse", "data.table", "readstata13")
source("http://fgeerolf.com/code/load-packages.R")

# pwt.9.0 ------

pwt.9.0 <- read.dta13("http://www.rug.nl/ggdc/docs/pwt90.dta")

save(pwt.9.0, file = "pwt.9.0.RData")

# pwt.9.0.long ------

pwt.9.0.long <- pwt.9.0 %>%
  gather(variable, value, -countrycode, -country, -currency_unit, -year) %>%
  left_join(matrix(c(names(pwt.9.0)[c(-1,-2,-3,-4)],
                     attr(pwt.9.0, "var.labels")[c(-1,-2,-3,-4)]), ncol = 2) %>%
              as.data.frame %>%
              rename(variable = V1, variable.desc1 = V2) %>%
              mutate(variable = variable %>% as.character), 
            by = "variable") %>%
  filter(!is.na(value)) %>%
  mutate_at(vars(-value), funs(as.factor)) %>%
  mutate(value = value %>% as.numeric) %>%
  select(countrycode, country, currency_unit, year, variable, variable.desc1, value) %>%
  as.tibble

save(pwt.9.0.long, file = "pwt.9.0.long.RData")
