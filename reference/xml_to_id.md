# Generates the id corresponding to a list of properties

Generates the id corresponding to a list of properties

## Usage

``` r
xml_to_id(props)
```

## Arguments

- props:

## Examples

``` r
set_xml_paths(system.file("examples", package = "rjd3providers"))
xml_1_5 <- xml_series("Prod.xml", 1, 5, charset = "iso-8859-1")
q <- xml_id_properties(xml_1_5$moniker$id)
q$series <- 50
xml_to_id(q)
#> [1] "demetra://tsprovider/Xml/20111201/SERIES?charset=ISO-8859-1&file=Prod.xml#collectionIndex=0&seriesIndex=49"
```
