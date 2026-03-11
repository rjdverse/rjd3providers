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
#> Error in .jcall("jdplus/text/base/r/XmlFiles", "V", "setPaths", .jarray(paths)): java.lang.NoClassDefFoundError: Could not initialize class jdplus.text.base.r.XmlFiles
xml_1_5 <- xml_series("Prod.xml", 1, 5, charset = "iso-8859-1")
#> Error in .jcall("jdplus/text/base/r/XmlFiles", "Ljdplus/toolkit/base/tsp/DataSource;",     "source", as.character(file), as.character(charset)): RcallMethod: cannot determine object class
xml_id_to_properties(xml_1_5$moniker$id)
#> Error in .jcall("jdplus/text/base/r/XmlFiles", "Ljdplus/toolkit/base/tsp/DataSet;",     "decode", id): java.lang.NoClassDefFoundError: Could not initialize class jdplus.text.base.r.XmlFiles
xml_1 <- xml_data("Prod.xml", 1, charset = "iso-8859-1")
#> Error in .jcall("jdplus/text/base/r/XmlFiles", "Ljdplus/toolkit/base/tsp/DataSource;",     "source", as.character(file), as.character(charset)): RcallMethod: cannot determine object class
xml_id_to_properties(xml_1$moniker$id)
#> Error in .jcall("jdplus/text/base/r/XmlFiles", "Ljdplus/toolkit/base/tsp/DataSet;",     "decode", id): java.lang.NoClassDefFoundError: Could not initialize class jdplus.text.base.r.XmlFiles
# }
```
