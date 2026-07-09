#' @include providers.R
NULL

.txt_source <- function(
        file,
        fmt.locale = NULL,
        fmt.date = NULL,
        fmt.number = NULL,
        fmt.ignoreNumberGrouping = TRUE,
        gathering.period = 0,
        gathering.aggregation = c("None", "Sum", "Average", "First", "Last", "Max", "Min"),
        gathering.partialAggregation = FALSE,
        gathering.cleanMissing = TRUE,
        charset = NULL,
        delimiter = c("TAB", "SEMICOLON", "COMMA", "SPACE"),
        textQualifier = c("NONE", "QUOTE", "DOUBLE_QUOTE"),
        headers = TRUE,
        skipLines = 0) {
    gathering.aggregation <- match.arg(gathering.aggregation)
    delimiter <- match.arg(delimiter)
    textQualifier <- match.arg(textQualifier)
    jfmt <- .obs_format(fmt.locale, fmt.date, fmt.number, fmt.ignoreNumberGrouping)
    jgathering <- .obs_gathering(gathering.period, gathering.aggregation,
                                 gathering.partialAggregation, gathering.cleanMissing)
    if (is.null(charset)) charset <- "utf-8"
    jsource <- .jcall(
        "jdplus/text/base/r/TxtFiles", "Ljdplus/toolkit/base/tsp/DataSource;", "source",
        as.character(file), jfmt, jgathering, as.character(charset), as.character(delimiter),
        as.character(textQualifier), as.logical(headers), as.integer(skipLines)
    )
    return(jsource)
}

 txt_initialized <- FALSE

.r2jd_txt_id <- function(id) {
    jsrc <- .txt_source(
        file = id$file,
        fmt.locale = id$format$locale,
        fmt.date = id$format$datePattern,
        fmt.number = id$format$numberPattern,
        fmt.ignoreNumberGrouping = id$format$ignoreNumberGrouping,
        gathering.period = id$gathering$period,
        gathering.aggregation = id$gathering$aggregation,
        gathering.partialAggregation = id$gathering$partialAggregation,
        gathering.cleanMissing = id$gathering$cleanMissing,
        charset = id$charset,
        delimiter = id$delimiter,
        textQualifier = id$textQualifier,
        headers = id$headers,
        skipLines = id$skipLines
    )
    if (is.null(id$series)) {
        output <- .jcall(
            obj = "jdplus/text/base/r/TxtFiles",
            returnSig = "Ljdplus/toolkit/base/tsp/DataSet;",
            method = "sheetDataSet",
            jsrc
        )
    } else {
        output <- .jcall(
            obj = "jdplus/text/base/r/TxtFiles",
            returnSig = "Ljdplus/toolkit/base/tsp/DataSet;",
            method = "seriesDataSet",
            jsrc, as.integer(id$series)
        )
    }

    return(output)
}

.jd2r_txt_id <- function(jset) {
    jbean <- .jcall("jdplus/text/base/r/TxtFiles", "Ljdplus/text/base/api/TxtBean;", "sourceOf", jset)
    jfile <- .jcall(jbean, "Ljava/io/File;", "getFile")
    jcharset <- .jcall(jbean, "Ljava/nio/charset/Charset;", "getCharset")
    jformat <- .jcall(jbean, "Ljdplus/toolkit/base/tsp/util/ObsFormat;", "getFormat")
    jgathering <- .jcall(jbean, "Ljdplus/toolkit/base/api/timeseries/util/ObsGathering;", "getGathering")
    junit <- .jcall(jgathering, "Ljdplus/toolkit/base/api/timeseries/TsUnit;", "getUnit")
    jagg <- .jcall(jgathering, "Ljdplus/toolkit/base/api/data/AggregationType;", "getAggregationType")
    jlocale <- .jcall(jformat, "Ljava/util/Locale;", "getLocale")
    jdelimiter <- .jcall(jbean, "Ljdplus/text/base/api/TxtBean$Delimiter;", "getDelimiter")
    jqual <- .jcall(jbean, "Ljdplus/text/base/api/TxtBean$TextQualifier;", "getTextQualifier")
    return(list(
        file = .jcall(jfile, "S", "getPath"),
        delimiter = .jcall(jdelimiter, "S", "name"),
        textQualifier = .jcall(jqual, "S", "name"),
        headers = as.integer(.jcall(jbean, "Z", "isHeaders")),
        skipLines = as.integer(.jcall(jbean, "I", "getSkipLines")),
        series = 1 + as.integer(.jcall(jset, "S", "getParameter", "seriesIndex")),
        gathering = list(
            period = .jcall(junit, "I", "getAnnualFrequency"),
            aggregation = .jcall(jagg, "S", "name"),
            partialAggregation = .jcall(jgathering, "Z", "isAllowPartialAggregation"),
            cleanMissing = ! .jcall(jgathering, "Z", "isIncludeMissingValues")
        ),
        format = list(
            locale = .jcall(jlocale, "S", "toLanguageTag"),
            datePattern = .jcall(jformat, "S", "getDateTimePattern"),
            numberPattern = .jcall(jformat, "S", "getNumberPattern"),
            ignoreNumberGrouping = .jcall(jformat, "Z", "isIgnoreNumberGrouping")
        )
    ))
}

