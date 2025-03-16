#' @export
#' @rdname jd3_utilities
.obs_gathering <- function(period = 0,
                           aggregationType = NULL,
                           allowPartialAggregation = FALSE,
                           includeMissing = FALSE) {
    if (is.null(aggregationType)) aggregationType <- "None"
    if (is.null(allowPartialAggregation)) allowPartialAggregation <- FALSE
    if (is.null(includeMissing)) includeMissing <- FALSE
    jobs <- .jcall(
        obj = "jdplus/toolkit/base/r/util/Providers",
        returnSig = "Ljdplus/toolkit/base/api/timeseries/util/ObsGathering;",
        method = "obsGathering",
        as.integer(period), as.character(aggregationType),
        as.logical(allowPartialAggregation), as.logical(includeMissing)
    )
    return(jobs)
}

#' @export
#' @rdname jd3_utilities
.obs_format <- function(locale = NULL, dateFmt = NULL, numberFmt = NULL, ignoreNumberGrouping = TRUE) {
    if (is.null(locale)) locale <- ""
    if (is.null(dateFmt)) dateFmt <- ""
    if (is.null(numberFmt)) numberFmt <- ""
    jobs <- .jcall(
        obj = "jdplus/text/base/r/Utility",
        returnSig = "Ljdplus/toolkit/base/tsp/util/ObsFormat;",
        method = "obsFormat",
        as.character(locale), as.character(dateFmt), as.character(numberFmt), as.logical(ignoreNumberGrouping)
    )
    return(jobs)
}
