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
#> Error in .jcall("jdplus/text/base/r/XmlFiles", "V", "setPaths", .jarray(paths)): java.lang.UnsupportedClassVersionError: jdplus/toolkit/base/api/timeseries/TsProvider has been compiled by a more recent version of the Java Runtime (class file version 65.0), this version of the Java Runtime only recognizes class file versions up to 61.0
xml_1_5 <- xml_series("Prod.xml", 1, 5, charset = "iso-8859-1")
#> Error in .jcall("jdplus/text/base/r/XmlFiles", "Ljdplus/toolkit/base/tsp/DataSource;",     "source", as.character(file), as.character(charset)): RcallMethod: cannot determine object class
q <- xml_id_to_properties(xml_1_5$moniker$id)
#> Error in .jcall("jdplus/text/base/r/XmlFiles", "Ljdplus/toolkit/base/tsp/DataSet;",     "decode", id): java.lang.NoClassDefFoundError: Could not initialize class jdplus.text.base.r.XmlFiles
q$series <- 50
#> Error in q$series <- 50: object of type 'closure' is not subsettable
xml_properties_to_id(q)
#> Error in id$charset: object of type 'closure' is not subsettable
# }
```
