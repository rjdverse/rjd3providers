# Retrieves all the time series in a specified collection from an xml file.

Retrieves all the time series in a specified collection from an xml
file.

## Usage

``` r
xml_data(file, collection = 1, charset = NULL, fullNames = FALSE)
```

## Arguments

- file:

  The xml file.

- collection:

  The name or the 1-based position of the collection containing the
  requested data.

- charset:

  The character set used in the file

- fullNames:

  Specifies if full names (containing the name of the sheet and the name
  of the series) are used or not.

## Value

A ts collection with all the series.

## Examples

``` r
set_xml_paths(system.file("extdata", package = "rjd3providers"))
xml_1 <- xml_data("Prod.xml", 1, charset = "iso-8859-1")
xml_all <- xml_data("Prod.xml", "industrial production", charset = "iso-8859-1")
```
