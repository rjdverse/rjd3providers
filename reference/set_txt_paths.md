# Set the paths to txt files (to be used with relative identifiers)

Set the paths to txt files (to be used with relative identifiers)

## Usage

``` r
set_txt_paths(paths)
```

## Arguments

- paths:

  The folders containing the txt files Only used in relative addresses.

## Value

An internal java moniker

## Examples

``` r
set_txt_paths(system.file("extdata", package = "rjd3providers"))
#> Error in .jcall("jdplus/text/base/r/TxtFiles", "V", "setPaths", .jarray(paths)): java.lang.NoClassDefFoundError: Could not initialize class jdplus.spreadsheet.base.r.SpreadSheets
```
