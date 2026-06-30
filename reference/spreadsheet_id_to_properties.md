# Gets the list of the properties corresponding to the identifier of a moniker.

Gets the list of the properties corresponding to the identifier of a
moniker.

## Usage

``` r
spreadsheet_id_to_properties(id)
```

## Arguments

- id:

  Identifier of a series or of a collection of series.

## Value

Returns a list with the elements of the id: file, sheet, series,
gathering); the gathering is a list with the following items: period (-1
by default), the aggregation ("None"), partialAggregation (FALSE),
includeMissing (FALSE).

## Details

When the period in the gathering list is defined, the user must specify
the aggregation type ("Sum", "Average", "First", "Last", "Min", "Max")
and some additional parameters (partial aggregation and suppression of
leading/trailing missing values).

## See also

[`spreadsheet_properties_to_id()`](https://rjdverse.github.io/rjd3providers/reference/spreadsheet_properties_to_id.md)

## Examples

``` r
# \donttest{
set_spreadsheet_paths(system.file("extdata", package = "rjd3providers"))
xls_s1_3 <- spreadsheet_series("Insee.xlsx", 1, 3)
id<-xls_s1_3$moniker$id
print(spreadsheet_id_to_properties(id))
#> $file
#> [1] "Insee.xlsx"
#> 
#> $sheet
#> [1] "FRANCE Textile"
#> 
#> $series
#> [1] "Préparation de fibres textiles et filature 001563401"
#> 
#> $gathering
#> $gathering$period
#> [1] -1
#> 
#> $gathering$aggregation
#> [1] "None"
#> 
#> $gathering$partialAggregation
#> [1] FALSE
#> 
#> $gathering$cleanMissing
#> [1] TRUE
#> 
#> 
# }
```
