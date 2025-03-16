#' @include providers.R
NULL

.spreadsheet_source <- function(
        file,
        period = 0,
        aggregation = c("None", "Sum", "Average", "First", "Last", "Max", "Min"),
        partialAggregation = FALSE,
        includeMissing = FALSE) {
    aggregation <- match.arg(aggregation)
    jgathering <- .obs_gathering(period, aggregation, partialAggregation, includeMissing)
    jsource <- .jcall(
        "jdplus/spreadsheet/base/r/SpreadSheets", "Ljdplus/toolkit/base/tsp/DataSource;", "source",
        as.character(file), .jnull("jdplus/toolkit/base/tsp/util/ObsFormat"), jgathering
    )
    return(jsource)
}

.r2jd_spreadsheet_id <- function(id) {
    jsrc <- .spreadsheet_source(
        file = id$file,
        period = id$gathering$period,
        aggregation = id$gathering$aggregation,
        partialAggregation = id$gathering$partialAggregation,
        includeMissing = id$gathering$includeMissing
    )
    if (is.null(id$series)) {
        output <- .jcall(
            obj = "jdplus/spreadsheet/base/r/SpreadSheets",
            returnSig = "Ljdplus/toolkit/base/tsp/DataSet;",
            method = "sheetDataSet",
            jsrc, id$sheet
        )
    } else {
        output <- .jcall(
            obj = "jdplus/spreadsheet/base/r/SpreadSheets",
            returnSig = "Ljdplus/toolkit/base/tsp/DataSet;",
            method = "seriesDataSet",
            jsrc, id$sheet, id$series
        )
    }

    return(output)
}

.jd2r_spreadsheet_id <- function(jset) {
    jbean <- .jcall(
        obj = "jdplus/spreadsheet/base/r/SpreadSheets",
        returnSig = "Ljdplus/spreadsheet/base/api/SpreadSheetBean;",
        method = "sourceOf",
        jset
    )
    jfile <- .jcall(
        obj = jbean,
        returnSig = "Ljava/io/File;",
        method = "getFile"
    )
    jgathering <- .jcall(
        obj = jbean,
        returnSig = "Ljdplus/toolkit/base/api/timeseries/util/ObsGathering;",
        method = "getGathering"
    )
    junit <- .jcall(
        obj = jgathering,
        returnSig = "Ljdplus/toolkit/base/api/timeseries/TsUnit;",
        method = "getUnit"
    )
    jagg <- .jcall(
        obj = jgathering,
        returnSig = "Ljdplus/toolkit/base/api/data/AggregationType;",
        method = "getAggregationType"
    )
    output <- list(
        file = .jcall(jfile, "S", "getName"),
        sheet = .jcall(jset, "S", "getParameter", "sheetName"),
        series = .jcall(jset, "S", "getParameter", "seriesName"),
        gathering = list(
            period = .jcall(junit, "I", "getAnnualFrequency"),
            aggregation = .jcall(jagg, "S", "name"),
            partialAggregation = .jcall(jgathering, "Z", "isAllowPartialAggregation"),
            includeMissing = .jcall(jgathering, "Z", "isIncludeMissingValues")
        )
    )
    return(output)
}

#' Title
#'
#' @return
#' @export
#'
#' @examples
spreadsheet_name <- function() {
    return(.jfield("jdplus/spreadsheet/base/api/SpreadSheetProvider", name = "NAME"))
}

#' Generates a java moniker for the corresponding id
#'
#' @param id
#'
#' @return
#' @export
#'
#' @examples
.spreadsheet_moniker <- function(id) {
    jmoniker <- .jcall(
        obj = "jdplus/base/toolkit/api/timeseries/TsMoniker",
        returnSig = "Ljdplus/base/toolkit/api/timeseries/TsMoniker;",
        method = "of",
        .jfield("jdplus/spreadsheet/base/api/SpreadSheetProvider", name = "NAME"), id
    )
    return(jmoniker)
}

