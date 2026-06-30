# Gets the list of the properties corresponding to the identifier of a moniker

Gets the list of the properties corresponding to the identifier of a
moniker

## Usage

``` r
txt_id_to_properties(id)
```

## Arguments

- id:

  Identifier of a series or of a collection of series.

## Value

Returns a list with the elements of the id: file , series, format,
gathering, ....

## Examples

``` r
# \donttest{
set_txt_paths(system.file("extdata", package = "rjd3providers"))
txt_15 <- txt_series("ABS.csv", series = 15, delimiter = "COMMA")
id<-txt_15$moniker$id
print(txt_id_to_properties(id))
#> $file
#> [1] "ABS.csv"
#> 
#> $delimiter
#> [1] "COMMA"
#> 
#> $textQualifier
#> [1] "NONE"
#> 
#> $headers
#> [1] 1
#> 
#> $skipLines
#> [1] 0
#> 
#> $series
#> [1] 15
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
#> $format
#> $format$locale
#> [1] "en"
#> 
#> $format$datePattern
#> [1] "yyyy-MM-dd"
#> 
#> $format$numberPattern
#> [1] ""
#> 
#> $format$ignoreNumberGrouping
#> [1] TRUE
#> 
#> 
# }
```
