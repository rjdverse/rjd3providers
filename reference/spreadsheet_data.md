# Retrieves all the time series in a specified sheet from a spreadsheet file.

Retrieves all the time series in a specified sheet from a spreadsheet
file.

## Usage

``` r
spreadsheet_data(
  file,
  sheet = 1,
  gathering.period = 0,
  gathering.aggregation = c("None", "Sum", "Average", "First", "Last", "Max", "Min"),
  gathering.partialAggregation = FALSE,
  gathering.cleanMissing = TRUE,
  fullNames = FALSE
)
```

## Arguments

- file:

  The spreadsheet file.

- sheet:

  The name or the 1-based position of the sheet containing the requested
  data.

- gathering.period:

  The annual frequency of the transformed series. If 0, the actual
  frequency is used.

- gathering.aggregation:

  The type of the aggregation to be applied on the series (only used if
  "period" is different from 0).

- gathering.partialAggregation:

  Specifies if the aggregation is performed or not when they are missing
  periods.

- gathering.cleanMissing:

  Specifies if missing values at the beginning or at the end of the data
  are removed from the series.

- fullNames:

  Specifies if full names (containing the name of the sheet and the name
  of the series) are used or not.

## Value

A ts collection with all the series.

## Examples

``` r
set_spreadsheet_paths(system.file("extdata", package = "rjd3providers"))
xls_all <- spreadsheet_data("Insee.xlsx", 1)
txt_all <- spreadsheet_data("Insee.xlsx", "FRANCE Textile")
```
