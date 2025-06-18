#' @include providers.R

#' Title
#'
#' @param file
#' @param cs
#'
#' @return
#' @export
#'
#' @examplesIf jversion >= 17
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

#' Gets the name of the provider
#'
#' @return
#' @export
#'
#' @examplesIf jversion >= 17
#' xml_name()
xml_name <- function() {
    return(.jfield("jdplus/text/base/api/XmlProvider", name = "NAME"))
}

#' Set the paths of the provider
#'
#' @param paths
#'
#' @return
#' @export
#'
#' @examplesIf jversion >= 17
#' set_xml_paths(system.file("examples", package = "rjd3providers"))
set_xml_paths <- function(paths) {
    .jcall("jdplus/text/base/r/XmlFiles", "V", "setPaths", .jarray(paths))
}

#' Title
#'
#' @param file
#'
#' @return
#' @export
#'
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

#' Title
#'
#' @param file
#' @param collection
#' @param charset
#' @param fullNames
#'
#' @return
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
#' @param file
#' @param collection
#' @param series
#' @param charset
#' @param fullName
#'
#' @return
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
#' @param props
#'
#' @return
#' @export
#'
#' @examplesIf jversion >= 17
#' set_xml_paths(system.file("examples", package = "rjd3providers"))
#' xml_1_5 <- xml_series("Prod.xml", 1, 5, charset = "iso-8859-1")
#' q <- xml_id_properties(xml_1_5$moniker$id)
#' q$series <- 50
#' xml_to_id(q)
xml_to_id <- function(props) {
    jset <- .r2jd_xml_id(props)
    id <- .jcall("jdplus/text/base/r/XmlFiles", "S", "encode", jset)
    return(id)
}

#' Gets the list of the properties corresponding to the identifier of a moniker
#'
#' @param id
#'
#' @return
#' @export
#'
#' @examplesIf jversion >= 17
#' set_xml_paths(system.file("examples", package = "rjd3providers"))
#' xml_1_5 <- xml_series("Prod.xml", 1, 5, charset = "iso-8859-1")
#' xml_id_properties(xml_1_5$moniker$id)
xml_id_properties <- function(id) {
    jset <- .jcall("jdplus/text/base/r/XmlFiles", "Ljdplus/toolkit/base/tsp/DataSet;", "decode", id)
    return(.jd2r_xml_id(jset))
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
#' @examplesIf jversion >= 17
xml_change_file <- function(id, nfile, ofile = NULL) {
    if (is.null(ofile)) ofile <- ""
    nid <- .jcall("jdplus/text/base/r/XmlFiles", "S", "changeFile", id, nfile, ofile)
    return(nid)
}
