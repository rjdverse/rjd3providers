#' @title Deprecated functions
#'
#' @description
#' These functions are deprecated and are kept only for backward compatibility.
#' Users should use the corresponding non-deprecated functions instead:
#'
#' \itemize{
#'   \item \code{spreadsheet_to_id()} \eqn{\to} \code{\link{spreadsheet_properties_to_id}()}
#'   \item \code{spreadsheet_id_properties()} \eqn{\to} \code{\link{spreadsheet_id_to_properties}()}
#'   \item \code{txt_to_id()} \eqn{\to} \code{\link{txt_properties_to_id}()}
#'   \item \code{txt_id_properties()} \eqn{\to} \code{\link{txt_id_to_properties}()}
#'   \item \code{xml_to_id()} \eqn{\to} \code{\link{xml_properties_to_id}()}
#'   \item \code{xml_id_properties()} \eqn{\to} \code{\link{xml_id_to_properties}()}
#' }
#'
#' @param props The properties defining the identifier.
#' @param id Identifier of a series or of a collection of series.
#'
#' @returns
#' The same value as returned by the corresponding non-deprecated function.
#' The returned object represents an encoded identifier for a spreadsheet
#' series or collection.
#'
#' @name deprecated-rjd3providers
#'
#' @examples
#' \donttest{
#' # Deprecated: use spreadsheet_properties_to_id() instead
#' set_spreadsheet_paths(system.file("extdata", package = "rjd3providers"))
#' xls_s1_3 <- spreadsheet_series("Insee.xlsx", 1, 3)
#' id<-xls_s1_3$moniker$id
#' source<-spreadsheet_name()
#' # props<-spreadsheet_id_properties(xls_s1_3$moniker$id) # DEPRECATED
#' props<-spreadsheet_id_to_properties(xls_s1_3$moniker$id) # RECOMMENDED
#' props$gathering$period<-4
#' props$gathering$aggregation<-"Max"
#' # M<-rjd3toolkit::to_ts(spreadsheet_name(),
#' #                       spreadsheet_to_id(props))
#' M<-rjd3toolkit::to_ts(spreadsheet_name(), # DEPRECATED
#'                       spreadsheet_properties_to_id(props)) # RECOMMENDED
#' props$gathering$aggregation<-"Min"
#' # m<-rjd3toolkit::to_ts(spreadsheet_name(),
#' #                       spreadsheet_to_id(props)) # DEPRECATED
#' m<-rjd3toolkit::to_ts(spreadsheet_name(),
#'                       spreadsheet_properties_to_id(props)) # RECOMMENDED
#' ts.plot(ts.union(M$data,m$data), col=c("red", "blue"))
#' }
#'
#' @export
spreadsheet_to_id <- function(props) {
    .Deprecated("spreadsheet_properties_to_id")
    spreadsheet_properties_to_id(props)
}

#' @rdname deprecated-rjd3providers
#'
#' @returns
#' The same output as \code{\link{spreadsheet_id_to_properties}}.
#' It is a list with the elements of the identifier: file, sheet, series, and gathering
#' (which contains period, aggregation, partialAggregation, and cleanMissing flags).
#'
#' @examples
#' \donttest{
#' # Deprecated: use spreadsheet_id_to_properties() instead
#' set_spreadsheet_paths(system.file("extdata", package = "rjd3providers"))
#' xls_s1_3 <- spreadsheet_series("Insee.xlsx", 1, 3)
#' id<-xls_s1_3$moniker$id
#' # print(spreadsheet_id_properties(id)) # DEPRECATED
#' print(spreadsheet_id_to_properties(id)) # RECOMMENDED
#' }
#' @export
spreadsheet_id_properties <- function(id) {
    .Deprecated("spreadsheet_id_to_properties")
    spreadsheet_id_to_properties(id)
}

