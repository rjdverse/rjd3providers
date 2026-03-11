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
if (FALSE) { # rjd3toolkit::get_java_version() >= rjd3toolkit::minimal_java_version
# \donttest{
set_xml_paths(system.file("extdata", package = "rjd3providers"))
xml_1_5 <- xml_series("Prod.xml", 1, 5, charset = "iso-8859-1")
id<-xml_1_5$moniker$id
xml_change_file(id, "test.xml")
# }
}
```