#' @title Gets the name of the text provider
#'
#' @returns The name of the text provider, to be used in monikers
#'
#' @export
#'
#' @examplesIf rjd3jars::check_java_version(silent = TRUE)
#'
#' txt_name()
#'
txt_name <- function() {
    return(.jfield("jdplus/text/base/api/TxtProvider", name = "NAME"))
}

#' @title Generates a java moniker for the corresponding id.
#'
#' @param id Identifier of the requested information.
#'
#' @returns An internal java moniker.
#'
#' @examplesIf rjd3jars::check_java_version(silent = TRUE)
#'
#' .txt_moniker("toy_id")
#'
#' @export
#'
.txt_moniker <- function(id) {
    jmoniker <- .jcall(
        obj = "jdplus/toolkit/base/api/timeseries/TsMoniker",
        returnSig = "Ljdplus/toolkit/base/api/timeseries/TsMoniker;",
        method = "of",
        txt_name(), id
    )
    return(jmoniker)
}

#' @title Set the paths to txt files (to be used with relative identifiers)
#'
#' @param paths The folders containing the txt files Only used in relative addresses.
#'
#' @returns An internal java moniker
#'
#' @export
#'
#' @examplesIf rjd3jars::check_java_version(silent = TRUE)
#'
#' set_txt_paths(system.file("extdata", package = "rjd3providers"))
#'
set_txt_paths <- function(paths) {
    .jcall("jdplus/text/base/r/TxtFiles", "V", "setPaths", .jarray(paths))
}

#' @title Provides the content of a text file designed for time series
#'
#' @param file The text file
#' @param fmt.locale Locale language. Null to use the default
#' @param fmt.date Format of the date. Null to use the default of the locale
#' @param fmt.number Format of the number. Null to use the default of the locale
#' @param fmt.ignoreNumberGrouping Ignore number grouping
#' @param gathering.period The annual frequency of the series. If 0, the frequency
#' @param gathering.aggregation  The type of the aggregation to be applied on the series (only used if "period" is different from 0)
#' @param gathering.partialAggregation Specifies if  the aggregation is performed or not when they are missing periods
#' @param gathering.cleanMissing Specifies if missing values at the beginning or at the end of the data are removed from the series.
#' @param charset Specifies the charset
#' @param delimiter Specifies the delimiter. Should be in ("TAB", "SEMICOLON", "COMMA", "SPACE")
#' @param txtQualifier Character used to qualify text. Should be in ("NONE", "QUOTE", "DOUBLE_QUOTE")
#' @param header The file contains headers
#' @param skip Skips some lines
#'
#' @returns Provides all the names of the time series contained in the text file
#'
#' @export
#'
#' @examplesIf rjd3jars::check_java_version(silent = TRUE)
#' \donttest{
#' set_txt_paths(system.file("extdata", package = "rjd3providers"))
#' txt_all <- txt_content("ABS.csv", delimiter = "COMMA")
#' }
txt_content <- function(
        file,
        fmt.locale = NULL,
        fmt.date = NULL,
        fmt.number = NULL,
        fmt.ignoreNumberGrouping = TRUE,
        gathering.period = 0,
        gathering.aggregation = c("None", "Sum", "Average", "First", "Last", "Max", "Min"),
        gathering.partialAggregation = FALSE,
        gathering.cleanMissing = TRUE,
        charset = NULL,
        delimiter = c("TAB", "SEMICOLON", "COMMA", "SPACE"),
        txtQualifier = c("NONE", "QUOTE", "DOUBLE_QUOTE"),
        header = TRUE,
        skip = 0) {
    jsource <- .txt_source(
        file, fmt.locale, fmt.date, fmt.number, fmt.ignoreNumberGrouping,
        gathering.period, gathering.aggregation, gathering.partialAggregation, gathering.cleanMissing,
        charset, delimiter, txtQualifier, header, skip
    )
    series <- .jcall("jdplus/text/base/r/TxtFiles", "[S", "series", jsource)
    return(series)
}

