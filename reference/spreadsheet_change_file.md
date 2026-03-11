# Change the file of a spreadsheet moniker.

Change the file of a spreadsheet moniker.

## Usage

``` r
spreadsheet_change_file(id, nfile, ofile = NULL)
```

## Arguments

- id:

  Identifier of a series or of a collection of series.

- nfile:

  New file name.

- ofile:

  Old file name. NULL or "" to change any file to the new file.

## Value

Returns the new identifier.

## Examples

``` r
# \donttest{
set_spreadsheet_paths(system.file("extdata", package = "rjd3providers"))
#> Error in .jcall("jdplus/spreadsheet/base/r/SpreadSheets", "V", "setPaths",     .jarray(paths)): java.lang.NoClassDefFoundError: Could not initialize class jdplus.text.base.r.XmlFiles
xls_all <- spreadsheet_data("Insee.xlsx", 1)
#> Error in .jcall(obj = "jdplus/toolkit/base/r/util/Providers", returnSig = "Ljdplus/toolkit/base/api/timeseries/util/ObsGathering;",     method = "obsGathering", as.integer(period), as.character(aggregationType),     as.logical(allowPartialAggregation), !as.logical(cleanMissing)): RcallMethod: cannot determine object class
id<-xls_all$moniker$id
#> Error: object 'xls_all' not found
spreadsheet_change_file(id, "test.xlsx")
#> Error in .jcall("jdplus/spreadsheet/base/r/SpreadSheets", "S", "changeFile",     id, nfile, ofile): java.lang.UnsupportedClassVersionError: jdplus/toolkit/base/r/util/Providers has been compiled by a more recent version of the Java Runtime (class file version 65.0), this version of the Java Runtime only recognizes class file versions up to 61.0
# }
```
