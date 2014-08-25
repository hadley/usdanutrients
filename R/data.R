#' Food descriptions.
#'
#' To get information about nutrients, join with \code{\link{nutrient}}.
#' @format A data frame with 8463 observations and 14 variables:
#' @format A data frame with 8463 observations and 14 variables:
#' \describe{
#' \item{food_id}{unique food identifier}
#' \item{grp_id}{food group identifier}
#' \item{desc}{200-character description}
#' \item{abbr}{60-character abbreviated description}
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
#' \item{abbr}{International Network of Food Data Systems (INFOODS) tagname}
#' \item{name}{Name of nutrient/food component}
#' \item{precision}{Number of decimal places}
#' \item{sort}{Used to sort nutrient records in the same order as various
#'  reports produced from SR.}
#' }
#' @examples
#' nutrient_def
"nutrient_def"

