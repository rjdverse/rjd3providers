#' @import rJava
#' @importFrom rjd3jars reload_tsproviders check_java_version
#' @include jd3spreadsheet.R jd3txt.R jd3xml.R
NULL

.onLoad <- function(libname, pkgname) {
    result <- rJava::.jpackage(pkgname, lib.loc = libname)
    if (!result) stop("Loading java packages failed", call. = FALSE)


    if (rjd3jars::check_java_version(FALSE)){
        rjd3jars::reload_tsproviders()
    }

    assign("providers", list(), rjd3toolkit::.jd3_env)


}

#' Set an option for providers
#'
#' @param name Name of the option
#' @param obj Option
#'
#' @export
#'
#' @examples
#' providers_option("test", "DUMMY")
providers_option<-function(name, obj){
    options<-rjd3toolkit::.jd3_env$providers
    options[[name]]<-obj
    assign("providers", options, rjd3toolkit::.jd3_env)
    invisible()
}

#' Set an option for providers
#'
#' @param name Name of the option
#'
#' @returns The requested option or NULL if it doesn't exist
#' @export
#'
#' @examples
#' providers_option("test", "DUMMY")
#' get_providers_option("test")
get_providers_option<-function(name){
    options<-rjd3toolkit::.jd3_env$providers
    return (options[[name]])
}

