library(ggplot2)
library(ggridges)
library(tidyverse)
library(httr)
library(htmltools)
library(rvest)
library(stringr)

setwd("/Users/GreenTea/Projects/")
dir <- getwd()

# scrape ICO data
ico_base_url <- "https://www.ico.org/new_historical.asp"
ico_page_code <- read_html(base_url)

# download and import USDA Foreign Agricultural Service data
usda_fas_url <- "https://apps.fas.usda.gov/psdonline/downloads/psd_coffee_csv.zip"
download.file(url = usda_fas_url, destfile = "psd_coffee_csv.zip", method = "auto")
zip_file <- list.files(path = dir, pattern = ".zip")
unzip(zipfile = zip_file, exdir = dir)
file.remove(paste0(dir, zip_file))
unzipped_file <- list.files(path = dir, pattern = "psd_coffee.csv")
unzipped_file_path <- paste0(dir, "/", unzipped_file)
dat <- read_csv(unzipped_file_path)
glimpse(dat)

# split USDA data into separate datasets by Attribute_Description
dat_a_prod <- dat %>% filter(Attribute_Description == "Arabica Production")
  
dat_r_prod <- dat %>% filter(Attribute_Description == "Robusta Production")

dat_export <- dat %>% filter(Attribute_Description == "Bean Exports")

dat_import <- dat %>% filter(Attribute_Description == "Bean Imports")