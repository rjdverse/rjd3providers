# Gets the list of the properties corresponding to the identifier of a moniker.

Gets the list of the properties corresponding to the identifier of a
moniker.

## Usage

``` r
spreadsheet_id_to_properties(id)
```

## Arguments

- id:

  Identifier of a series or of a collection of series.

## Value

Returns a list with the elements of the id: file, sheet, series,
gathering); the gathering is a list with the following items: period (-1
by default), the aggregation ("None"), partialAggregation (FALSE),
includeMissing (FALSE).

## Details

When the period in the gathering list is defined, the user must specify
the aggregation type ("Sum", "Average", "First", "Last", "Min", "Max")
and some additional parameters (partial aggregation and suppression of
leading/trailing missing values).

## See also

\[spreadsheet_properties_to_id()\]

## Examples

``` r
# \donttest{
set_spreadsheet_paths(system.file("extdata", package = "rjd3providers"))
#> Error in .jcall("jdplus/spreadsheet/base/r/SpreadSheets", "V", "setPaths",     .jarray(paths)): java.lang.UnsupportedClassVersionError: jdplus/toolkit/base/r/util/Providers has been compiled by a more recent version of the Java Runtime (class file version 65.0), this version of the Java Runtime only recognizes class file versions up to 61.0
xls_s1_3 <- spreadsheet_series("Insee.xlsx", 1, 3)
#> Error in .jcall(obj = "jdplus/toolkit/base/r/util/Providers", returnSig = "Ljdplus/toolkit/base/api/timeseries/util/ObsGathering;",     method = "obsGathering", as.integer(period), as.character(aggregationType),     as.logical(allowPartialAggregation), !as.logical(cleanMissing)): RcallMethod: cannot determine object class
id<-xls_s1_3$moniker$id
#> Error: object 'xls_s1_3' not found
print(spreadsheet_id_to_properties(id))
#> Error in .jcall("jdplus/spreadsheet/base/r/SpreadSheets", "Ljdplus/toolkit/base/tsp/DataSet;",     "decode", id): java.lang.UnsupportedClassVersionError: jdplus/toolkit/base/r/util/Providers has been compiled by a more recent version of the Java Runtime (class file version 65.0), this version of the Java Runtime only recognizes class file versions up to 61.0
# }
```
