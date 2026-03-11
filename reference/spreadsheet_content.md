# Provides the content of a spreadsheet designed for time series.

Provides the content of a spreadsheet designed for time series.

## Usage

``` r
spreadsheet_content(file)
```

## Arguments

- file:

  The considered workbook.

## Value

Provides all the names of the time series contained in the workbook,
organized by worksheet; the output is a list of lists of names.

## Examples

``` r
# \donttest{
set_spreadsheet_paths(system.file("extdata", package = "rjd3providers"))
#> Error in .jcall("jdplus/spreadsheet/base/r/SpreadSheets", "V", "setPaths",     .jarray(paths)): RcallMethod: cannot determine object class
print(spreadsheet_content("Insee.xlsx"))
#> Error in .jcall(obj = "jdplus/toolkit/base/r/util/Providers", returnSig = "Ljdplus/toolkit/base/api/timeseries/util/ObsGathering;",     method = "obsGathering", as.integer(period), as.character(aggregationType),     as.logical(allowPartialAggregation), !as.logical(cleanMissing)): java.lang.NoClassDefFoundError: Could not initialize class jdplus.spreadsheet.base.r.SpreadSheets
# }
```
