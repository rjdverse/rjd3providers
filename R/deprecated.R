#' Deprecated functions
#'
#' @name deprecated-rjd3providers
#' @param props The properties defining the identifier.
#' @param id Identifier of a series or of a collection of series.
#' @export
spreadsheet_to_id <- function(props) {
    .Deprecated("spreadsheet_properties_to_id")
    spreadsheet_properties_to_id(props)
}

#' @rdname deprecated-rjd3providers
#' @export
spreadsheet_id <- function(props) {
    .Deprecated("spreadsheet_properties_to_id")
    spreadsheet_properties_to_id(props)
}

#' @rdname deprecated-rjd3providers
#' @export
spreadsheet_id_properties <- function(id) {
    .Deprecated("spreadsheet_id_to_properties")
    spreadsheet_id_to_properties(id)
}

#' @rdname deprecated-rjd3providers
#' @export
spreadsheet_properties <- function(id) {
    .Deprecated("spreadsheet_id_to_properties")
    spreadsheet_id_to_properties(id)
}

#' @rdname deprecated-rjd3providers
#' @export
txt_to_id <- function(props) {
    .Deprecated("txt_properties_to_id")
    txt_properties_to_id(props)
}

#' @rdname deprecated-rjd3providers
#' @export
txt_id <- function(props) {
    .Deprecated("txt_properties_to_id")
    txt_properties_to_id(props)
}

#' @rdname deprecated-rjd3providers
#' @export
txt_id_properties <- function(id) {
    .Deprecated("txt_id_to_properties")
    txt_id_to_properties(id)
}

#' @rdname deprecated-rjd3providers
#' @export
txt_properties <- function(id) {
    .Deprecated("txt_id_to_properties")
    txt_id_to_properties(id)
}

#' @rdname deprecated-rjd3providers
#' @export
xml_to_id <- function(props) {
    .Deprecated("xml_properties_to_id")
    xml_properties_to_id(props)
}

#' @rdname deprecated-rjd3providers
#' @export
xml_id <- function(props) {
    .Deprecated("xml_properties_to_id")
    xml_properties_to_id(props)
}

#' @rdname deprecated-rjd3providers
#' @export
xml_id_properties <- function(id) {
    .Deprecated("xml_id_to_properties")
    xml_id_to_properties(id)
}

#' @rdname deprecated-rjd3providers
#' @export
xml_properties <- function(id) {
    .Deprecated("xml_id_to_properties")
    xml_id_to_properties(id)
}
