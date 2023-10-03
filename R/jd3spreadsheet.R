#' @include providers.R
NULL


.spreadsheet_source<-function(file, period=0, aggregation = "None", partialAggregation=F, cleanMissing=T){
  jgathering=.obs_gathering(period, aggregation, partialAggregation, cleanMissing)
  jsource<-.jcall("jdplus/spreadsheet/base/r/SpreadSheets", "Ljdplus/toolkit/base/tsp/DataSource;", "source", 
         as.character(file), .jnull("jdplus/toolkit/base/tsp/util/ObsFormat"), jgathering)
  return (jsource)
}

.r2jd_spreadsheet_id<-function(id){
  agg<-id$gathering$aggregation
  if (is.null(agg)) agg<-""
  jsrc<-.spreadsheet_source(id$file, id$gathering$period, agg, id$gathering$partial, id$gathering$missing)
  if (is.null(id$series))
    return (.jcall("jdplus/spreadsheet/base/r/SpreadSheets",  "Ljdplus/toolkit/base/tsp/DataSet;", "sheetDataSet", jsrc, id$sheet))
  else
    return (.jcall("jdplus/spreadsheet/base/r/SpreadSheets",  "Ljdplus/toolkit/base/tsp/DataSet;", "seriesDataSet", jsrc, id$sheet, id$series))
}

.jd2r_spreadsheet_id<-function(jset){
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
spreadsheet_name<-function(){
  return (.jfield("jdplus/spreadsheet/base/api/SpreadSheetProvider", name='NAME'))
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
                  .jfield("jdplus/spreadsheet/base/api/SpreadSheetProvider", name='NAME'), id )
}

#' Title
#'
#' @param file 
#' @param sheet 
#' @param period 
#' @param aggregation 
#' @param partialAggregation 
#' @param cleanMissings 
#' @param fullNames 
#'
#' @return
#' @export
#'
#' @examples
spreadsheet_data<-function(file, sheet=1, period=0, aggregation = "None", partialAggregation=F, cleanMissings=T, fullNames=F){
  jsource<-.spreadsheet_source(file, period, aggregation, partialAggregation, cleanMissings)
  jcoll<-.jcall("jdplus/spreadsheet/base/r/SpreadSheets", "Ljdplus/toolkit/base/api/timeseries/TsCollection;", "collection", jsource, as.integer(sheet), fullNames)
  return (rjd3toolkit::.jd2r_tscollection(jcoll))
}

#' Title
#'
#' @param file 
#' @param sheet 
#' @param series 
#' @param period 
#' @param aggregation 
#' @param partialAggregation 
#' @param cleanMissings 
#' @param fullName 
#'
#' @return
#' @export
#'
#' @examples
spreadsheet_series<-function(file, sheet=1, series=1,  period=0, aggregation = "None", partialAggregation=F, cleanMissings=T, fullName=T){
  jsource<-.spreadsheet_source(file, period, aggregation, partialAggregation, cleanMissings)
  jcoll<-.jcall("jdplus/spreadsheet/base/r/SpreadSheets", "Ljdplus/toolkit/base/api/timeseries/Ts;", "series", jsource, as.integer(sheet), as.integer(series), fullName)
  return (rjd3toolkit::.jd2r_ts(jcoll))
}

#' Title
#'
#' @param file 
#'
#' @return
#' @export
#'
#' @examples
spreadsheet_content<-function(file){
  jsource<-.spreadsheet_source(file, 0, "None", F, F)
  sheets<-.jcall("jdplus/spreadsheet/base/r/SpreadSheets","[S", "sheets", jsource)
  rslt<-list()
  n=length(sheets)
  for (i in 1:n){
    series<-.jcall("jdplus/spreadsheet/base/r/SpreadSheets","[S", "series", jsource, as.integer(i))
    rslt[[sheets[i]]]<-series
  }
  return (rslt)
}

#' Title
#'
#' @param paths 
#'
#' @return
#' @export
#'
#' @examples
set_spreadsheet_paths<-function(paths){
  .jcall("jdplus/spreadsheet/base/r/SpreadSheets","V", "setPaths", .jarray(paths))
}

#' Generates the id corresponding to a list of properties
#'
#' @param props 
#'
#' @return
#' @export
#'
#' @examples
spreadsheet_to_id<-function(props){
  jset<-.r2jd_spreadsheet_id(props)
  id<-.jcall("jdplus/spreadsheet/base/r/SpreadSheets","S", "encode", jset)
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
spreadsheet_id_properties<-function(id){
  jset<-.jcall("jdplus/spreadsheet/base/r/SpreadSheets","Ljdplus/toolkit/base/tsp/DataSet;", "decode", id)
  return (.jd2r_spreadsheet_id(jset))
}

