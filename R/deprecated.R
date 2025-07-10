#' Deprecated functions
#'
#' @name deprecated-rjd3providers
#' @param props The properties defining the identifier.
#' @export
spreadsheet_to_id <- function(props) {
    .Deprecated("spreadsheet_id")
    spreadsheet_id(props)
}

#' @name deprecated-rjd3providers
#' @param id Identifier of a series or of a collection of series.
#' @export
spreadsheet_id_properties <- function(id) {
    .Deprecated("spreadsheet_properties")
    spreadsheet_properties(id)
}

#' @name deprecated-rjd3providers
#' @param props The properties defining the identifier.
#' @export
txt_to_id <- function(props) {
    .Deprecated("txt_id")
    txt_id(props)
}

#' @name deprecated-rjd3providers
#' @param id Identifier of a series or of a collection of series.
#' @export
txt_id_properties <- function(id) {
    .Deprecated("txt_properties")
    txt_properties(id)
}

#' @name deprecated-rjd3providers
#' @param props The properties defining the identifier.
#' @export
xml_to_id <- function(props) {
    .Deprecated("xml_id")
    xml_id(props)
}

#' @name deprecated-rjd3providers
#' @param id Identifier of a series or of a collection of series.
#' @export
xml_id_properties <- function(id) {
    .Deprecated("xml_properties")
    xml_properties(id)
}
