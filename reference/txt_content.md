# Title

Title

## Usage

``` r
txt_content(
  file,
  fmt.locale = NULL,
  fmt.date = NULL,
  fmt.number = NULL,
  fmt.ignoreNumberGrouping = TRUE,
  gathering.period = 0,
  gathering.aggregation = c("None", "Sum", "Average", "First", "Last", "Max", "Min"),
  gathering.partialAggregation = FALSE,
  gathering.includeMissing = TRUE,
  charset = NULL,
  delimiter = c("TAB", "SEMICOLON", "COMMA", "SPACE"),
  txtQualifier = c("NONE", "QUOTE", "DOUBLE_QUOTE"),
  header = TRUE,
  skip = 0
)
```

## Arguments

- skip:

## Examples

``` r
set_txt_paths(system.file("examples", package = "rjd3providers"))
txt_all <- txt_content("ABS.csv", delimiter = "COMMA")
```
