#' World Health Organization TB data
#'
#' A subset of data from the World Health Organization Global Tuberculosis
#' Report, and accompanying global populations.
#'
#' @format A dataset with the variables
#' \describe{
#'   \item{country}{Country name}
#'   \item{iso2, iso3}{2 & 3 letter ISO country codes}
#'   \item{year}{Year}
#'   \item{new_sp_m014 - new_rel_f65}{Counts of new TB cases recorded by group.
#'    Column names encode three variables that describe the group (see details).}
#' }
#' @details The data uses the original codes given by the World Health
#'   Organization. The column names for columns five through 60 are made by
#'   combining `new_` to a code for method of diagnosis (`rel` =
#'   relapse, `sn` = negative pulmonary smear, `sp` = positive
#'   pulmonary smear, `ep` = extrapulmonary) to a code for gender
#'   (`f` = female, `m` = male) to a code for age group (`014` =
#'   0-14 yrs of age, `1524` = 15-24 years of age, `2534` = 25 to
#'   34 years of age, `3544` = 35 to 44 years of age, `4554` = 45 to
#'   54 years of age, `5564` = 55 to 64 years of age, `65` = 65 years
#'   of age or older).
#'
#' @source <https://www.who.int/tb/country/data/download/en/>
"who"

#' Pew religion and income survey
#'
#' @format A dataset with variables:
#' \describe{
#'   \item{religion}{Name of religion}
#'   \item{`<$10k`-`Don\'t know/refused`}{Number of respondees with
#'     income range in column name}
#' }
#' @source
#' Downloaded from <https://www.pewforum.org/religious-landscape-study/>
#' (downloaded November 2009)
"relig_income"

#' Song rankings for billboard top 100 in the year 2000
#'
#' @format A dataset with variables:
#' \describe{
#'   \item{artist}{Artist name}
#'   \item{track}{Song name},
#'   \item{date.enter}{Date the song entered the top 100}
#'   \item{wk1 -- wk76}{Rank of the song in each week after it entered}
#' }
#' @source
#' The "Whitburn" project, <https://waxy.org/2008/05/the_whitburn_project/>,
#' (downloaded April 2008)
"billboard"
