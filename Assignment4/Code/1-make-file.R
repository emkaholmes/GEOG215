####
#### Assignment #4, GEOG215
#### Introduction to Spatial Data Science
####
#### R code to automate the preparation,
####   analysis, and presentation
####
#### Emma Holmes
#### March 6, 2023
####

## First step
## Read and execute Data Prep Code, GEOG215-data-prep.R
source("Code/GEOG215-data-prep.R")

## Second step
## Read and execute Data Analysis Code, GEOG215-data-analysis
source("Code/GEOG215-data-analysis.R")

## Third step
## Knit your R Markdown file
rmarkdown::render("Code/GEOG215-data-presentation.Rmd", 
                  output_file=here("Output/GEOG215-data-presentation-auto-v2.html"))

                  