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

.obs_gathering(period=4, aggregationType="Sum")
#> [1] "Java-Object{ObsGathering(epoch=1970-01-01T00:00, unit=P3M, aggregationType=Sum, allowPartialAggregation=false, includeMissingValues=false)}"
```
