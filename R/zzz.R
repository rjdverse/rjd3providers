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
}
