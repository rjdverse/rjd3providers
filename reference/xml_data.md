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
# \donttest{
set_xml_paths(system.file("extdata", package = "rjd3providers"))
#> Error in .jcall("jdplus/text/base/r/XmlFiles", "V", "setPaths", .jarray(paths)): RcallMethod: cannot determine object class
xml_1 <- xml_data("Prod.xml", 1, charset = "iso-8859-1")
#> Error in .jcall("jdplus/text/base/r/XmlFiles", "Ljdplus/toolkit/base/tsp/DataSource;",     "source", as.character(file), as.character(charset)): java.lang.NoClassDefFoundError: Could not initialize class jdplus.text.base.r.XmlFiles
xml_all <- xml_data("Prod.xml", "industrial production", charset = "iso-8859-1")
#> Error in .jcall("jdplus/text/base/r/XmlFiles", "Ljdplus/toolkit/base/tsp/DataSource;",     "source", as.character(file), as.character(charset)): RcallMethod: cannot determine object class
# }
```
