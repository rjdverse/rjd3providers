#' @include providers.R

.xml_source <- function(file, charset = NULL) {
    if (is.null(charset)) {
        charset <- "utf-8"
    }
    jsource <- .jcall(
        "jdplus/text/base/r/XmlFiles", "Ljdplus/toolkit/base/tsp/DataSource;", "source",
        as.character(file), as.character(charset)
    )
    return(jsource)
}

.r2jd_xml_id <- function(id) {
    jsrc <- .xml_source(id$file, id$charset)
    if (is.null(id$series)) {
        output <- .jcall(
            obj = "jdplus/text/base/r/XmlFiles",
            returnSig = "Ljdplus/toolkit/base/tsp/DataSet;",
            method = "sheetDataSet", jsrc, as.integer(id$collection)
        )
    } else {
        output <- .jcall(
            obj = "jdplus/text/base/r/XmlFiles",
            returnSig = "Ljdplus/toolkit/base/tsp/DataSet;",
            method = "seriesDataSet",
            jsrc, as.integer(id$collection), as.integer(id$series)
        )
    }
    return(output)
}

.jd2r_xml_id <- function(jset) {
    jbean <- .jcall("jdplus/text/base/r/XmlFiles", "Ljdplus/text/base/api/XmlBean;", "sourceOf", jset)
    jfile <- .jcall(jbean, "Ljava/io/File;", "getFile")
    jcharset <- .jcall(jbean, "Ljava/nio/charset/Charset;", "getCharset")
    return(list(
        file = .jcall(jfile, "S", "getName"),
        charset = .jcall(jcharset, "S", "name"),
        collection = 1 + as.integer(.jcall(jset, "S", "getParameter", "collectionIndex")),
        series = 1 + as.integer(.jcall(jset, "S", "getParameter", "seriesIndex"))
    ))
}

#' Gets the name of the xml provider
#'
#' @return The name of the xml provider, to be used in monikers
#' @export
#'
#' @examplesIf jversion >= 17
#' xml_name()
xml_name <- function() {
    return(.jfield("jdplus/text/base/api/XmlProvider", name = "NAME"))
}

#' Generates a java moniker for the corresponding id
#'
#' @param id Identifier of the requested information
#'
#' @return An internal java moniker
#' @export
.xml_moniker <- function(id) {
    jmoniker <- .jcall(
        obj = "jdplus/base/toolkit/api/timeseries/TsMoniker",
        returnSig = "Ljdplus/base/toolkit/api/timeseries/TsMoniker;",
        method = "of",
        .jfield("jdplus/spreadsheet/base/api/SpreadSheetProvider", name = "NAME"), id
    )
    return(jmoniker)
}

#' Set the paths to xml files (to be used with relative identifiers)
#'
#' @param paths The folders containing the xml files. Only used in relative addresses.
#'
#' @return No output
#' @export
#'
#' @examplesIf jversion >= 17
#' set_xml_paths(system.file("examples", package = "rjd3providers"))
set_xml_paths <- function(paths) {
    .jcall("jdplus/text/base/r/XmlFiles", "V", "setPaths", .jarray(paths))
}

#' Provides the content of an xml file designed for time series
#'
#' @param file The considered file
#' @param charset The character set used in the file (NULL to use the default)
#'
#' @return Provides all the names of the time series contained in the file, grouped by collection
#'
#' @export
#'
#' @examplesIf jversion >= 17
#' set_spreadsheet_paths(system.file("examples", package = "rjd3providers"))
#' print(spreadsheet_content("Insee.xlsx"))
#' @examplesIf jversion >= 17
#' set_xml_paths(system.file("examples", package = "rjd3providers"))
#' xml_content("Prod.xml")
xml_content <- function(file, charset = NULL) {
    jsource <- .xml_source(file, charset)
    sheets <- .jcall("jdplus/text/base/r/XmlFiles", "[S", "sheets", jsource)
    rslt <- list()
    n <- length(sheets)
    for (i in 1:n) {
        series <- .jcall("jdplus/text/base/r/XmlFiles", "[S", "series", jsource, as.integer(i))
        rslt[[sheets[i]]] <- series
    }
    return(rslt)
}

