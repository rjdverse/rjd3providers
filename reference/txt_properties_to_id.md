# Generates the id corresponding to a list of a text properties.

Generates the id corresponding to a list of a text properties.

## Usage

``` r
txt_properties_to_id(props)
```

## Arguments

- props:

  The properties defining the identifier.

## Value

The identifier corresponding to the properties.

## Examples

``` r
# \donttest{
set_txt_paths(system.file("extdata", package = "rjd3providers"))
txt_15 <- txt_series("ABS.csv", series = 15, delimiter = "COMMA")
id<-txt_15$moniker$id
source<-txt_name()
props<-txt_id_to_properties(id)
props$gathering$period<-4
props$gathering$aggregation<-"Max"
M<-rjd3toolkit::to_ts(txt_name(), txt_properties_to_id(props))
props$gathering$aggregation<-"Min"
m<-rjd3toolkit::to_ts(txt_name(), txt_properties_to_id(props))
ts.plot(ts.union(M$data,m$data), col=c("red", "blue"))

# }
```
