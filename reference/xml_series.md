# Retrieves a time series from an xml file

Retrieves a time series from an xml file

## Usage

``` r
xml_series(file, collection = 1, series = 1, charset = NULL, fullName = TRUE)
```

## Arguments

- file:

  The xml file.

- collection:

  The name or the 1-based position of the collection containing the
  requested data.

- series:

  The name or the 1-based position of the series in the selected
  collection.

- charset:

  The character set used in the file.

- fullName:

  Specifies if a full name (containing the name of the collection and
  the name of the series) is used or not.

## Value

Returns the specified time series

## Examples

``` r
# \donttest{
set_xml_paths(system.file("extdata", package = "rjd3providers"))
xml_1_5 <- xml_series("Prod.xml", 1, 5, charset = "iso-8859-1")
xml_cn <- xml_series("Prod.xml", "industrial production",
            "Construction navale", charset = "iso-8859-1")
# }
```
