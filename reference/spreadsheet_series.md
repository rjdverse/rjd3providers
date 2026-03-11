# Retrieves a time series from a spreadsheet file.

Retrieves a time series from a spreadsheet file.

## Usage

``` r
spreadsheet_series(
  file,
  sheet = 1,
  series = 1,
  gathering.period = 0,
  gathering.aggregation = c("None", "Sum", "Average", "First", "Last", "Max", "Min"),
  gathering.partialAggregation = FALSE,
  gathering.cleanMissing = TRUE,
  fullName = TRUE
)
```

## Arguments

- file:

  The spreadsheet file.

- sheet:

  The name or the 1-based position of the sheet containing the requested
  data.

- series:

  The name or the 1-based position of the series in the selected sheet.

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

  Specifies if missing values are removed at the beginning or at the end
  of the data.

- fullName:

  Specifies if a full name (containing the name of the sheet and the
  name of the series) is used or not.

## Value

Returns the specified time series.

## Examples

``` r
# \donttest{
set_spreadsheet_paths(system.file("extdata", package = "rjd3providers"))
xls_s1_3 <- spreadsheet_series("Insee.xlsx", 1, 3)
txt_s1 <- spreadsheet_series("Insee.xlsx", "FRANCE Textile", 1)
# }
```
