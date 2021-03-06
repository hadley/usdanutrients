#' Food descriptions.
#'
#' To get information about nutrients, join with \code{\link{nutrient}}.
#' @format A data frame with 8463 observations and 14 variables:
#' @format A data frame with 8463 observations and 14 variables:
#' \describe{
#' \item{food_id}{unique food identifier}
#' \item{grp_id}{food group identifier. Join with \code{\link{food_group}} to
#'   get name.}
#' \item{food}{200-character description}
#' \item{food_abbr}{60-character abbreviated description}
#' \item{common}{other common names}
#' \item{manufacturer}{manufacturer, if appropriate}
#' \item{survey}{Included in USDA Food and Nutrient Database for Dietary
#'   Studies (FNDDS)? If so, has a complete nutrient profile for the 65
#'   FNDDS nutrients.}
#' \item{refuse}{Description of inedible parts of a food item (refuse),
#'   such as seeds or bone.}
#' \item{ref_pct}{Percentage of refuse.}
#' \item{scientific}{Scientific name of the food item}
#' \item{n_factor}{Factor for converting nitrogen to protein}
#' \item{pro_factor,fat_factor,carb_factor}{Factors for converting
#'   protein, fat and carbohydrate to energy, based on
#'   Atwater system (\url{http://en.wikipedia.org/wiki/Atwater_system})
#'   for determining energy values. For multi-ingredient foods, industry
#'   standards of 4, 9 and 4 are used.}
#' }
#' @examples
#' food
"food"

#' Nutrient definitions.
#'
#' @format A data frame with 150 observations and 6 variables:
#' \describe{
#' \item{nutr_id}{Unique ID for nutrient}
#' \item{unit}{Units of measure}
#' \item{nutr_abbr}{International Network of Food Data Systems (INFOODS) tagname}
#' \item{nutr}{Name of nutrient/food component}
#' \item{precision}{Number of decimal places}
#' \item{seq}{Used to sort nutrient records in the same order as various
#'  reports produced from SR.}
#' }
#' @examples
#' nutrient_def
"nutrient_def"

#' Food groups lookup table.
#'
#' @format A data frame with 25 observations and 2 variables:
#' \describe{
#' \item{grp_id}{group id}
#' \item{group}{group name}
#' }
#' @examples
#' food_group
#'
#' if (require("dplyr")) {
#'   food %>%
#'     left_join(food_group) %>%
#'     select(food, group)
#' }
"food_group"

#' Nutrient data table.
#'
#' Nutrient values and information about the values, including expanded
#' statistical information.
#'
#' @format A data frame with 632,894 observations and 18 variables:
#' \describe{
#' \item{food_id}{Food identifier. Joins with \code{\link{food}}}
#' \item{nutr_id}{Nutrient identifier. Joins with \code{\link{nutrient_def}}}
#' \item{value}{Amount of nutrient in 100g.}
#' \item{num_points}{Number of analyses used to compute value. If the number
#'   of data points is 0, the value was calculated or imputed.}
#' \item{se}{Standard error of the mean. NA if cannot be calculated. The
#'   standard error is also not given if the number of data points is less
#'   than three}
#' \item{source_type_id}{Code indicating type of data. Joins with
#'   \code{\link{source_type}}}
#' \item{deriv_id}{Data derivation code. Joins with \code{\link{deriv}}}
#' \item{impute_id}{Food identifier for the item used to calculate a missing
#'    value. Populated only for items added or updated starting with SR14.}
#' \item{fortified}{Indicates a vitamin or mineral added for fortification
#'   or enrichment. This field is populated for ready-to-eat breakfast cereals
#'   and many brand-name hot cereals in food group 8. }
#' \item{num_studies}{Number of studies.}
#' \item{min,max}{Minimum & maximum value from studies}
#' \item{df}{degrees of freedom}
#' \item{lwr,upr}{Lower and upper 95\% CI around mean}
#' \item{comments}{Statistical comments}
#' \item{modified}{Month value added or modified}
#' \item{cc}{Confidence Code indicating data quality, based on evaluation of
#'   sample plan, sample handling, analytical method, analytical quality
#'   control, and number of samples analyzed. Not included in this
#'   release, but is planned for future releases.}
#' }
#' @examples
#' nutrient
#'
#' # To find a name nutrient information for a specified food, you need to
#' # join food, nutrient and nutrient_def
#' if (require("dplyr") && require("tidyr")) {
#'   nutr_info <- food %>%
#'     select(food_id, food) %>%
#'     inner_join(nutrient %>% select(food_id, nutr_id, value)) %>%
#'     inner_join(nutrient_def %>% select(nutr_id, nutr_abbr))
#'
#'  # Often easiest to understand if you spread the nutrient values out
#'  # in to columns. We'll do this for the 10 most prevalent nutrients
#'  top_nutr <- nutrient %>%
#'    group_by(nutr_id) %>%
#'    tally(sort = TRUE) %>%
#'    head(10)
#'
#'  nutr_info %>%
#'    semi_join(top_nutr) %>%
#'    select(food_id, food, nutr_abbr, value) %>%
#'    spread(nutr_abbr, value)
#' }
"nutrient"

