library(dplyr)
library(devtools)
library(httr)

parse_file <- function(x) {
  base_url <- "http://www.ars.usda.gov/SP2UserFiles/Place/12354500/Data/SR26/asc/"
  resp <- GET(paste0(base_url, x))

  text <- content(resp, "text", encoding = "ISO-8859-1")
  read.delim(text = text, sep = "^", quote = "~", na.strings = c("^^", "~~"),
    header = FALSE, stringsAsFactors = FALSE) %>% tbl_df()
}

food <- parse_file("FOOD_DES.txt")
names(food) <- c("food_id", "grp_id", "desc", "abbr", "common", "manufacturer",
  "survey", "refuse", "ref_pct", "scientific", "n_factor", "pro_factor", "fat_factor",
  "carb_factor")
food$survey <- food$survey == "Y"
use_data(food)

food_group <- parse_file("FD_GROUP.txt")
names(food_group) <- c("grp_id", "group")
use_data(food_group)

nutrient <- parse_file("NUT_DATA.txt")
names(nutrient) <- c("food_id", "nutr_id", "nutr_val", "num_points", "se",
  "source_type_id", "deriv_id", "impute_id", "fortified", "num_studies", "min",
  "max", "df", "lwr", "upr", "comments", "modified", "cc")
nutrient$fortified[nutrient$fortified == ""] <- NA
use_data(nutrient)

nutrient_def <- parse_file("NUTR_DEF.txt")
names(nutrient_def) <- c("nutr_id", "unit", "abbr", "name", "precision", "seq")
use_data(nutrient_def)

source_type <- parse_file("SRC_CD.txt")
names(source_type) <- c("source_type_id", "source_type")
use_data(source_type)

deriv <- parse_file("DERIV_CD.txt")
names(deriv) <- c("deriv_id", "deriv")
use_data(deriv)

weight <- parse_file("WEIGHT.txt")
names(weight) <- c("food_id", "seq", "amount", "desc", "weight",
  "num_points", "sd")
use_data(weight)

footnote <- parse_file("FOOTNOTE.txt")
names(footnote) <- c("food_id", "seq", "type", "nutr_id", "footnote")
use_data(footnote)

reference <- parse_file("DATA_SRC.txt")
names(reference) <- c("ref_id", "authors", "title", "year", "journal", "vol_city",
  "issue_state", "start_page", "end_page")
use_data(reference)

nutrient_source <- parse_file("DATSRCLN.txt")
names(nutrient_source) <- c("food_id", "nutr_id", "ref_id")
use_data(nutrient_source)
