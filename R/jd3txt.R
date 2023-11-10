#' @include providers.R

.txt_source <- function(file, fmt.locale = NULL, fmt.date = NULL, fmt.number = NULL, fmt.ignoreNumberGrouping = TRUE,
                        gathering.period = 0, gathering.aggregation = c("None", "Sum", "Average", "First", "Last", "Max", "Min"), gathering.partialAggregation = FALSE, gathering.includeMissing = FALSE,
                        charset = NULL, delimiter = c("TAB", "SEMICOLON", "COMMA", "SPACE"), textQualifier = c("NONE", "QUOTE", "DOUBLE_QUOTE"), headers = TRUE, skipLines = 0) {
    gathering.aggregation <- match.arg(gathering.aggregation)
    delimiter <- match.arg(delimiter)
    textQualifier <- match.arg(textQualifier)
    jfmt <- .obs_format(fmt.locale, fmt.date, fmt.number, fmt.ignoreNumberGrouping)
    jgathering <- .obs_gathering(gathering.period, gathering.aggregation, gathering.partialAggregation, gathering.includeMissing)
    if (is.null(charset)) charset <- "utf-8"
    jsource <- .jcall(
        "jdplus/text/base/r/TxtFiles", "Ljdplus/toolkit/base/tsp/DataSource;", "source",
        as.character(file), jfmt, jgathering, as.character(charset), as.character(delimiter),
        as.character(textQualifier), as.logical(headers), as.integer(skipLines)
    )
    return(jsource)
}

.r2jd_txt_id <- function(id) {
    jsrc <- .txt_source(
        file = id$file, fmt.locale = id$format$locale, fmt.date = id$format$datePattern,
        fmt.number = id$format$numberPattern, fmt.ignoreNumberGrouping = id$format$ignoreNumberGrouping,
        gathering.period = id$gathering$period, gathering.aggregation = id$gathering$aggregation, gathering.partialAggregation = id$gathering$partial, gathering.includeMissing = id$gathering$missing,
        charset = id$charset, delimiter = id$delimiter, textQualifier = id$textQualifier, headers = id$headers, skipLines = id$skipLines
    )
    if (is.null(id$series)) {
        return(.jcall("jdplus/text/base/r/TxtFiles", "Ljdplus/toolkit/base/tsp/DataSet;", "sheetDataSet", jsrc))
    } else {
        return(.jcall("jdplus/text/base/r/TxtFiles", "Ljdplus/toolkit/base/tsp/DataSet;", "seriesDataSet", jsrc, as.integer(id$series)))
    }
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
        file = .jcall(jfile, "S", "getName"),
        delimiter = .jcall(jdelimiter, "S", "name"),
        textQualifier = .jcall(jqual, "S", "name"),
        headers = as.integer(.jcall(jbean, "Z", "isHeaders")),
        skipLines = as.integer(.jcall(jbean, "I", "getSkipLines")),
        series = 1 + as.integer(.jcall(jset, "S", "getParameter", "seriesIndex")),
        gathering = list(
            period = .jcall(junit, "I", "getAnnualFrequency"),
            aggregation = .jcall(jagg, "S", "name"),
            partialAggregation = .jcall(jgathering, "Z", "isAllowPartialAggregation"),
            includeMissing = .jcall(jgathering, "Z", "isIncludeMissingValues")
        ),
        format = list(
            locale = .jcall(jlocale, "S", "toLanguageTag"),
            datePattern = .jcall(jformat, "S", "getDateTimePattern"),
            numberPattern = .jcall(jformat, "S", "getNumberPattern"),
            ignoreNumberGrouping = .jcall(jformat, "Z", "isIgnoreNumberGrouping")
        )
    ))
}

#' Title
#'
#' @return
#' @export
#'
#' @examples
txt_name <- function() {
    return(.jfield("jdplus/text/base/api/TxtProvider", name = "NAME"))
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
        "jdplus/base/toolkit/api/timeseries/TsMoniker", "Ljdplus/base/toolkit/api/timeseries/TsMoniker;", "of",
        txt_name(), id
    )
}

#' Title
#'
#' @param paths
#'
#' @return
#' @export
#'
#' @examples
set_txt_paths <- function(paths) {
    .jcall("jdplus/text/base/r/TxtFiles", "V", "setPaths", .jarray(paths))
}

#' Title
#'
#' @param file
#' @param fmt.locale
#' @param fmt.date
#' @param fmt.number
#' @param fmt.ignoreNumberGrouping
#' @param gathering.period
#' @param gathering.aggregation
#' @param gathering.partialAggregation
#' @param gathering.includeMissing
#' @param charset
#' @param delimiter
#' @param txtQualifier
#' @param header
#' @param skip
#'
#' @return
#' @export
#'
#' @examples
#' set_txt_paths(system.file("examples", package = "rjd3providers"))
#' txt_all <- txt_content("abs.csv", delimiter = "COMMA")
txt_content <- function(file, fmt.locale = NULL, fmt.date = NULL, fmt.number = NULL, fmt.ignoreNumberGrouping = TRUE,
                        gathering.period = 0, gathering.aggregation = c("None", "Sum", "Average", "First", "Last", "Max", "Min"), gathering.partialAggregation = FALSE, gathering.includeMissing = TRUE,
                        charset = NULL, delimiter = c("TAB", "SEMICOLON", "COMMA", "SPACE"), txtQualifier = c("NONE", "QUOTE", "DOUBLE_QUOTE"), header = TRUE, skip = 0) {
    jsource <- .txt_source(
        file, fmt.locale, fmt.date, fmt.number, fmt.ignoreNumberGrouping,
        gathering.period, gathering.aggregation, gathering.partialAggregation, gathering.includeMissing,
        charset, delimiter, txtQualifier, header, skip
    )
    series <- .jcall("jdplus/text/base/r/TxtFiles", "[S", "series", jsource)
    return(series)
}

