
#' Generates the Java object for automatic aggregation of the data
#'
#' @export
#'
#' @param period The annual frequency of the series. If 0, the frequency.
#' @param aggregationType  The type of the aggregation to be applied on the series (only used if "period" is different from 0).
#' @param allowPartialAggregation Specifies if  the aggregation is performed or not when they are missing periods.
#' @param cleanMissing Specifies if missing values at the beginning and at the end of the data are removed from the series.
#' @return An internal Java object.
#' @examplesIf jversion >= 17
#' .obs_gathering(period=4, aggregationType="Sum")
.obs_gathering <- function(period = 0,
                           aggregationType = NULL,
                           allowPartialAggregation = FALSE,
                           cleanMissing = TRUE) {
    if (is.null(aggregationType)) aggregationType <- "None"
    if (is.null(allowPartialAggregation)) allowPartialAggregation <- FALSE
    if (is.null(cleanMissing)) cleanMissing <- TRUE
    jobs <- .jcall(
        obj = "jdplus/toolkit/base/r/util/Providers",
        returnSig = "Ljdplus/toolkit/base/api/timeseries/util/ObsGathering;",
        method = "obsGathering",
        as.integer(period), as.character(aggregationType),
        as.logical(allowPartialAggregation), ! as.logical(cleanMissing)
    )
    return(jobs)
}

#' Generates the Java object for data formats
#'
#' @export
#'
#' @param locale Locale language. Null to use the default
#' @param dateFmt Format of the date. Null to use the default of the locale
#' @param numberFmt Format of the number. Null to use the default of the locale
#' @param ignoreNumberGrouping Ignore number grouping
#' @return An internal Java object.
#' @examplesIf jversion >= 17
#' .obs_format(local="french-be")
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
