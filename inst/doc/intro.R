## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(messy.cats)
library(dplyr)
library(stringdist)
library(varhandle)
library(rapportools)
library(gt)

## ----car lists----------------------------------------------------------------
cars_bad = c("teal Mazda RX4", "black Mazda RX4 Wag",
             "green Datsun 710", "Hornet 4 Drive",
           "green Hornet Sportabout", "Valiant",
           "Duster 360", "orange Merc 240D",
           "Merc 230", "teal Merc 280",
           "Merc 280C", "green Merc 450SE",
           "Merc 450SL", "blue Merc 450SLC",
           "green Cadillac Fleetwood", "Lincoln Continental",
           "Chrysler Imperial")

cars_good = c("Mazda RX4", "Mazda RX4 Wag",
              "Datsun 710", "Hornet 4 Drive",
           "Hornet Sportabout", "Valiant",
           "Duster 360", "Merc 240D",
           "Merc 230", "Merc 280",
           "Merc 280C", "Merc 450SE",
           "Merc 450SL", "Merc 450SLC",
           "Cadillac Fleetwood", "Lincoln Continental",
           "Chrysler Imperial")


## ----first cat_match example--------------------------------------------------
cat_match(cars_bad, cars_good, method = "jw")

## ----cat_replace ex-----------------------------------------------------------
cat_replace(cars_bad, cars_good, method = "jw")

## ----cat_join ex--------------------------------------------------------------
bad_cars_df = data.frame(car = cars_bad, state_registration = "CA")
good_cars_df= data.frame(car = cars_good, insur_comp = "All State")

head(bad_cars_df)
head(good_cars_df)

cat_join(bad_cars_df, good_cars_df, by="car", method="jw", join="left")

## ----not perfect matches------------------------------------------------------
messy_short <-         c("Fiat 128",
           "red Honda Civic", "Toyota Corolla",
           "Toyota Corona", "Dodge Challenger",
           "red AMC Javelin", "Camaro Z28",
           "Pontiac Firebird", "black Fiat X1-9",
           "blue Porsche 914-2", "Lotus Europa",
           "Ford Pantera L", "black Ferrari Dino",
           "black Maserati Bora", "black Volvo 142E")


clean_short <-       c(
           "Honda Civic",
           "Toyota Corona",
           "AMC Javelin",
           "Pontiac Firebird", "Fiat X1-9",
           "Porsche 914-2", "Lotus Europa",
           "Ford Pantera L", "Ferrari Dino",
           "Maserati Bora", "Volvo 142E")

cat_match(messy_short,clean_short, method = "jaccard") %>% arrange(desc(dists))

## ----pick_lists---------------------------------------------------------------
cat_match(messy_short,clean_short, method = "jaccard", return_lists = 3, threshold = 0.2) %>% arrange(desc(dists)) %>% 
  gt::gt()

## ----picked_list--------------------------------------------------------------
#data("picked_list")


## ----return_lists cat_match example,eval=F------------------------------------
#  # load in messy_caterpillars and clean_caterpillars
#  data("clean_caterpillars")
#  data("messy_caterpillars")
#  
#  head(messy_caterpillars)
#  str(messy_caterpillars)
#  
#  head(clean_caterpillars)
#  str(clean_caterpillars)

## ----pick_lists cat_match example,eval=F--------------------------------------
#  cat_match(messy_caterpillars$CaterpillarSpecies,
#            clean_caterpillars$species,
#            return_dists = T)

## ----using outputs cat_match example,eval=F-----------------------------------
#  cat_match(messy_caterpillars$CaterpillarSpecies,clean_caterpillars$species,return_dists = T,method="jaccard") %>% arrange(desc(dists))

## ----using outputs inner_join,eval=F------------------------------------------
#  messy_caterpillars$CaterpillarSpecies = cat_replace(messy_caterpillars$CaterpillarSpecies,clean_caterpillars$species,method="jaccard", threshold = .49)
#  
#  dplyr::left_join(clean_caterpillars,messy_caterpillars, by = c("species"="CaterpillarSpecies"))

## -----------------------------------------------------------------------------
data("clean_caterpillars")
data("messy_caterpillars")

cat_join(messy_df = messy_caterpillars, clean_df = clean_caterpillars, by = c("CaterpillarSpecies", "species"), method="jaccard", threshold = .49,join="full")

## -----------------------------------------------------------------------------
data("mtcars")
mtcars_colnames_messy = mtcars
colnames(mtcars_colnames_messy)[1:5] = paste0(colnames(mtcars)[1:5], "_17")
colnames(mtcars_colnames_messy)[6:11] = paste0(colnames(mtcars)[6:11], "_2017")

## -----------------------------------------------------------------------------
fuzzy_rbind(df1 = mtcars, df2 = mtcars_colnames_messy, threshold = .5, 
            method = "jw")

## -----------------------------------------------------------------------------
fuzzy_rbind(df1 = mtcars, df2 = mtcars_colnames_messy, threshold = .2,
            method = "jw")

## -----------------------------------------------------------------------------
select_metric(c("axxxxx", "bxxxxx", "cxxxxx"), c("apples", "banana", "carrot"))


## -----------------------------------------------------------------------------
select_metric(c("ipzza", "rgegplants", "vrem aof wheat"), c("pizza", "eggplants", "cream of wheat"))

