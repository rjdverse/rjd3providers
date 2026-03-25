#' @import rJava
#' @import rjd3toolkit
#' @include jd3spreadsheet.R jd3txt.R jd3xml.R
NULL

#' @importFrom rjd3toolkit get_java_version minimal_java_version
.onAttach <- function(libname, pkgname) {
    if (rjd3toolkit::get_java_version() < rjd3toolkit::minimal_java_version) {
        packageStartupMessage(sprintf("Your java version is %s. %s or higher is needed.",
                                      rjd3toolkit::get_java_version(), rjd3toolkit::minimal_java_version))
    }
}

#' @importFrom rJava .jpackage .jcall .jaddClassPath
#' @importFrom rjd3toolkit get_java_version minimal_java_version
.onLoad <- function(libname, pkgname) {
    jar_dir <- file.path(libname, pkgname, "inst", "java")
    jars <- list.files(jar_dir, pattern = "\\.jar$", full.names = TRUE, all.files = TRUE)
    rJava::.jaddClassPath(jars)
    result <- rJava::.jpackage(pkgname, lib.loc = libname)
    if (!result) stop("Loading java packages failed")

    if (rjd3toolkit::get_java_version() >= rjd3toolkit::minimal_java_version) {
        # Reload providers
        try({
            rJava::.jcall("jdplus/spreadsheet/base/r/SpreadSheets", "V", "updateTsFactory")
            rJava::.jcall("jdplus/text/base/r/Utility", "V", "updateTsFactory")
        })
    }
}
