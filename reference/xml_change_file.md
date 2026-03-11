# Change the file of an xml moniker.

Change the file of an xml moniker.

## Usage

``` r
xml_change_file(id, nfile, ofile = NULL)
```

## Arguments

- id:

  Identifier of a series or of a collection of series.

- nfile:

  New file name.

- ofile:

  Old file name. NULL or "" to change any file to the new file.

## Value

The new identifier.

## Examples

``` r
# \donttest{
set_xml_paths(system.file("extdata", package = "rjd3providers"))
#> Error in .jcall("jdplus/text/base/r/XmlFiles", "V", "setPaths", .jarray(paths)): java.lang.UnsupportedClassVersionError: jdplus/toolkit/base/r/util/Providers has been compiled by a more recent version of the Java Runtime (class file version 65.0), this version of the Java Runtime only recognizes class file versions up to 61.0
xml_1_5 <- xml_series("Prod.xml", 1, 5, charset = "iso-8859-1")
#> Error in .jcall("jdplus/text/base/r/XmlFiles", "Ljdplus/toolkit/base/tsp/DataSource;",     "source", as.character(file), as.character(charset)): RcallMethod: cannot determine object class
id<-xml_1_5$moniker$id
#> Error: object 'xml_1_5' not found
xml_change_file(id, "test.xml")
#> Error in .jcall("jdplus/text/base/r/XmlFiles", "S", "changeFile", id,     nfile, ofile): java.lang.NoClassDefFoundError: Could not initialize class jdplus.text.base.r.XmlFiles
# }
```