#' @rdname deprecated-rjd3providers
#'
#' @returns
#' The same output as \code{\link{txt_properties_to_id}()}: a string representing the internal identifier.
#'
#' @examples
#' \donttest{
#' # Deprecated: use txt_properties_to_id() instead
#' set_txt_paths(system.file("extdata", package = "rjd3providers"))
#' txt_15 <- txt_series("ABS.csv", series = 15, delimiter = "COMMA")
#' id<-txt_15$moniker$id
#' source<-txt_name()
#' # props<-txt_id_properties(id) # DEPRECATED
#' props<-txt_id_to_properties(id) # RECOMMENDED
#' props$gathering$period<-4
#' props$gathering$aggregation<-"Max"
#' # M<-rjd3toolkit::to_ts(txt_name(), txt_to_id(props)) # DEPRECATED
#' M<-rjd3toolkit::to_ts(txt_name(), txt_properties_to_id(props)) # RECOMMENDED
#' props$gathering$aggregation<-"Min"
#' # m<-rjd3toolkit::to_ts(txt_name(), txt_to_id(props)) # DEPRECATED
#' m<-rjd3toolkit::to_ts(txt_name(), txt_properties_to_id(props)) # RECOMMENDED
#' ts.plot(ts.union(M$data,m$data), col=c("red", "blue"))
#' }
#' @export
txt_to_id <- function(props) {
    .Deprecated("txt_properties_to_id")
    txt_properties_to_id(props)
}

#' @rdname deprecated-rjd3providers
#'
#' @returns
#' The same output as \code{\link{txt_id_to_properties}()}: a list with the elements of the id (file, series, format, gathering, etc.).
#'
#' @examples
#' \donttest{
#' # Deprecated: use txt_id_to_properties() instead
#' set_txt_paths(system.file("extdata", package = "rjd3providers"))
#' txt_15 <- txt_series("ABS.csv", series = 15, delimiter = "COMMA")
#' id<-txt_15$moniker$id
#' # print(txt_id_properties(id)) # DEPRECATED
#' print(txt_id_to_properties(id)) # RECOMMENDED
#' }
#' @export
txt_id_properties <- function(id) {
    .Deprecated("txt_id_to_properties")
    txt_id_to_properties(id)
}

#' @rdname deprecated-rjd3providers
#'
#' @returns
#' Returns the same output as \code{\link{xml_properties_to_id}()}: an internal identifier corresponding to the XML properties.
#'
#' @examples
#' \donttest{
#' # Deprecated: use xml_properties_to_id() instead
#' set_xml_paths(system.file("extdata", package = "rjd3providers"))
#' xml_1_5 <- xml_series("Prod.xml", 1, 5, charset = "iso-8859-1")
#' # q <- xml_id_properties(xml_1_5$moniker$id) # DEPRECATED
#' q <- xml_id_to_properties(xml_1_5$moniker$id) # RECOMMENDED
#' q$series <- 50
#' # xml_to_id(q) # DEPRECATED
#' xml_properties_to_id(q) # RECOMMENDED
#' }
#'
#' @export
xml_to_id <- function(props) {
    .Deprecated("xml_properties_to_id")
    xml_properties_to_id(props)
}

#' @rdname deprecated-rjd3providers
#'
#' @returns
#' Returns the same output as \code{\link{xml_id_to_properties}()}: a list of the XML identifier’s properties (file, collection[, series], charset, fullNames).
#'
#' @examples
#' \donttest{
#' # Deprecated: use xml_id_to_properties() instead
#' set_xml_paths(system.file("extdata", package = "rjd3providers"))
#' xml_1_5 <- xml_series("Prod.xml", 1, 5, charset = "iso-8859-1")
#' # xml_id_properties(xml_1_5$moniker$id) # DEPRECATED
#' xml_id_to_properties(xml_1_5$moniker$id) # RECOMMENDED
#' xml_1 <- xml_data("Prod.xml", 1, charset = "iso-8859-1")
#' # xml_id_properties(xml_1$moniker$id) # DEPRECATED
#' xml_id_to_properties(xml_1$moniker$id) # RECOMMENDED
#' }
#' @export
xml_id_properties <- function(id) {
    .Deprecated("xml_id_to_properties")
    xml_id_to_properties(id)
}
