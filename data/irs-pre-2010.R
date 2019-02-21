pklist <- c("tidyverse", "curl", "fredr", "data.table")
source("http://fgeerolf.com/code/load-packages.R")


clean_state_2003 <- function(data){
  temp <- data %>%
    read.xls %>%
    slice(5:n()) %>%
    select(1:9)
  names(temp) <- c("stateFIPS", "countyFIPS", "county", "returns",
                   "exemptions", "agi", "wages", "dividends", "interest")
  temp <- temp %>%
    mutate_at(vars(-county), funs(gsub(",", "", .) %>% as.numeric(.))) %>%
    mutate(county = county %>% as.character)
  return(temp)
}


clean_state_2006 <- function(data){
  temp <- data %>%
    read.xls %>%
    slice(5:n()) %>%
    select(2:10)
  names(temp) <- c("stateFIPS", "countyFIPS", "county", "returns",
                   "exemptions", "agi", "wages", "dividends", "interest")
  temp <- temp %>%
    mutate_at(vars(-county), funs(gsub(",", "", .) %>% as.numeric(.))) %>%
    mutate(county = county %>% as.character)
  return(temp)
}


clean_state_2007 <- function(data){
  temp <- data %>%
    read.xls %>%
    slice(7:n()) %>%
    select(1:9)
  names(temp) <- c("stateFIPS", "countyFIPS", "county", "returns",
                   "exemptions", "agi", "wages", "dividends", "interest")
  temp <- temp %>%
    mutate_at(vars(-county), funs(gsub(",", "", .) %>% as.numeric(.))) %>%
    mutate(county = county %>% as.character) %>%
    filter(!is.na(stateFIPS))
  return(temp)
}

clean_state_2009 <- function(data){
  temp <- data %>%
    read.xls %>%
    slice(7:n()) %>%
    select(1:9)
  names(temp) <- c("stateFIPS", "countyFIPS", "county", "returns",
                   "exemptions", "agi", "wages", "dividends", "interest")
  temp <- temp %>%
    mutate_at(vars(-county), funs(gsub(",", "", .) %>% as.numeric(.))) %>%
    mutate(county = county %>% as.character) %>%
    filter(!is.na(stateFIPS))
  return(temp)
}

# 2004 ----------

curl_download(url = "https://www.irs.gov/pub/irs-soi/2004countyincome.zip",
              destfile = "2004countyincome.zip",
              quiet = FALSE)

unzip("2004countyincome.zip")
unlink("2004countyincome.zip")

list_files <- list.files(pattern = "\\.xls", recursive = TRUE)

irs_2004 <- lapply(list_files, clean_state_2006) %>%
  bind_rows

unlink(list_files)

save(irs_2004, file = "irs_2004.RData")

# 2005 ----------

curl_download(url = "https://www.irs.gov/pub/irs-soi/2005countyincome.zip",
              destfile = "2005countyincome.zip",
              quiet = FALSE)

unzip("2005countyincome.zip")
unlink("2005countyincome.zip")

list_files <- list.files(pattern = "\\.xls", recursive = TRUE)

list_files[1] %>% read.xls

irs_2005 <- lapply(list_files, clean_state_2006) %>%
  bind_rows

unlink(list_files)

save(irs_2005, file = "irs_2005.RData")

# 2006 ----------

curl_download(url = "https://www.irs.gov/pub/irs-soi/2006countyincome.zip",
              destfile = "2006countyincome.zip",
              quiet = FALSE)

unzip("2006countyincome.zip")
unlink("2006countyincome.zip")

list_files <- list.files(pattern = "\\.xls", recursive = TRUE)


irs_2006 <- lapply(list_files, clean_state_2006) %>%
  bind_rows

unlink(list_files)

save(irs_2006, file = "irs_2006.RData")

# 2007 ----------

curl_download(url = "https://www.irs.gov/pub/irs-soi/2007countyincome.zip",
              destfile = "2007countyincome.zip",
              quiet = FALSE)

unzip("2007countyincome.zip")
unlink("2007countyincome.zip")

list_files <- list.files(pattern = "\\.xls", recursive = TRUE)

list_files[1] %>% clean_state_2006()

irs_2007 <- lapply(list_files, clean_state_2006) %>%
  bind_rows

unlink(list_files)

save(irs_2007, file = "irs_2007.RData")

# 2008 ----------

curl_download(url = "https://www.irs.gov/pub/irs-soi/2008countyincome.zip",
              destfile = "2008countyincome.zip",
              quiet = FALSE)

unzip("2008countyincome.zip")
unlink("2008countyincome.zip")

list_files <- list.files(pattern = "\\.xls", recursive = TRUE)

list_files[1] %>% clean_state_2009()

irs_2008 <- lapply(list_files, clean_state_2009) %>%
  bind_rows

unlink(list_files)

save(irs_2008, file = "irs_2008.RData")


# 2009 ----------

curl_download(url = "https://www.irs.gov/pub/irs-soi/2009countyincome.zip",
              destfile = "2009countyincome.zip",
              quiet = FALSE)

unzip("2009countyincome.zip")
unlink("2009countyincome.zip")

list_files <- list.files(pattern = "\\.xls", recursive = TRUE)

irs_2009 <- lapply(list_files, clean_state_2009) %>%
  bind_rows

unlink(list_files)

save(irs_2009, file = "irs_2009.RData")


# 2010 ----------

curl_download(url = "https://www.irs.gov/pub/irs-soi/2010countydata.zip",
              destfile = "2010countydata.zip",
              quiet = FALSE)

unzip("2010countydata.zip")
unlink("2010countydata.zip")

list_files <- list.files(pattern = "\\.csv", recursive = TRUE)

irs_2010 <- "10incyallagi.csv" %>%
  fread

unlink(list_files)

save(irs_2010, file = "irs_2010.RData")
