# Change the file of a text moniker

Change the file of a text moniker

## Usage

``` r
txt_change_file(id, nfile, ofile = NULL)
```

## Arguments

- id:

  Identifier of a series or of a collection of series.

- nfile:

  New file name.

- ofile:

  Old file name. NULL or "" to change any file to the new file.

## Value

The new identifier

## Examples

``` r
set_txt_paths(system.file("extdata", package = "rjd3providers"))
txt_15 <- txt_series("ABS.csv", series = 15, delimiter = "COMMA")
id<-txt_15$moniker$id
txt_change_file(id, "test.csv")
#> [1] "demetra://tsprovider/Txt/20111201/SERIES?delimiter=COMMA&file=test.csv&ignoreNumberGrouping=true#seriesIndex=14"
```
