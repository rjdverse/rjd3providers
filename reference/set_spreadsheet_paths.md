# Set the paths to spreadsheet files (to be used with relative identifiers).

Set the paths to spreadsheet files (to be used with relative
identifiers).

## Usage

``` r
set_spreadsheet_paths(paths)
```

## Arguments

- paths:

  The folders containing the spreadsheet files Only used in relative
  addresses.

## Value

No output.

## Examples

``` r
set_spreadsheet_paths(system.file("extdata", package = "rjd3providers"))
#> Error in .jcall("jdplus/spreadsheet/base/r/SpreadSheets", "V", "setPaths",     .jarray(paths)): RcallMethod: cannot determine object class
```