#' @title Retrieves all the time series in a text file (.txt, .csv...)
#'
#' @param file The text file
#' @param fmt.locale Locale language. Null to use the default
#' @param fmt.date Format of the date. Null to use the default of the locale
#' @param fmt.number Format of the number. Null to use the default of the locale
#' @param fmt.ignoreNumberGrouping Ignore number grouping
#' @param gathering.period The annual frequency of the transformed series. If 0, the actual frequency is used.
#' @param gathering.aggregation  The type of the aggregation to be applied on the series (only used if "period" is different from 0)
#' @param gathering.partialAggregation Specifies if  the aggregation is performed or not when they are missing periods
#' @param gathering.cleanMissing Specifies if missing values at the beginning or at the end of the data are removed from the series.
#' @param charset Specifies the charset
#' @param delimiter Specifies the delimiter. Should be in ("TAB", "SEMICOLON", "COMMA", "SPACE")
#' @param txtQualifier Character used to qualify text. Should be in ("NONE", "QUOTE", "DOUBLE_QUOTE")
#' @param header The file contains headers
#' @param skip Skips some lines
#'
#' @returns A ts collection with all the series
#'
#' @export
#'
#' @examplesIf rjd3jars::check_java_version(silent = TRUE)
#' \donttest{
#' set_txt_paths(system.file("extdata", package = "rjd3providers"))
#' all <- txt_data("ABS.csv", delimiter = "COMMA")
#' }
txt_data <- function(
        file,
        fmt.locale = NULL,
        fmt.date = NULL,
        fmt.number = NULL,
        fmt.ignoreNumberGrouping = TRUE,
        gathering.period = 0,
        gathering.aggregation = c("None", "Sum", "Average", "First", "Last", "Max", "Min"),
        gathering.partialAggregation = FALSE, gathering.cleanMissing = TRUE,
        charset = NULL,
        delimiter = c("TAB", "SEMICOLON", "COMMA", "SPACE"),
        txtQualifier = c("NONE", "QUOTE", "DOUBLE_QUOTE"),
        header = TRUE,
        skip = 0) {
    jsource <- .txt_source(
        file, fmt.locale, fmt.date, fmt.number, fmt.ignoreNumberGrouping,
        gathering.period, gathering.aggregation, gathering.partialAggregation, gathering.cleanMissing,
        charset, delimiter, txtQualifier, header, skip
    )
    jcoll <- .jcall(
        obj = "jdplus/text/base/r/TxtFiles",
        returnSig = "Ljdplus/toolkit/base/api/timeseries/TsCollection;",
        method = "collection",
        jsource
    )
    return(rjd3toolkit::.jd2r_tscollection(jcoll))
}

