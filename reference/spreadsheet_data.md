# Title

Title

## Usage

``` r
spreadsheet_data(
  file,
  sheet = 1,
  period = 0,
  aggregation = c("None", "Sum", "Average", "First", "Last", "Max", "Min"),
  partialAggregation = FALSE,
  cleanMissings = TRUE,
  fullNames = FALSE
)
```

## Arguments

- fullNames:

## Examples

``` r
set_spreadsheet_paths(system.file("examples", package = "rjd3providers"))
xls_all <- spreadsheet_data("Insee.xlsx", 1)
```
