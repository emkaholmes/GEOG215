####
#### Assignment #4, GEOG215
#### Introduction to Spatial Data Science
####
#### R code for data preparation
####   Imports, fixes, cleans raw data
####
#### Emma Holmes
#### March 5, 2023
####

##########################                      
####  Load libraries  ####
##########################
library(sf)
library(tidyverse)
library(rmapshaper)
library(readxl)

########################      
####  Read in data  ####
########################   
# Read in North Carolina Zip Code spatial data layer
nc.zip <- st_read("Data/sp/NC_ZIP_2020.shp")

# Read in North Carolina population data
nc.zip.pop <- read_excel("Data/tabular/Population data.xlsx")

# Read in North Carolina COVID data
nc.zip.cvd <- read_csv("Data/tabular/new_NC_COVID_2020-09-23_ZIP.csv")

########################
####  Process data  ####
######################## 
# Simplify geometry of Zip Code spatial data layer
# for mapping purposes
nc.zip <- ms_simplify(input = as(nc.zip, 'Spatial')) %>%
  st_as_sf()

# Make spatial data layer valid (just a good habit using sf objects)
nc.zip <- st_make_valid(nc.zip)

#Isolate columns 1, 4, and 5 in nc.zip
nc.zip <- nc.zip[,-c(1,4,5)]

# Write out spatial data layer
st_write(nc.zip, 
         "Output/NC_ZIP_2020_mapping.shp", 
         append = FALSE)

# Set the column names in nc.zip.pop
names(nc.zip.pop) <- c("ZIPCODE", "POP")

# Isolate columns 2, 4, and 5 in nc.zip.cvd
nc.zip.cvd <- nc.zip.cvd[,c(2,4,5)]

# Set the column names in nc.zip.cvd
names(nc.zip.cvd) <- c("ZIPCODE", "CASES", "DEATHS")

#Joined nc.zip.cvd and nc.zip.pop through the column "ZIPCODE"
nc.zip.cvd.pop <- merge(nc.zip.pop, 
                        nc.zip.cvd, 
                        by = "ZIPCODE")

############################# 
####  Write out results  ####
############################# 
# Write out tabular data
write_csv(nc.zip.cvd.pop, 
          "Output/NC_ZIP_COVID_POP_2020-09-23.csv")
