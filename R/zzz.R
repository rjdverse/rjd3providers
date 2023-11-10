#' @import rJava
#' @import rjd3toolkit
#' @include jd3spreadsheet.R jd3txt.R jd3xml.R

.onLoad <- function(libname, pkgname) {
    if (!requireNamespace("rjd3toolkit", quietly = T)) stop("Loading rjd3 libraries failed")

    result <- rJava::.jpackage(pkgname, lib.loc = libname)
    if (!result) stop("Loading java packages failed")

    # proto.dir <- system.file("proto", package = pkgname)
    # RProtoBuf::readProtoFiles2(protoPath = proto.dir)

    # reload providers
    tryCatch(
        {
            .jcall("jdplus/spreadsheet/base/r/SpreadSheets", "V", "updateTsFactory")
            .jcall("jdplus/text/base/r/Utility", "V", "updateTsFactory")
        },
        error = function(err) {}
    )
}
