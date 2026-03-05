# Gets the list of the properties corresponding to the identifier of a moniker.

Gets the list of the properties corresponding to the identifier of a
moniker.

## Usage

``` r
xml_id_to_properties(id)
```

## Arguments

- id:

  Identifier of a series or of a collection of series.

## Value

Returns a list with the elements of the id: file, collection\[,
series\], charset, fullnames.

## Examples

``` r
# \donttest{
set_xml_paths(system.file("extdata", package = "rjd3providers"))
xml_1_5 <- xml_series("Prod.xml", 1, 5, charset = "iso-8859-1")
xml_id_to_properties(xml_1_5$moniker$id)
#> $file
#> [1] "Prod.xml"
#> 
#> $charset
#> [1] "ISO-8859-1"
#> 
#> $collection
#> [1] 1
#> 
#> $series
#> [1] 5
#> 
xml_1 <- xml_data("Prod.xml", 1, charset = "iso-8859-1")
xml_id_to_properties(xml_1$moniker$id)
#> $file
#> [1] "Prod.xml"
#> 
#> $charset
#> [1] "ISO-8859-1"
#> 
#> $collection
#> [1] 1
#> 
#> $series
#> numeric(0)
#> 
# }
```
