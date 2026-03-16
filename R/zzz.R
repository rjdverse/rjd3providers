#' @import rJava
#' @import rjd3toolkit
#' @include jd3spreadsheet.R jd3txt.R jd3xml.R
NULL

.onAttach <- function(libname, pkgname) {
    if (rjd3toolkit::get_java_version() < rjd3toolkit::minimal_java_version) {
        packageStartupMessage(sprintf("Your java version is %s. %s or higher is needed.",
                                      rjd3toolkit::get_java_version(), rjd3toolkit::minimal_java_version))
    }
}

#' @importFrom rJava .jpackage .jcall
.onLoad <- function(libname, pkgname) {
    result <- .jpackage(pkgname, lib.loc = libname)
    if (!result) stop("Loading java packages failed")

    if (rjd3toolkit::get_java_version() >= rjd3toolkit::minimal_java_version) {
        # reload providers
        try({
            .jcall("jdplus/spreadsheet/base/r/SpreadSheets", "V", "updateTsFactory")
            .jcall("jdplus/text/base/r/Utility", "V", "updateTsFactory")
        })
    }
}
