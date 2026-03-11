# Generates the id corresponding to a list of an xml properties.

Generates the id corresponding to a list of an xml properties.

## Usage

``` r
xml_properties_to_id(props)
```

## Arguments

- props:

  The properties defining the identifier.

## Value

The identifier corresponding to the properties.

## Examples

``` r
# \donttest{
set_xml_paths(system.file("extdata", package = "rjd3providers"))
xml_1_5 <- xml_series("Prod.xml", 1, 5, charset = "iso-8859-1")
q <- xml_id_to_properties(xml_1_5$moniker$id)
q$series <- 50
xml_properties_to_id(q)
#> [1] "demetra://tsprovider/Xml/20111201/SERIES?charset=ISO-8859-1&file=Prod.xml#collectionIndex=0&seriesIndex=49"
# }
```
