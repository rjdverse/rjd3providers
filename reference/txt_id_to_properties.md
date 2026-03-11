# Gets the list of the properties corresponding to the identifier of a moniker

Gets the list of the properties corresponding to the identifier of a
moniker

## Usage

``` r
txt_id_to_properties(id)
```

## Arguments

- id:

  Identifier of a series or of a collection of series.

## Value

Returns a list with the elements of the id: file \[, series\], format,
gathering, ...).

## Examples

``` r
if (FALSE) { # rjd3toolkit::get_java_version() >= rjd3toolkit::minimal_java_version
# \donttest{
set_txt_paths(system.file("extdata", package = "rjd3providers"))
txt_15 <- txt_series("ABS.csv", series = 15, delimiter = "COMMA")
id<-txt_15$moniker$id
print(txt_id_to_properties(id))
# }
}
```
