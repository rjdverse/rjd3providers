# Generates the Java object for automatic aggregation of the data

Generates the Java object for automatic aggregation of the data

## Usage

``` r
.obs_gathering(
  period = 0,
  aggregationType = NULL,
  allowPartialAggregation = FALSE,
  cleanMissing = TRUE
)
```

## Arguments

- period:

  The annual frequency of the series. If 0, the frequency.

- aggregationType:

  The type of the aggregation to be applied on the series (only used if
  "period" is different from 0).

- allowPartialAggregation:

  Specifies if the aggregation is performed or not when they are missing
  periods.

- cleanMissing:

  Specifies if missing values at the beginning and at the end of the
  data are removed from the series.

## Value

An internal Java object.

## Examples

``` r
if (FALSE) { # rjd3toolkit::get_java_version() >= rjd3toolkit::minimal_java_version

.obs_gathering(period=4, aggregationType="Sum")
}
```
