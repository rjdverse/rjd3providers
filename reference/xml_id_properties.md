# Gets the list of the properties corresponding to the identifier of a moniker

Gets the list of the properties corresponding to the identifier of a
moniker

## Usage

``` r
xml_id_properties(id)
```

## Arguments

- id:

## Examples

``` r
set_xml_paths(system.file("examples", package = "rjd3providers"))
xml_1_5 <- xml_series("Prod.xml", 1, 5, charset = "iso-8859-1")
xml_id_properties(xml_1_5$moniker$id)
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
```
