# Title

Title

## Usage

``` r
xml_data(file, collection = 1, charset = NULL, fullNames = FALSE)
```

## Arguments

- fullNames:

## Examples

``` r
set_xml_paths(system.file("examples", package = "rjd3providers"))
xml_all <- xml_data("Prod.xml", 1, charset = "iso-8859-1")
```
