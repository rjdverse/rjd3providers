#' Set an option for providers
#'
#' @param name Name of the option
#' @param obj Option
#'
#' @returns Invisibly `NULL`
#'
#' @export
#'
#' @examples
#' providers_option("test", "DUMMY")
providers_option <- function(name, obj) {
    rjd3providers_options <- rjd3toolkit::.jd3_env$providers
    rjd3providers_options[[name]] <- obj
    assign("providers", rjd3providers_options, rjd3toolkit::.jd3_env)
    return(invisible(NULL))
}

#' Set an option for providers
#'
#' @param name Name of the option
#'
#' @returns The requested option or NULL if it doesn't exist
#'
#' @export
#'
#' @examples
#' providers_option("test", "DUMMY")
#' get_providers_option("test")
get_providers_option <- function(name) {
    rjd3providers_options <- rjd3toolkit::.jd3_env$providers
    return(rjd3providers_options[[name]])
}