#' @title Retrieves a time series from a a text file (.txt, .csv...)
#'
#' @param file The text file
#' @param series The name or the 1-based position of the series in the selected sheet
#' @param fmt.locale Locale language. Null to use the default
#' @param fmt.date Format of the date. Null to use the default of the locale
#' @param fmt.number Format of the number. Null to use the default of the locale
#' @param fmt.ignoreNumberGrouping Ignore number grouping
#' @param gathering.period The annual frequency of the transformed series. If 0, the actual frequency is used.
#' @param gathering.aggregation  The type of the aggregation to be applied on the series (only used if "period" is different from 0)
#' @param gathering.partialAggregation Specifies if  the aggregation is performed or not when they are missing periods
#' @param gathering.cleanMissing Specifies if missing values at the beginning or at the end of the data are removed from the series.
#' @param charset Specifies the charset
#' @param delimiter Specifies the delimiter. Should be in ("TAB", "SEMICOLON", "COMMA", "SPACE")
#' @param txtQualifier Character used to qualify text. Should be in ("NONE", "QUOTE", "DOUBLE_QUOTE")
#' @param header The file contains headers
#' @param skip Skips some lines
#'
#' @returns Returns the specified time series
#' @export
#'
#' @examplesIf rjd3jars::check_java_version(silent = TRUE)
#' \donttest{
#' set_txt_paths(system.file("extdata", package = "rjd3providers"))
#' txt_15 <- txt_series("ABS.csv", series = 15, delimiter = "COMMA")
#' txt_09 <- txt_series("ABS.csv", series = "0.2.09.10.M", delimiter = "COMMA")
#' }
txt_series <- function(
        file,
        series,
        fmt.locale = NULL,
        fmt.date = NULL,
        fmt.number = NULL,
        fmt.ignoreNumberGrouping = TRUE,
        gathering.period = 0,
        gathering.aggregation = c("None", "Sum", "Average", "First", "Last", "Max", "Min"),
        gathering.partialAggregation = FALSE,
        gathering.cleanMissing = TRUE,
        charset = NULL,
        delimiter = c("TAB", "SEMICOLON", "COMMA", "SPACE"),
        txtQualifier = c("NONE", "QUOTE", "DOUBLE_QUOTE"),
        header = TRUE,
        skip = 0) {
    jsource <- .txt_source(
        file, fmt.locale, fmt.date, fmt.number, fmt.ignoreNumberGrouping,
        gathering.period, gathering.aggregation, gathering.partialAggregation, gathering.cleanMissing,
        charset, delimiter, txtQualifier, header, skip
    )
    if (! is.numeric(series)){
        all <- .jcall("jdplus/text/base/r/TxtFiles", "[S", "series", jsource)
        series<-match(series, all)[1]
        if (is.na(series)) stop("Invalid series name")
    }

    js <- .jcall(
        obj = "jdplus/text/base/r/TxtFiles",
        returnSig = "Ljdplus/toolkit/base/api/timeseries/Ts;",
        method = "series",
        jsource, as.integer(series)
    )
    return(rjd3toolkit::.jd2r_ts(js))
}

#' @title Generates the id corresponding to a list of a text properties.
#'
#' @param props The properties defining the identifier.
#'
#' @returns The identifier corresponding to the properties.
#'
#' @export
#'
#' @examplesIf rjd3jars::check_java_version(silent = TRUE)
#' \donttest{
#' set_txt_paths(system.file("extdata", package = "rjd3providers"))
#' txt_15 <- txt_series("ABS.csv", series = 15, delimiter = "COMMA")
#' id<-txt_15$moniker$id
#' source<-txt_name()
#' props<-txt_id_to_properties(id)
#' props$gathering$period<-4
#' props$gathering$aggregation<-"Max"
#' M<-rjd3toolkit::to_ts(txt_name(), txt_properties_to_id(props))
#' props$gathering$aggregation<-"Min"
#' m<-rjd3toolkit::to_ts(txt_name(), txt_properties_to_id(props))
#' ts.plot(ts.union(M$data,m$data), col=c("red", "blue"))
#' }
txt_properties_to_id <- function(props) {
    jset <- .r2jd_txt_id(props)
    id <- .jcall("jdplus/text/base/r/TxtFiles", "S", "encode", jset)
    return(id)
}

#' @title Gets the list of the properties corresponding to the identifier of a moniker
#'
#' @param id Identifier of a series or of a collection of series.
#'
#' @returns Returns a list with the elements of the id: file , series, format, gathering, ....
#'
#' @export
#'
#' @examplesIf rjd3jars::check_java_version(silent = TRUE)
#' \donttest{
#' set_txt_paths(system.file("extdata", package = "rjd3providers"))
#' txt_15 <- txt_series("ABS.csv", series = 15, delimiter = "COMMA")
#' id<-txt_15$moniker$id
#' print(txt_id_to_properties(id))
#' }
txt_id_to_properties <- function(id) {
    jset <- .jcall("jdplus/text/base/r/TxtFiles", "Ljdplus/toolkit/base/tsp/DataSet;", "decode", id)
    return(.jd2r_txt_id(jset))
}

#' @title Change the file of a text moniker
#'
#' @param id Identifier of a series or of a collection of series.
#' @param nfile New file name.
#' @param ofile Old file name. NULL or "" to change any file to the new file.
#'
#' @returns The new identifier
#'
#' @export
#'
#' @examplesIf rjd3jars::check_java_version(silent = TRUE)
#' \donttest{
#' set_txt_paths(system.file("extdata", package = "rjd3providers"))
#' txt_15 <- txt_series("ABS.csv", series = 15, delimiter = "COMMA")
#' id<-txt_15$moniker$id
#' txt_change_file(id, "test.csv")
#' }
txt_change_file <- function(id, nfile, ofile = NULL) {
    if (is.null(ofile)) ofile <- ""
    nid <- .jcall("jdplus/text/base/r/TxtFiles", "S", "changeFile", id, nfile, ofile)
    return(nid)
}
