# Generates the id corresponding to a list of a text properties.

Generates the id corresponding to a list of a text properties.

## Usage

``` r
txt_properties_to_id(props)
```

## Arguments

- props:

  The properties defining the identifier.

## Value

The identifier corresponding to the properties.

## Examples

``` r
# \donttest{
set_txt_paths(system.file("extdata", package = "rjd3providers"))
#> Error in .jcall("jdplus/text/base/r/TxtFiles", "V", "setPaths", .jarray(paths)): java.lang.UnsupportedClassVersionError: jdplus/toolkit/base/api/timeseries/TsProvider has been compiled by a more recent version of the Java Runtime (class file version 65.0), this version of the Java Runtime only recognizes class file versions up to 61.0
txt_15 <- txt_series("ABS.csv", series = 15, delimiter = "COMMA")
#> Error in .jcall(obj = "jdplus/toolkit/base/r/util/Providers", returnSig = "Ljdplus/toolkit/base/api/timeseries/util/ObsGathering;",     method = "obsGathering", as.integer(period), as.character(aggregationType),     as.logical(allowPartialAggregation), !as.logical(cleanMissing)): RcallMethod: cannot determine object class
id<-txt_15$moniker$id
#> Error: object 'txt_15' not found
source<-txt_name()
#> Error in .jfield("jdplus/text/base/api/TxtProvider", name = "NAME"): cannot find class jdplus/text/base/api/TxtProvider
props<-txt_id_to_properties(id)
#> Error in .jcall("jdplus/text/base/r/TxtFiles", "Ljdplus/toolkit/base/tsp/DataSet;",     "decode", id): java.lang.UnsupportedClassVersionError: jdplus/toolkit/base/api/timeseries/TsProvider has been compiled by a more recent version of the Java Runtime (class file version 65.0), this version of the Java Runtime only recognizes class file versions up to 61.0
props$gathering$period<-4
#> Error: object 'props' not found
props$gathering$aggregation<-"Max"
#> Error: object 'props' not found
M<-rjd3toolkit::to_ts(txt_name(), txt_properties_to_id(props))
#> Error in .jfield("jdplus/text/base/api/TxtProvider", name = "NAME"): cannot find class jdplus/text/base/api/TxtProvider
props$gathering$aggregation<-"Min"
#> Error: object 'props' not found
m<-rjd3toolkit::to_ts(txt_name(), txt_properties_to_id(props))
#> Error in .jcall(obj = "jdplus/toolkit/base/api/timeseries/TsMoniker",     returnSig = "Ljdplus/toolkit/base/api/timeseries/TsMoniker;",     method = "of", source, id): java.lang.UnsupportedClassVersionError: jdplus/toolkit/base/api/timeseries/TsProvider has been compiled by a more recent version of the Java Runtime (class file version 65.0), this version of the Java Runtime only recognizes class file versions up to 61.0
ts.plot(ts.union(M$data,m$data), col=c("red", "blue"))
#> Error: object 'M' not found
# }
```
