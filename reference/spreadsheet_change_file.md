# Change the file of a spreadsheet moniker.

Change the file of a spreadsheet moniker.

## Usage

``` r
spreadsheet_change_file(id, nfile, ofile = NULL)
```

## Arguments

- id:

  Identifier of a series or of a collection of series.

- nfile:

  New file name.

- ofile:

  Old file name. NULL or "" to change any file to the new file.

## Value

Returns the new identifier.

## Examples

``` r
if (FALSE) { # rjd3toolkit::get_java_version() >= rjd3toolkit::minimal_java_version
# \donttest{
set_spreadsheet_paths(system.file("extdata", package = "rjd3providers"))
xls_all <- spreadsheet_data("Insee.xlsx", 1)
id<-xls_all$moniker$id
spreadsheet_change_file(id, "test.xlsx")
# }
}
```