#' Retrieves all the time series in a specified sheet from a spreadsheet file
#'
#' @param file The xml file
#' @param collection The 1-based position of the collection containing the requested data
#' @param charset The character set used in the file
#' @param fullNames Specifies if full names (containing the name of the sheet and the name of the series) are used or not
#'
#' @return A ts collection with all the series
#' @export
#'
#' @examplesIf jversion >= 17
#' set_xml_paths(system.file("examples", package = "rjd3providers"))
#' xml_all <- xml_data("Prod.xml", 1, charset = "iso-8859-1")
xml_data <- function(file, collection = 1, charset = NULL, fullNames = FALSE) {
    jsource <- .xml_source(file, charset)
    jcoll <- .jcall(
        obj = "jdplus/text/base/r/XmlFiles",
        returnSig = "Ljdplus/toolkit/base/api/timeseries/TsCollection;",
        method = "collection",
        jsource, as.integer(collection), fullNames
    )
    return(rjd3toolkit::.jd2r_tscollection(jcoll))
}

#' Title
#'
#' @param file The xml file
#' @param collection The 1-based position of the collection containing the requested data
#' @param series The 1-based position of the series in the selected collection
#' @param charset The character set used in the file
#' @param fullName Specifies if a full name (containing the name of the collection and the name of the series) is used or not
#'
#' @return Returns the specified time series
#' @export
#'
#' @examplesIf jversion >= 17
#' set_xml_paths(system.file("examples", package = "rjd3providers"))
#' xml_1_5 <- xml_series("Prod.xml", 1, 5, charset = "iso-8859-1")
xml_series <- function(file, collection = 1, series = 1, charset = NULL, fullName = TRUE) {
    jsource <- .xml_source(file, charset)
    jcoll <- .jcall(
        obj = "jdplus/text/base/r/XmlFiles",
        returnSig = "Ljdplus/toolkit/base/api/timeseries/Ts;",
        method = "series",
        jsource, as.integer(collection), as.integer(series), fullName
    )
    return(rjd3toolkit::.jd2r_ts(jcoll))
}

#' Generates the id corresponding to a list of properties
#'
#' @param props The properties defining the identifier.
#' @return The identifier corresponding to the properties
#' @export
#'
#' @examplesIf jversion >= 17
#' set_xml_paths(system.file("examples", package = "rjd3providers"))
#' xml_1_5 <- xml_series("Prod.xml", 1, 5, charset = "iso-8859-1")
#' q <- xml_properties(xml_1_5$moniker$id)
#' q$series <- 50
#' xml_id(q)
xml_id <- function(props) {
    jset <- .r2jd_xml_id(props)
    id <- .jcall("jdplus/text/base/r/XmlFiles", "S", "encode", jset)
    return(id)
}

#' Gets the list of the properties corresponding to the identifier of a moniker
#'
#' @param id Identifier of a series or of a collection of series.
#' @return Returns a list with the elements of the id: file, collection[, series], charset, fullnames
#' @export
#'
#' @examplesIf jversion >= 17
#' set_xml_paths(system.file("examples", package = "rjd3providers"))
#' xml_1_5 <- xml_series("Prod.xml", 1, 5, charset = "iso-8859-1")
#' xml_properties(xml_1_5$moniker$id)
#' xml_1 <- xml_data("Prod.xml", 1, charset = "iso-8859-1")
#' xml_properties(xml_1$moniker$id)
xml_properties <- function(id) {
    jset <- .jcall("jdplus/text/base/r/XmlFiles", "Ljdplus/toolkit/base/tsp/DataSet;", "decode", id)
    return(.jd2r_xml_id(jset))
}

#' Change the file of a moniker
#'
#' @param id Identifier of a series or of a collection of series.
#' @param nfile New file name.
#' @param ofile Old file name. NULL or "" to change any file to the new file.
#'
#' @return The new identifier
#' @export
#'
#' @examplesIf jversion >= 17
xml_change_file <- function(id, nfile, ofile = NULL) {
    if (is.null(ofile)) ofile <- ""
    nid <- .jcall("jdplus/text/base/r/XmlFiles", "S", "changeFile", id, nfile, ofile)
    return(nid)
}
