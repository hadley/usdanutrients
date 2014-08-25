library(dplyr)
library(tidyr)
library(devtools)

parse_file <- function(x) {
  base_url <- "http://www.ars.usda.gov/SP2UserFiles/Place/12354500/Data/SR26/asc/"
  read.delim(paste0(base_url, x), sep = "^", quote = "~", na.strings = c("^^", "~~"),
    header = FALSE) %>% tbl_df()
}

food <- parse_file("FOOD_DES.txt")
names(food) <- c("food_id", "grp_id", "desc", "abbr", "common", "manufacturer",
  "survey", "refuse", "ref_pct", "scientific", "n_factor", "pro_factor", "fat_factor",
  "carb_factor")
use_data(food)

food_groups <- parse_file("FD_GROUP.txt")
names(food_groups) <- c("grp_id", "desc")
use_data(food_groups)

# parse_file("DATA_SRC.txt")
# parse_file("DATSRCLN.txt")
# parse_file("DERIV_CD.txt")
# parse_file("FOOTNOTE.txt")
# parse_file("NUT_DATA.txt")
# parse_file("NUTR_DEF.txt")
# parse_file("SRC_CD.txt")
# parse_file("WEIGHT.txt")
