#' @include providers.R

#' Title
#'
#' @param paths 
#'
#' @return
#' @export
#'
#' @examples
set_txt_paths<-function(paths){
  .jcall("jdplus/text/base/r/TxtFiles","V", "setPaths", .jarray(paths))
}

.txt_source<-function(file, fmt.locale=NULL, fmt.date=NULL, fmt.number=NULL, fmt.ignore_grouping=T, 
                      gathering.period=0, gathering.agg=c("Sum", "Average", "first", "Last", "Max", "Min"), gathering.partial=F, gathering.nomissing=T,
                      charset=NULL, delimiter=c('TAB', 'SEMICOLON', 'COMMA', 'SPACE'), txtqualifier=c('NONE', 'QUOTE', 'DOUBLE_QUOTE'), header=T, skip=0){
  gathering.agg=match.arg(gathering.agg)
  delimiter<-match.arg(delimiter)
  txtqualifier<-match.arg(txtqualifier)
  jfmt<-.obs_format(fmt.locale, fmt.date, fmt.number, fmt.ignore_grouping)
  jgathering<-.obs_gathering(gathering.period, gathering.agg, gathering.partial, gathering.nomissing)
  if (is.null(charset)) charset<-'utf-8'
  jsource<-.jcall("jdplus/text/base/r/TxtFiles", "Ljdplus/toolkit/base/tsp/DataSource;", "source", 
                  as.character(file), jfmt, jgathering, as.character(charset), as.character(delimiter), 
                  as.character(txtqualifier), as.logical(header), as.integer(skip))
  return (jsource)
}

#' Title
#'
#' @param file 
#' @param fmt.locale 
#' @param fmt.date 
#' @param fmt.number 
#' @param fmt.ignore_grouping 
#' @param gathering.period 
#' @param gathering.agg 
#' @param gathering.partial 
#' @param gathering.nomissing 
#' @param charset 
#' @param delimiter 
#' @param txtqualifier 
#' @param header 
#' @param skip 
#'
#' @return
#' @export
#'
#' @examples
#' set_txt_paths(system.file("examples", package="rjd3providers"))
#' txt_all<-txt_content("abs.csv", delimiter = 'COMMA')
txt_content<-function(file, fmt.locale=NULL, fmt.date=NULL, fmt.number=NULL, fmt.ignore_grouping=T, 
                      gathering.period=0, gathering.agg=c("Sum", "Average", "first", "Last", "Max", "Min"), gathering.partial=F, gathering.nomissing=T,
                      charset=NULL, delimiter=c('TAB', 'SEMICOLON', 'COMMA', 'SPACE'), txtqualifier=c('NONE', 'QUOTE', 'DOUBLE_QUOTE'), header=T, skip=0){
  jsource<-.txt_source(file, fmt.locale, fmt.date, fmt.number, fmt.ignore_grouping, 
                       gathering.period, gathering.agg, gathering.partial, gathering.nomissing,
                       charset, delimiter, txtqualifier, header, skip)
  series<-.jcall("jdplus/text/base/r/TxtFiles","[S", "series", jsource)
  return (series)
}

#' Title
#'
#' @param file 
#' @param fmt.locale 
#' @param fmt.date 
#' @param fmt.number 
#' @param fmt.ignore_grouping 
#' @param gathering.period 
#' @param gathering.agg 
#' @param gathering.partial 
#' @param gathering.nomissing 
#' @param charset 
#' @param delimiter 
#' @param txtqualifier 
#' @param header 
#' @param skip 
#'
#' @return
#' @export
#'
#' @examples
#' set_txt_paths(system.file("examples", package="rjd3providers"))
#' all<-txt_data("abs.csv", delimiter = 'COMMA')
txt_data<-function(file, fmt.locale=NULL, fmt.date=NULL, fmt.number=NULL, fmt.ignore_grouping=T, 
                   gathering.period=0, gathering.agg=c("Sum", "Average", "first", "Last", "Max", "Min"), gathering.partial=F, gathering.nomissing=T,
                   charset=NULL, delimiter=c('TAB', 'SEMICOLON', 'COMMA', 'SPACE'), txtqualifier=c('NONE', 'QUOTE', 'DOUBLE_QUOTE'), header=T, skip=0){
  jsource<-.txt_source(file, fmt.locale, fmt.date, fmt.number, fmt.ignore_grouping, 
                       gathering.period, gathering.agg, gathering.partial, gathering.nomissing,
                       charset, delimiter, txtqualifier, header, skip)
  jcoll<-.jcall("jdplus/text/base/r/TxtFiles", "Ljdplus/toolkit/base/api/timeseries/TsCollection;", "collection", jsource)
  return (rjd3toolkit::.jd2r_tscollection(jcoll))
}

#' Title
#'
#' @param file 
#' @param series 
#' @param fmt.locale 
#' @param fmt.date 
#' @param fmt.number 
#' @param fmt.ignore_grouping 
#' @param gathering.period 
#' @param gathering.agg 
#' @param gathering.partial 
#' @param gathering.nomissing 
#' @param charset 
#' @param delimiter 
#' @param txtqualifier 
#' @param header 
#' @param skip 
#'
#' @return
#' @export
#'
#' @examples
#' set_txt_paths(system.file("examples", package="rjd3providers"))
#' txt_5<-txt_series("abs.csv", series=15, delimiter = 'COMMA')
txt_series<-function(file, series, fmt.locale=NULL, fmt.date=NULL, fmt.number=NULL, fmt.ignore_grouping=T, 
                     gathering.period=0, gathering.agg=c("Sum", "Average", "first", "Last", "Max", "Min"), gathering.partial=F, gathering.nomissing=T,
                     charset=NULL, delimiter=c('TAB', 'SEMICOLON', 'COMMA', 'SPACE'), txtqualifier=c('NONE', 'QUOTE', 'DOUBLE_QUOTE'), header=T, skip=0){
  jsource<-.txt_source(file, fmt.locale, fmt.date, fmt.number, fmt.ignore_grouping, 
                       gathering.period, gathering.agg, gathering.partial, gathering.nomissing,
                       charset, delimiter, txtqualifier, header, skip)
  js<-.jcall("jdplus/text/base/r/TxtFiles", "Ljdplus/toolkit/base/api/timeseries/Ts;", "series", jsource, as.integer(series))
  return (rjd3toolkit::.jd2r_ts(js))
}