#' Title
#'
#' @param file
#' @param fmt.locale
#' @param fmt.date
#' @param fmt.number
#' @param fmt.ignoreNumberGrouping
#' @param gathering.period
#' @param gathering.aggregation
#' @param gathering.partialAggregation
#' @param gathering.includeMissing
#' @param charset
#' @param delimiter
#' @param txtQualifier
#' @param header
#' @param skip
#'
#' @return
#' @export
#'
#' @examples
#' set_txt_paths(system.file("examples", package = "rjd3providers"))
#' all <- txt_data("abs.csv", delimiter = "COMMA")
txt_data <- function(file, fmt.locale = NULL, fmt.date = NULL, fmt.number = NULL, fmt.ignoreNumberGrouping = TRUE,
                     gathering.period = 0, gathering.aggregation = c("None", "Sum", "Average", "First", "Last", "Max", "Min"), gathering.partialAggregation = FALSE, gathering.includeMissing = TRUE,
                     charset = NULL, delimiter = c("TAB", "SEMICOLON", "COMMA", "SPACE"), txtQualifier = c("NONE", "QUOTE", "DOUBLE_QUOTE"), header = TRUE, skip = 0) {
    jsource <- .txt_source(
        file, fmt.locale, fmt.date, fmt.number, fmt.ignoreNumberGrouping,
        gathering.period, gathering.aggregation, gathering.partialAggregation, gathering.includeMissing,
        charset, delimiter, txtQualifier, header, skip
    )
    jcoll <- .jcall("jdplus/text/base/r/TxtFiles", "Ljdplus/toolkit/base/api/timeseries/TsCollection;", "collection", jsource)
    return(rjd3toolkit::.jd2r_tscollection(jcoll))
}

#' Title
#'
#' @param file
#' @param series
#' @param fmt.locale
#' @param fmt.date
#' @param fmt.number
#' @param fmt.ignoreNumberGrouping
#' @param gathering.period
#' @param gathering.aggregation
#' @param gathering.partialAggregation
#' @param gathering.includeMissing
#' @param charset
#' @param delimiter
#' @param txtQualifier
#' @param header
#' @param skip
#'
#' @return
#' @export
#'
#' @examples
#' set_txt_paths(system.file("examples", package = "rjd3providers"))
#' txt_5 <- txt_series("abs.csv", series = 15, delimiter = "COMMA")
txt_series <- function(file, series, fmt.locale = NULL, fmt.date = NULL, fmt.number = NULL, fmt.ignoreNumberGrouping = TRUE,
                       gathering.period = 0, gathering.aggregation = c("None", "Sum", "Average", "First", "Last", "Max", "Min"), gathering.partialAggregation = FALSE, gathering.includeMissing = TRUE,
                       charset = NULL, delimiter = c("TAB", "SEMICOLON", "COMMA", "SPACE"), txtQualifier = c("NONE", "QUOTE", "DOUBLE_QUOTE"), header = TRUE, skip = 0) {
    jsource <- .txt_source(
        file, fmt.locale, fmt.date, fmt.number, fmt.ignoreNumberGrouping,
        gathering.period, gathering.aggregation, gathering.partialAggregation, gathering.includeMissing,
        charset, delimiter, txtQualifier, header, skip
    )
    js <- .jcall("jdplus/text/base/r/TxtFiles", "Ljdplus/toolkit/base/api/timeseries/Ts;", "series", jsource, as.integer(series))
    return(rjd3toolkit::.jd2r_ts(js))
}

#' Generates the id corresponding to a list of properties
#'
#' @param props
#'
#' @return
#' @export
#'
#' @examples
txt_to_id <- function(props) {
    jset <- .r2jd_txt_id(props)
    id <- .jcall("jdplus/text/base/r/TxtFiles", "S", "encode", jset)
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
txt_id_properties <- function(id) {
    jset <- .jcall("jdplus/text/base/r/TxtFiles", "Ljdplus/toolkit/base/tsp/DataSet;", "decode", id)
    return(.jd2r_txt_id(jset))
}

#' Title
#'
#' @param id Identifier of the series (from its moniker)
#' @param nfile New file name
#' @param ofile Old file name. NULL or "" to change any file to the new file
#'
#' @return
#' @export
#'
#' @examples
txt_change_file <- function(id, nfile, ofile = NULL) {
    if (is.null(ofile)) ofile <- ""
    nid <- .jcall("jdplus/text/base/r/TxtFiles", "S", "changeFile", id, nfile, ofile)
    return(nid)
}
