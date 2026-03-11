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
if (FALSE) { # rjd3toolkit::get_java_version() >= rjd3toolkit::minimal_java_version
# \donttest{
set_spreadsheet_paths(system.file("extdata", package = "rjd3providers"))
print(spreadsheet_content("Insee.xlsx"))
# }
}
```
