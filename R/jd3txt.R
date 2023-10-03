#' @include providers.R

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

.r2jd_txt_id<-function(id){
  agg<-id$gathering$aggregation
  if (is.null(agg)) agg<-""
  jsrc<-.spreadsheet_source(id$file, id$gathering$period, agg, id$gathering$partial, id$gathering$missing)
  if (is.null(id$series))
    return (.jcall("jdplus/spreadsheet/base/r/SpreadSheets",  "Ljdplus/toolkit/base/tsp/DataSet;", "sheetDataSet", jsrc, id$sheet))
  else
    return (.jcall("jdplus/spreadsheet/base/r/SpreadSheets",  "Ljdplus/toolkit/base/tsp/DataSet;", "seriesDataSet", jsrc, id$sheet, id$series))
}

.jd2r_txt_id<-function(jset){
  jbean<-.jcall("jdplus/spreadsheet/base/r/SpreadSheets","Ljdplus/spreadsheet/base/api/SpreadSheetBean;", "sourceOf", jset)
  jfile<-.jcall(jbean, "Ljava/io/File;", "getFile")
  jgathering<-.jcall(jbean, "Ljdplus/toolkit/base/api/timeseries/util/ObsGathering;", "getGathering")
  junit<-.jcall(jgathering, "Ljdplus/toolkit/base/api/timeseries/TsUnit;", "getUnit" )
  jagg<-.jcall(jgathering, "Ljdplus/toolkit/base/api/data/AggregationType;", "getAggregationType" )
  return (list(
    file=.jcall(jfile, "S", "getName"),
    sheet=.jcall(jset, "S", "getParameter", "sheetName"),
    series=.jcall(jset, "S", "getParameter", "seriesName"),
    gathering=list(period=.jcall(junit, "I", "getAnnualFrequency"), 
                   aggregation=.jcall(jagg, "S", "name"), 
                   partial=.jcall(jgathering, "Z", "isAllowPartialAggregation"), 
                   missing=.jcall(jgathering, "Z", "isIncludeMissingValues")  )
  ))
}

#' Title
#'
#' @return
#' @export
#'
#' @examples
txt_name<-function(){
  return (.jfield("jdplus/text/base/api/TxtProvider", name='NAME'))
}

#' Generates a java moniker for the corresponding id
#'
#' @param id 
#'
#' @return
#' @export
#'
#' @examples
.spreadsheet_moniker<-function(id){
  jmoniker=.jcall("jdplus/base/toolkit/api/timeseries/TsMoniker", "Ljdplus/base/toolkit/api/timeseries/TsMoniker;", "of", 
                  txt_name(), id )
}

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

#' Generates the id corresponding to a list of properties
#'
#' @param props 
#'
#' @return
#' @export
#'
#' @examples
txt_to_id<-function(props){
  jset<-.r2jd_txt_id(props)
  id<-.jcall("jdplus/text/base/r/TxtFiles","S", "encode", jset)
  return (id)
}

#' Gets the list of the properties corresponding to the identifier of a moniker
#'
#' @param id 
#'
#' @return
#' @export
#'
#' @examples
txt_id_properties<-function(id){
  jset<-.jcall("jdplus/text/base/r/TxtFiles","Ljdplus/toolkit/base/tsp/DataSet;", "decode", id)
  return (.jd2r_txt_id(jset))
}



