#' @title reasyshape
#' @description Run the `reasyshape` interactive shiny app.
#' @param ... Passed onto [shiny::runApp()].
#' @export
#'
#' @examples
#' \dontrun{
#' library(reasyshape)
#' reasyshape()
#' }
reasyshape <- function(...) {
  shiny::runApp(appDir = system.file("application", package = "reasyshape"), ...)
}
