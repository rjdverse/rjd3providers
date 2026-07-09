#' @importFrom rJava .jpackage .jcall .jarray .jfield .jnull
#' @importFrom rjd3jars reload_tsproviders check_java_version
#' @importFrom rjd3toolkit result
#' @include jd3spreadsheet.R jd3txt.R jd3xml.R
NULL

#' @importFrom rjd3jars check_java_version
.onAttach <- function(libname, pkgname) {
    # Check java version
    rjd3jars::check_java_version(silent = FALSE, startup = TRUE)
}

#' @importFrom rJava .jpackage .jcall .jaddClassPath
#' @importFrom rjd3jars reload_tsproviders reload_dictionaries
#' @importFrom rjd3jars check_java_version
.onLoad <- function(libname, pkgname) {
    # Loading dependencies
    if (!requireNamespace("rjd3jars", quietly = TRUE)) {
        stop("Loading {rjd3jars} failed", call. = FALSE)
    }
    if (!requireNamespace("rjd3toolkit", quietly = TRUE)) {
        stop("Loading {rjd3toolkit} failed", call. = FALSE)
    }

    # Loading Java class
    jar_dir <- file.path(libname, pkgname, "inst", "java")
    jars_inst <- list.files(
        jar_dir,
        pattern = "\\.jar$",
        full.names = TRUE,
        all.files = TRUE
    )
    result <- rJava::.jpackage(
        pkgname,
        lib.loc = libname,
        morePaths = jars_inst
    )
    if (!result) {
        stop("Loading java packages failed")
    }

    # If java >= 21, then reload dictionnaries
    has_java <- rjd3jars::check_java_version(silent = TRUE)
    if (has_java) {
        rjd3jars::reload_dictionaries()
        rjd3jars::reload_tsproviders()
    }

    #assign("providers", list(), rjd3toolkit::.jd3_env)
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