#' Title
#'
#' @param file
#' @param sheet
#' @param period
#' @param aggregation
#' @param partialAggregation
#' @param cleanMissings
#' @param fullNames
#'
#' @return
#' @export
#'
#' @examples
#' set_spreadsheet_paths(system.file("examples", package = "rjd3providers"))
#' xls_all <- spreadsheet_data("Insee.xlsx", 1)
spreadsheet_data <- function(
        file, sheet = 1,
        period = 0,
        aggregation = c("None", "Sum", "Average", "First", "Last", "Max", "Min"),
        partialAggregation = FALSE,
        cleanMissings = TRUE,
        fullNames = FALSE) {
    jsource <- .spreadsheet_source(file, period, aggregation, partialAggregation, cleanMissings)
    jcoll <- .jcall(
        obj = "jdplus/spreadsheet/base/r/SpreadSheets",
        returnSig = "Ljdplus/toolkit/base/api/timeseries/TsCollection;",
        method = "collection", jsource, as.integer(sheet), fullNames
    )
    return(rjd3toolkit::.jd2r_tscollection(jcoll))
}

#' Title
#'
#' @param file
#' @param sheet
#' @param series
#' @param period
#' @param aggregation
#' @param partialAggregation
#' @param cleanMissings
#' @param fullName
#'
#' @return
#' @export
#'
#' @examples
spreadsheet_series <- function(
        file,
        sheet = 1,
        series = 1,
        period = 0,
        aggregation = c("None", "Sum", "Average", "First", "Last", "Max", "Min"),
        partialAggregation = FALSE,
        cleanMissings = TRUE,
        fullName = TRUE) {
    jsource <- .spreadsheet_source(file, period, aggregation, partialAggregation, cleanMissings)
    jcoll <- .jcall(
        obj = "jdplus/spreadsheet/base/r/SpreadSheets",
        returnSig = "Ljdplus/toolkit/base/api/timeseries/Ts;",
        method = "series",
        jsource, as.integer(sheet), as.integer(series), fullName
    )
    return(rjd3toolkit::.jd2r_ts(jcoll))
}

#' Title
#'
#' @param file
#'
#' @return
#' @export
#'
#' @examples
spreadsheet_content <- function(file) {
    jsource <- .spreadsheet_source(file, 0, "None", FALSE, FALSE)
    sheets <- .jcall("jdplus/spreadsheet/base/r/SpreadSheets", "[S", "sheets", jsource)
    rslt <- list()
    n <- length(sheets)
    for (i in 1:n) {
        series <- .jcall("jdplus/spreadsheet/base/r/SpreadSheets", "[S", "series", jsource, as.integer(i))
        rslt[[sheets[i]]] <- series
    }
    return(rslt)
}

#' Title
#'
#' @param paths
#'
#' @return
#' @export
#'
#' @examples
set_spreadsheet_paths <- function(paths) {
    .jcall("jdplus/spreadsheet/base/r/SpreadSheets", "V", "setPaths", .jarray(paths))
}

#' Generates the id corresponding to a list of properties
#'
#' @param props
#'
#' @return
#' @export
#'
#' @examples
spreadsheet_to_id <- function(props) {
    jset <- .r2jd_spreadsheet_id(props)
    id <- .jcall("jdplus/spreadsheet/base/r/SpreadSheets", "S", "encode", jset)
    return(id)
}

#' Gets the list of the properties corresponding to the identifier of a moniker
#'
#' @param id
#'
#' @return
#' @export
#'
#' @examples
spreadsheet_id_properties <- function(id) {
    jset <- .jcall("jdplus/spreadsheet/base/r/SpreadSheets", "Ljdplus/toolkit/base/tsp/DataSet;", "decode", id)
    return(.jd2r_spreadsheet_id(jset))
}

#' Change the file of a moniker
#'
#' @param id Identifier of the series (from its moniker)
#' @param nfile New file name
#' @param ofile Old file name. NULL or "" to change any file to the new file
#'
#' @return
#' @export
#'
#' @examples
spreadsheet_change_file <- function(id, nfile, ofile = NULL) {
    if (is.null(ofile)) ofile <- ""
    nid <- .jcall("jdplus/spreadsheet/base/r/SpreadSheets", "S", "changeFile", id, nfile, ofile)
    return(nid)
}
