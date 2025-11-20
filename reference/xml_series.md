# Title

Title

## Usage

``` r
xml_series(file, collection = 1, series = 1, charset = NULL, fullName = TRUE)
```

## Arguments

- fullName:

## Examples

``` r
set_xml_paths(system.file("examples", package = "rjd3providers"))
xml_1_5 <- xml_series("Prod.xml", 1, 5, charset = "iso-8859-1")
```
