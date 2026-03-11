# Provides the content of a text file designed for time series

Provides the content of a text file designed for time series

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
  gathering.cleanMissing = TRUE,
  charset = NULL,
  delimiter = c("TAB", "SEMICOLON", "COMMA", "SPACE"),
  txtQualifier = c("NONE", "QUOTE", "DOUBLE_QUOTE"),
  header = TRUE,
  skip = 0
)
```

## Arguments

- file:

  The text file

- fmt.locale:

  Locale language. Null to use the default

- fmt.date:

  Format of the date. Null to use the default of the locale

- fmt.number:

  Format of the number. Null to use the default of the locale

- fmt.ignoreNumberGrouping:

  Ignore number grouping

- gathering.period:

  The annual frequency of the series. If 0, the frequency

- gathering.aggregation:

  The type of the aggregation to be applied on the series (only used if
  "period" is different from 0)

- gathering.partialAggregation:

  Specifies if the aggregation is performed or not when they are missing
  periods

- gathering.cleanMissing:

  Specifies if missing values at the beginning or at the end of the data
  are removed from the series.

- charset:

  Specifies the charset

- delimiter:

  Specifies the delimiter. Should be in ("TAB", "SEMICOLON", "COMMA",
  "SPACE")

- txtQualifier:

  Character used to qualify text. Should be in ("NONE", "QUOTE",
  "DOUBLE_QUOTE")

- header:

  The file contains headers

- skip:

  Skips some lines

## Value

Provides all the names of the time series contained in the text file

## Examples

``` r
# \donttest{
set_txt_paths(system.file("extdata", package = "rjd3providers"))
#> Error in .jcall("jdplus/text/base/r/TxtFiles", "V", "setPaths", .jarray(paths)): RcallMethod: cannot determine object class
txt_all <- txt_content("ABS.csv", delimiter = "COMMA")
#> Error in .jcall(obj = "jdplus/text/base/r/Utility", returnSig = "Ljdplus/toolkit/base/tsp/util/ObsFormat;",     method = "obsFormat", as.character(locale), as.character(dateFmt),     as.character(numberFmt), as.logical(ignoreNumberGrouping)): java.lang.NoClassDefFoundError: Could not initialize class jdplus.text.base.r.TxtFiles
# }
```
