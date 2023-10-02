#' @include providers.R

#' Title
#'
#' @param file 
#' @param period 
#' @param aggregation 
#' @param partialAggregation 
#' @param cleanMissing
#'
#' @return
#' @export
#'
#' @examples
.spreadsheet_source<-function(file, period=0, aggregation = "None", partialAggregation=F, cleanMissing=T){
  jgathering=.obs_gathering(period, aggregation, partialAggregation, cleanMissing)
  jsource<-.jcall("jdplus/spreadsheet/base/r/SpreadSheets", "Ljdplus/toolkit/base/tsp/DataSource;", "source", 
         as.character(file), .jnull("jdplus/toolkit/base/tsp/util/ObsFormat"), jgathering)
  return (jsource)
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