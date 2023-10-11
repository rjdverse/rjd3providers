
#' @export
#' @rdname jd3_utilities
.obs_gathering<-function(period=0, aggregationType=NULL,allowPartialAggregation=F, includeMissing=F){
  if (is.null(aggregationType)) aggregationType<-"None"
  if (is.null(allowPartialAggregation)) allowPartialAggregation=F
  if (is.null(includeMissing)) includeMissing=F
  jobs<-.jcall("jdplus/toolkit/base/r/util/Providers" ,"Ljdplus/toolkit/base/api/timeseries/util/ObsGathering;",
               "obsGathering", as.integer(period), as.character(aggregationType), as.logical(allowPartialAggregation), as.logical(includeMissing))
  return (jobs)
}

#' @export
#' @rdname jd3_utilities
.obs_format<-function(locale=NULL, dateFmt=NULL, numberFmt=NULL, ignoreNumberGrouping=T){
  if (is.null(locale)) locale<-""
  if (is.null(dateFmt)) dateFmt<-""
  if (is.null(numberFmt)) numberFmt<-""
  jobs<-.jcall("jdplus/text/base/r/Utility" ,"Ljdplus/toolkit/base/tsp/util/ObsFormat;",
               "obsFormat", as.character(locale), as.character(dateFmt), as.character(numberFmt), as.logical(ignoreNumberGrouping))
  return (jobs)
}

