library(dplyr)
library(devtools)

parse_file <- function(x, y) {
  file <- unz(y, x, encoding = "ISO-8859-1")
  read.delim(file, sep = "^", quote = "~", na.strings = c("^^", "~~"),
             header = FALSE, stringsAsFactors = FALSE) %>% tbl_df()
}

temp <- tempfile()
download.file("https://www.ars.usda.gov/ARSUserFiles/80400525/Data/SR26/dnload/sr26.zip",temp)

food <- parse_file("FOOD_DES.txt", temp)
names(food) <- c("food_id", "grp_id", "food", "food_abbr", "common", "manufacturer",
                 "survey", "refuse", "ref_pct", "scientific", "n_factor", "pro_factor", "fat_factor",
                 "carb_factor")
food$survey <- food$survey == "Y"
use_data(food)

food_group <- parse_file("FD_GROUP.txt", temp)
names(food_group) <- c("grp_id", "group")
use_data(food_group)

nutrient <- parse_file("NUT_DATA.txt", temp)
names(nutrient) <- c("food_id", "nutr_id", "value", "num_points", "se",
                     "source_type_id", "deriv_id", "impute_id", "fortified", "num_studies", "min",
                     "max", "df", "lwr", "upr", "comments", "modified", "cc")
nutrient$fortified[nutrient$fortified == ""] <- NA
use_data(nutrient)

nutrient_def <- parse_file("NUTR_DEF.txt", temp)
names(nutrient_def) <- c("nutr_id", "unit", "nutr_abbr", "nutr", "precision", "seq")
use_data(nutrient_def)

source_type <- parse_file("SRC_CD.txt", temp)
names(source_type) <- c("source_type_id", "source_type")
use_data(source_type)

deriv <- parse_file("DERIV_CD.txt", temp)
names(deriv) <- c("deriv_id", "deriv")
use_data(deriv)

weight <- parse_file("WEIGHT.txt", temp)
names(weight) <- c("food_id", "seq", "amount", "desc", "weight",
                   "num_points", "sd")
use_data(weight)

footnote <- parse_file("FOOTNOTE.txt", temp)
names(footnote) <- c("food_id", "seq", "type", "nutr_id", "footnote")
use_data(footnote)

reference <- parse_file("DATA_SRC.txt", temp)
names(reference) <- c("ref_id", "authors", "title", "year", "journal", "vol_city",
                      "issue_state", "start_page", "end_page")
use_data(reference)

nutrient_source <- parse_file("DATSRCLN.txt", temp)
names(nutrient_source) <- c("food_id", "nutr_id", "ref_id")
use_data(nutrient_source)

unlink(temp)