#' Source type lookup.
#'
#' This file (Table 10) contains codes indicating the type of data (analytical,
#' calculated, assumed zero, and so on) in the Nutrient Data file. To improve
#' the usability of the database and to provide values for the FNDDS, NDL staff
#' imputed nutrient values for a number of proximate components, total dietary
#' fiber, total sugar, and vitamin and mineral values.
#'
#' @format A data frame with 10 observations and 2 variables:
#' \describe{
#' \item{source_type_id}{Unique identifier for source type.}
#' \item{source_type}{Text description.}
#' }
#' @examples
#' source_type
#'
#' if (require("dplyr")) {
#' nutrient %>%
#'   select(nutr_id, source_type_id) %>%
#'   left_join(source_type)
#' }
"source_type"

#' References (sources).
#'
#' @format A data frame with 570 observations and 9 variables:
#' \describe{
#' \item{ref_id}{Reference identifier.}
#' \item{authors}{Comma delimited list of authors}
#' \item{title}{Title of paper}
#' \item{year}{Year published}
#' \item{journal}{Journal}
#' \item{vol_city}{}
#' \item{issue_state}{}
#' \item{start_page}{}
#' \item{end_page}{}
#' }
#' @examples
#' reference
"reference"


#' Data derivation lookup.
#'
#' This file (Table 11) provides information on how the nutrient values were
#' determined. The file contains the derivation codes and their descriptions
#' deriv.
#'
#' @format A data frame with 55 observations and 2 variables:
#' \describe{
#' \item{deriv_id}{Unique identifer for deriv.}
#' \item{deriv}{Text description.}
#' }
#' @examples
#' deriv
#'
#' if (require("dplyr")) {
#' nutrient %>%
#'   select(nutr_id, deriv_id) %>%
#'   left_join(deriv)
#' }
"deriv"

#' Weight.
#'
#' This file (Table 12) contains the weight in grams of a number of common
#' measures for each food item.
#'
#' @format A data frame with 15,137 observations and 7 variables:
#' \describe{
#' \item{food_id}{Food identifier. Joins to \code{\link{food}}}
#' \item{seq}{Sequence number.}
#' \item{amount}{Unit modifier (e.g. 1 in 1 cup)}
#' \item{desc}{Description (for example, cup, diced, and 1-inch pieces).}
#' \item{weight}{Weight in grams.}
#' \item{num_points}{Number of data points.}
#' \item{sd}{Standard deviation}
#' }
#' @examples
#' weight
#'
#' if (require("dplyr")) {
#' # Find out weight of a cup of x
#' cups <- weight %>%
#'   filter(desc == "cup") %>%
#'   select(food_id, weight)
#' food %>%
#'   select(food_id, food) %>%
#'   inner_join(cups)
#' }
"weight"

#' Footnotes.
#'
#' This file (Table 13) contains additional information about the food item,
#' household weight, and nutrient value.
#'
#' @format A data frame with 541 observations and 5 variables:
#' \describe{
#' \item{food_id}{Food identifier. Joins with \code{\link{food}}}
#' \item{seq}{Sequence number}
#' \item{type}{Type of footnote: D = footnote adding information to the food
#'   description; M = footnote adding information to measure description;
#'   N = footnote providing additional information on a nutrient value.
#'   If the type = N, the Nutr_No will also be filled in.}
#' \item{nutr_id}{Nutrient identifer. Joins with \code{\link{nutrient}}}
#' \item{footnote}{Footnote text}
#' }
#' @examples
#' footnote
"footnote"

#' Nutrient sources
#'
#' This file (Table 14) is used resolve the many-to-many link between
#' nutrients with references.
#'
#' @format A data frame with 213653 observations and 3 variables:
#' \describe{
#' \item{food_id}{Food identifier. Joins with \code{\link{nutrient}}}
#' \item{nutr_id}{Nutrient identifer. Joins with \code{\link{nutrient}}}
#' \item{ref_id}{Reference identifer. Joins with \code{\link{reference}}}
#' }
#' @examples
#' nutrient_source
#'
#' if (require("dplyr")) {
#'   # Connect nutrients to references
#'   nutrient_source %>%
#'     inner_join(nutrient_def %>% select(nutr_id, nutr)) %>%
#'     inner_join(food %>% select(food_id, food)) %>%
#'     inner_join(reference)
#' }
"nutrient_source"
