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
if (FALSE) { # rjd3toolkit::get_java_version() >= rjd3toolkit::minimal_java_version
# \donttest{
set_xml_paths(system.file("extdata", package = "rjd3providers"))
xml_content("Prod.xml")
print(xml_content)
# }
}
```
