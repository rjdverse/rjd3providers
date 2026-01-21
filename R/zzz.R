#' @import rJava
#' @import rjd3toolkit
#' @include jd3spreadsheet.R jd3txt.R jd3xml.R
NULL

#' @title Java version.
#'
#' @returns \code{current_java_version} is the current Java version and \code{minimal_java_version} is the minimum accepted Java version.
#'
#' @importFrom rjd3jars get_java_version minimal_java_version
#' @export
#' @name java_version
#'
#' @examples
#' print(minimal_java_version)
#' print(current_java_version)
#' @export
current_java_version <- rjd3jars::get_java_version()

#' @rdname java_version
#' @export
minimal_java_version <- rjd3jars::minimal_java_version

.onAttach <- function(libname, pkgname) {
    if (current_java_version < minimal_java_version) {
        packageStartupMessage(sprintf("Your java version is %s. %s or higher is needed.",
                                      current_java_version, minimal_java_version))
    }
}

.onLoad <- function(libname, pkgname) {
    result <- .jpackage(pkgname, lib.loc = libname)
    if (!result) stop("Loading java packages failed")

    if (current_java_version >= minimal_java_version) {
        # reload providers
        try({
            .jcall("jdplus/spreadsheet/base/r/SpreadSheets", "V", "updateTsFactory")
            .jcall("jdplus/text/base/r/Utility", "V", "updateTsFactory")
        })
    }
}
