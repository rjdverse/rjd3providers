# Generates the id corresponding to a list of spreadsheet properties.

Generates the id corresponding to a list of spreadsheet properties.

## Usage

``` r
spreadsheet_properties_to_id(props)
```

## Arguments

- props:

  The properties defining the identifier.

## Value

The identifier corresponding to the properties.

## Examples

``` r
# \donttest{
set_spreadsheet_paths(system.file("extdata", package = "rjd3providers"))
#> Error in .jcall("jdplus/spreadsheet/base/r/SpreadSheets", "V", "setPaths",     .jarray(paths)): java.lang.UnsupportedClassVersionError: jdplus/toolkit/base/api/timeseries/TsProvider has been compiled by a more recent version of the Java Runtime (class file version 65.0), this version of the Java Runtime only recognizes class file versions up to 61.0
xls_s1_3 <- spreadsheet_series("Insee.xlsx", 1, 3)
#> Error in .jcall(obj = "jdplus/toolkit/base/r/util/Providers", returnSig = "Ljdplus/toolkit/base/api/timeseries/util/ObsGathering;",     method = "obsGathering", as.integer(period), as.character(aggregationType),     as.logical(allowPartialAggregation), !as.logical(cleanMissing)): RcallMethod: cannot determine object class
id<-xls_s1_3$moniker$id
#> Error: object 'xls_s1_3' not found
source<-spreadsheet_name()
#> Error in .jfield("jdplus/spreadsheet/base/api/SpreadSheetProvider", "S",     name = "NAME"): cannot find class jdplus/spreadsheet/base/api/SpreadSheetProvider
props<-spreadsheet_id_to_properties(xls_s1_3$moniker$id)
#> Error in .jcall("jdplus/spreadsheet/base/r/SpreadSheets", "Ljdplus/toolkit/base/tsp/DataSet;",     "decode", id): java.lang.UnsupportedClassVersionError: jdplus/toolkit/base/api/timeseries/TsProvider has been compiled by a more recent version of the Java Runtime (class file version 65.0), this version of the Java Runtime only recognizes class file versions up to 61.0
props$gathering$period<-4
#> Error: object 'props' not found
props$gathering$aggregation<-"Max"
#> Error: object 'props' not found
M<-rjd3toolkit::to_ts(spreadsheet_name(), spreadsheet_properties_to_id(props))
#> Error in .jfield("jdplus/spreadsheet/base/api/SpreadSheetProvider", "S",     name = "NAME"): cannot find class jdplus/spreadsheet/base/api/SpreadSheetProvider
props$gathering$aggregation<-"Min"
#> Error: object 'props' not found
m<-rjd3toolkit::to_ts(spreadsheet_name(), spreadsheet_properties_to_id(props))
#> Error in .jcall(obj = "jdplus/toolkit/base/api/timeseries/TsMoniker",     returnSig = "Ljdplus/toolkit/base/api/timeseries/TsMoniker;",     method = "of", source, id): java.lang.UnsupportedClassVersionError: jdplus/toolkit/base/api/timeseries/TsProvider has been compiled by a more recent version of the Java Runtime (class file version 65.0), this version of the Java Runtime only recognizes class file versions up to 61.0
ts.plot(ts.union(M$data,m$data), col=c("red", "blue"))
#> Error: object 'M' not found
# }
```
