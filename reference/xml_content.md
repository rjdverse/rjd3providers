# Provides the content of an xml file designed for time series.

Provides the content of an xml file designed for time series.

## Usage

``` r
xml_content(file, charset = NULL)
```

## Arguments

- file:

  The considered file.

- charset:

  The character set used in the file (NULL to use the default).

## Value

Provides all the names of the time series contained in the file, grouped
by collection.

## Examples

``` r
# \donttest{
set_xml_paths(system.file("extdata", package = "rjd3providers"))
#> Error in .jcall("jdplus/text/base/r/XmlFiles", "V", "setPaths", .jarray(paths)): RcallMethod: cannot determine object class
xml_content("Prod.xml")
#> Error in .jcall("jdplus/text/base/r/XmlFiles", "Ljdplus/toolkit/base/tsp/DataSource;",     "source", as.character(file), as.character(charset)): java.lang.NoClassDefFoundError: Could not initialize class jdplus.text.base.r.XmlFiles
print(xml_content)
#> function (file, charset = NULL) 
#> {
#>     jsource <- .xml_source(file, charset)
#>     sheets <- .jcall("jdplus/text/base/r/XmlFiles", "[S", "sheets", 
#>         jsource)
#>     rslt <- list()
#>     n <- length(sheets)
#>     for (i in 1:n) {
#>         series <- .jcall("jdplus/text/base/r/XmlFiles", "[S", 
#>             "series", jsource, as.integer(i))
#>         rslt[[sheets[i]]] <- series
#>     }
#>     return(rslt)
#> }
#> <bytecode: 0x55ebece0a298>
#> <environment: namespace:rjd3providers>
# }
```
