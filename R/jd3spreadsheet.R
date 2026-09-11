#' @include providers.R
NULL

.spreadsheet_source <- function(
    file,
    period = 0,
    aggregation = c("None", "Sum", "Average", "First", "Last", "Max", "Min"),
    partialAggregation = FALSE,
    cleanMissing = TRUE
) {
    aggregation <- match.arg(aggregation)
    jgathering <- .obs_gathering(
        period,
        aggregation,
        partialAggregation,
        cleanMissing
    )
    jsource <- .jcall(
        "jdplus/spreadsheet/base/r/SpreadSheets",
        "Ljdplus/toolkit/base/tsp/DataSource;",
        "source",
        as.character(file),
        .jnull("jdplus/toolkit/base/tsp/util/ObsFormat"),
        jgathering
    )
    return(jsource)
}

.r2jd_spreadsheet_id <- function(id) {
    jsrc <- .spreadsheet_source(
        file = id$file,
        period = id$gathering$period,
        aggregation = id$gathering$aggregation,
        partialAggregation = id$gathering$partialAggregation,
        cleanMissing = id$gathering$cleanMissing
    )
    if (is.null(id$series)) {
        output <- .jcall(
            obj = "jdplus/spreadsheet/base/r/SpreadSheets",
            returnSig = "Ljdplus/toolkit/base/tsp/DataSet;",
            method = "sheetDataSet",
            jsrc,
            id$sheet
        )
    } else {
        output <- .jcall(
            obj = "jdplus/spreadsheet/base/r/SpreadSheets",
            returnSig = "Ljdplus/toolkit/base/tsp/DataSet;",
            method = "seriesDataSet",
            jsrc,
            id$sheet,
            id$series
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
        file = .jcall(jfile, "S", "getPath"),
        sheet = .jcall(jset, "S", "getParameter", "sheetName"),
        series = .jcall(jset, "S", "getParameter", "seriesName"),
        gathering = list(
            period = .jcall(junit, "I", "getAnnualFrequency"),
            aggregation = .jcall(jagg, "S", "name"),
            partialAggregation = .jcall(
                jgathering,
                "Z",
                "isAllowPartialAggregation"
            ),
            cleanMissing = !.jcall(jgathering, "Z", "isIncludeMissingValues")
        )
    )
    return(output)
}

#' @title Gets the name of the spreadsheet provider.
#'
#' @returns The name of the spreadsheet provider, to be used in monikers.
#' @export
#'
#' @examplesIf rjd3jars::check_java_version(silent = TRUE)
#'
#' print(spreadsheet_name())
#'
spreadsheet_name <- function() {
    return(.jfield(
        "jdplus/spreadsheet/base/api/SpreadSheetProvider",
        "S",
        name = "NAME"
    ))
}

#' @title Set the paths to spreadsheet files (to be used with relative identifiers).
#'
#' @param paths The folders containing the spreadsheet files Only used in
#'   relative addresses.
#'
#' @returns No output.
#' @export
#'
#' @examplesIf rjd3jars::check_java_version(silent = TRUE)
#'
#' set_spreadsheet_paths(system.file("extdata", package = "rjd3providers"))
#'
set_spreadsheet_paths <- function(paths) {
    .jcall(
        "jdplus/spreadsheet/base/r/SpreadSheets",
        "V",
        "setPaths",
        .jarray(paths)
    )
}

#' @title Generates a java moniker for the corresponding id.
#'
#' @param id Identifier of the requested information.
#'
#' @returns An internal Java moniker.
#' @export
#'
#' @examplesIf rjd3jars::check_java_version(silent = TRUE)
#'
#' .spreadsheet_moniker("toy_id")
#'
.spreadsheet_moniker <- function(id) {
    jmoniker <- .jcall(
        obj = "jdplus/toolkit/base/api/timeseries/TsMoniker",
        returnSig = "Ljdplus/toolkit/base/api/timeseries/TsMoniker;",
        method = "of",
        spreadsheet_name(),
        id
    )
    return(jmoniker)
}

#' @title Retrieves all the time series in a specified sheet from a spreadsheet file.
#'
#' @param file The spreadsheet file.
#' @param sheet The name or the 1-based position of the sheet containing the
#'   requested data.
#' @param gathering.period The annual frequency of the transformed series.
#'   If 0, the actual frequency is used.
#' @param gathering.aggregation  The type of the aggregation to be applied on
#'   the series (only used if "period" is different from 0).
#' @param gathering.partialAggregation Specifies if  the aggregation is
#'   performed or not when they are missing periods.
#' @param gathering.cleanMissing Specifies if missing values at the beginning
#'   or at the end of the data are removed from the series.
#' @param fullNames Specifies if full names (containing the name of the sheet
#'   and the name of the series) are used or not.
#'
#' @returns A ts collection with all the series.
#'
#' @export
#'
#' @examplesIf rjd3jars::check_java_version(silent = TRUE)
#' \donttest{
#' set_spreadsheet_paths(system.file("extdata", package = "rjd3providers"))
#' xls_all <- spreadsheet_data("Insee.xlsx", 1)
#' txt_all <- spreadsheet_data("Insee.xlsx", "FRANCE Textile")
#' }
spreadsheet_data <- function(
    file,
    sheet = 1,
    gathering.period = 0,
    gathering.aggregation = c(
        "None",
        "Sum",
        "Average",
        "First",
        "Last",
        "Max",
        "Min"
    ),
    gathering.partialAggregation = FALSE,
    gathering.cleanMissing = TRUE,
    fullNames = FALSE
) {
    jsource <- .spreadsheet_source(
        file,
        gathering.period,
        gathering.aggregation,
        gathering.partialAggregation,
        gathering.cleanMissing
    )
    if (!is.numeric(sheet)) {
        sheets <- .jcall(
            obj = "jdplus/spreadsheet/base/r/SpreadSheets",
            returnSig = "[S",
            method = "sheets",
            jsource
        )
        sheet <- match(sheet, sheets)[1]
        if (is.na(sheet)) stop("Invalid sheet name", call. = FALSE)
    }
    jcoll <- .jcall(
        obj = "jdplus/spreadsheet/base/r/SpreadSheets",
        returnSig = "Ljdplus/toolkit/base/api/timeseries/TsCollection;",
        method = "collection",
        jsource,
        as.integer(sheet),
        fullNames
    )
    return(rjd3toolkit::.jd2r_tscollection(jcoll))
}

#' @title Retrieves a time series from a spreadsheet file.
#'
#' @param file The spreadsheet file.
#' @param sheet The name or the 1-based position of the sheet containing the
#'   requested data.
#' @param series The name or the 1-based position of the series in the selected
#'   sheet.
#' @param gathering.period The annual frequency of the transformed series.
#'   If 0, the actual frequency is used.
#' @param gathering.aggregation  The type of the aggregation to be applied on
#'   the series (only used if "period" is different from 0).
#' @param gathering.partialAggregation Specifies if  the aggregation is
#'   performed or not when they are missing periods.
#' @param gathering.cleanMissing Specifies if missing values are removed at the
#'   beginning or at the end of the data.
#' @param fullName Specifies if a full name (containing the name of the sheet
#'   and the name of the series) is used or not.
#'
#' @returns Returns the specified time series.
#'
#' @export
#'
#' @examplesIf rjd3jars::check_java_version(silent = TRUE)
#' \donttest{
#' set_spreadsheet_paths(system.file("extdata", package = "rjd3providers"))
#' xls_s1_3 <- spreadsheet_series("Insee.xlsx", 1, 3)
#' txt_s1 <- spreadsheet_series("Insee.xlsx", "FRANCE Textile", 1)
#' }
spreadsheet_series <- function(
    file,
    sheet = 1,
    series = 1,
    gathering.period = 0,
    gathering.aggregation = c(
        "None",
        "Sum",
        "Average",
        "First",
        "Last",
        "Max",
        "Min"
    ),
    gathering.partialAggregation = FALSE,
    gathering.cleanMissing = TRUE,
    fullName = TRUE
) {
    jsource <- .spreadsheet_source(
        file,
        gathering.period,
        gathering.aggregation,
        gathering.partialAggregation,
        gathering.cleanMissing
    )
    if (!is.numeric(sheet)) {
        sheets <- .jcall(
            obj = "jdplus/spreadsheet/base/r/SpreadSheets",
            returnSig = "[S",
            method = "sheets",
            jsource
        )
        sheet <- match(sheet, sheets)[1]
        if (is.na(sheet)) stop("Invalid sheet name", call. = FALSE)
    }
    if (!is.numeric(series)) {
        all_ptrn <- .jcall(
            obj = "jdplus/spreadsheet/base/r/SpreadSheets",
            returnSig = "[S",
            method = "series",
            jsource,
            as.integer(sheet)
        )
        series <- match(series, all_ptrn)[1]
        if (is.na(series)) stop("Invalid series name", call. = FALSE)
    }
    jcoll <- .jcall(
        obj = "jdplus/spreadsheet/base/r/SpreadSheets",
        returnSig = "Ljdplus/toolkit/base/api/timeseries/Ts;",
        method = "series",
        jsource,
        as.integer(sheet),
        as.integer(series),
        fullName
    )
    return(rjd3toolkit::.jd2r_ts(jcoll))
}

#' @title Provides the content of a spreadsheet designed for time series.
#'
#' @param file The considered workbook.
#'
#' @returns Provides all the names of the time series contained in the workbook,
#' organized by worksheet; the output is a list of lists of names.
#'
#' @export
#'
#' @examplesIf rjd3jars::check_java_version(silent = TRUE)
#' \donttest{
#' set_spreadsheet_paths(system.file("extdata", package = "rjd3providers"))
#' print(spreadsheet_content("Insee.xlsx"))
#' }
spreadsheet_content <- function(file) {
    jsource <- .spreadsheet_source(file, 0, "None", FALSE, FALSE)
    sheets <- .jcall(
        "jdplus/spreadsheet/base/r/SpreadSheets",
        "[S",
        "sheets",
        jsource
    )
    rslt <- list()
    n <- length(sheets)
    for (i in 1:n) {
        series <- .jcall(
            "jdplus/spreadsheet/base/r/SpreadSheets",
            "[S",
            "series",
            jsource,
            as.integer(i)
        )
        rslt[[sheets[i]]] <- series
    }
    return(rslt)
}

#' @title Generates the id corresponding to a list of spreadsheet properties.
#'
#' @param props The properties defining the identifier.
#'
#' @returns The identifier corresponding to the properties.
#'
#' @export
#'
#' @examplesIf rjd3jars::check_java_version(silent = TRUE)
#' \donttest{
#' set_spreadsheet_paths(system.file("extdata", package = "rjd3providers"))
#' xls_s1_3 <- spreadsheet_series("Insee.xlsx", 1, 3)
#' id<-xls_s1_3$moniker$id
#' source<-spreadsheet_name()
#' props<-spreadsheet_id_to_properties(xls_s1_3$moniker$id)
#' props$gathering$period<-4
#' props$gathering$aggregation<-"Max"
#' M<-rjd3toolkit::to_ts(spreadsheet_name(), spreadsheet_properties_to_id(props))
#' props$gathering$aggregation<-"Min"
#' m<-rjd3toolkit::to_ts(spreadsheet_name(), spreadsheet_properties_to_id(props))
#' ts.plot(ts.union(M$data,m$data), col=c("red", "blue"))
#' }
spreadsheet_properties_to_id <- function(props) {
    jset <- .r2jd_spreadsheet_id(props)
    id <- .jcall("jdplus/spreadsheet/base/r/SpreadSheets", "S", "encode", jset)
    return(id)
}

#' @title Gets the list of the properties corresponding to the identifier of a moniker.
#'
#' @param id Identifier of a series or of a collection of series.
#'
#' @returns Returns a list with the elements of the id: file, sheet, series,
#' gathering); the gathering is a list with the following items: period (-1 by
#' default), the aggregation ("None"), partialAggregation (FALSE),
#' includeMissing (FALSE).
#'
#' @export
#'
#' @details
#' When the period in the gathering list is defined, the user must specify the
#' aggregation type ("Sum", "Average", "First", "Last", "Min", "Max") and some
#' additional parameters (partial aggregation and suppression of
#' leading/trailing missing values).
#'
#' @seealso [spreadsheet_properties_to_id()]
#'
#' @examplesIf rjd3jars::check_java_version(silent = TRUE)
#' \donttest{
#' set_spreadsheet_paths(system.file("extdata", package = "rjd3providers"))
#' xls_s1_3 <- spreadsheet_series("Insee.xlsx", 1, 3)
#' id<-xls_s1_3$moniker$id
#' print(spreadsheet_id_to_properties(id))
#' }
spreadsheet_id_to_properties <- function(id) {
    jset <- .jcall(
        "jdplus/spreadsheet/base/r/SpreadSheets",
        "Ljdplus/toolkit/base/tsp/DataSet;",
        "decode",
        id
    )
    return(.jd2r_spreadsheet_id(jset))
}

#' @title Change the file of a spreadsheet moniker.
#'
#' @param id Identifier of a series or of a collection of series.
#' @param nfile New file name.
#' @param ofile Old file name. NULL or "" to change any file to the new file.
#'
#' @returns Returns the new identifier.
#' @export
#'
#' @examplesIf rjd3jars::check_java_version(silent = TRUE)
#' \donttest{
#' set_spreadsheet_paths(system.file("extdata", package = "rjd3providers"))
#' xls_all <- spreadsheet_data("Insee.xlsx", 1)
#' id<-xls_all$moniker$id
#' spreadsheet_change_file(id, "test.xlsx")
#'}
spreadsheet_change_file <- function(id, nfile, ofile = NULL) {
    if (is.null(ofile)) {
        ofile <- ""
    }
    nid <- .jcall(
        "jdplus/spreadsheet/base/r/SpreadSheets",
        "S",
        "changeFile",
        id,
        nfile,
        ofile
    )
    return(nid)
}
