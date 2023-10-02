#' @include providers.R

#' Title
#'
#' @param paths 
#'
#' @return
#' @export
#'
#' @examples
set_xml_paths<-function(paths){
  .jcall("jdplus/text/base/r/XmlFiles","V", "setPaths", .jarray(paths))
}

#' Title
#'
#' @param file 
#' @param cs 
#'
#' @return
#' @export
#'
#' @examples
.xml_source<-function(file, cs=NULL){
  if (is.null(cs)){
    cs<-"utf-8"
  }
  
  jsource<-.jcall("jdplus/text/base/r/XmlFiles", "Ljdplus/toolkit/base/tsp/DataSource;", "source", 
                  as.character(file), as.character(cs))
  return (jsource)
}

#' Title
#'
#' @param file 
#'
#' @return
#' @export
#'
#' @examples
xml_content<-function(file, charset=NULL){
  jsource<-.xml_source(file, charset)
  sheets<-.jcall("jdplus/text/base/r/XmlFiles","[S", "sheets", jsource)
  rslt<-list()
  n=length(sheets)
  for (i in 1:n){
    series<-.jcall("jdplus/text/base/r/XmlFiles","[S", "series", jsource, as.integer(i))
    rslt[[sheets[i]]]<-series
  }
  return (rslt)
}

#' Title
#'
#' @param file 
#' @param sheet 
#' @param charset 
#' @param fullNames 
#'
#' @return
#' @export
#'
#' @examples
xml_data<-function(file, sheet=1, charset=NULL, fullNames=F){
  jsource<-.xml_source(file, charset)
  jcoll<-.jcall("jdplus/text/base/r/XmlFiles", "Ljdplus/toolkit/base/api/timeseries/TsCollection;", "collection", jsource, as.integer(sheet), fullNames)
  return (rjd3toolkit::.jd2r_tscollection(jcoll))
}

#' Title
#'
#' @param file 
#' @param sheet 
#' @param series 
#' @param charset 
#' @param fullName 
#'
#' @return
#' @export
#'
#' @examples
xml_series<-function(file, sheet=1, series=1, charset=NULL, fullName=T){
  jsource<-.xml_source(file, charset)
  jcoll<-.jcall("jdplus/text/base/r/XmlFiles", "Ljdplus/toolkit/base/api/timeseries/Ts;", "series", jsource, as.integer(sheet), as.integer(series), fullName)
  return (rjd3toolkit::.jd2r_ts(jcoll))
}

