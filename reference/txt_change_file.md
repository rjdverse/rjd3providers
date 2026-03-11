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
# \donttest{
set_txt_paths(system.file("extdata", package = "rjd3providers"))
#> Error in .jcall("jdplus/text/base/r/TxtFiles", "V", "setPaths", .jarray(paths)): java.lang.UnsupportedClassVersionError: jdplus/toolkit/base/r/util/Providers has been compiled by a more recent version of the Java Runtime (class file version 65.0), this version of the Java Runtime only recognizes class file versions up to 61.0
txt_15 <- txt_series("ABS.csv", series = 15, delimiter = "COMMA")
#> Error in .jcall(obj = "jdplus/toolkit/base/r/util/Providers", returnSig = "Ljdplus/toolkit/base/api/timeseries/util/ObsGathering;",     method = "obsGathering", as.integer(period), as.character(aggregationType),     as.logical(allowPartialAggregation), !as.logical(cleanMissing)): RcallMethod: cannot determine object class
id<-txt_15$moniker$id
#> Error: object 'txt_15' not found
txt_change_file(id, "test.csv")
#> Error in .jcall("jdplus/text/base/r/TxtFiles", "S", "changeFile", id,     nfile, ofile): java.lang.UnsupportedClassVersionError: jdplus/toolkit/base/r/util/Providers has been compiled by a more recent version of the Java Runtime (class file version 65.0), this version of the Java Runtime only recognizes class file versions up to 61.0
# }
```
