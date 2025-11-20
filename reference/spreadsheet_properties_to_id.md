# Generates the id corresponding to a list of spreadsheet properties.

Generates the id corresponding to a list of spreadsheet properties.

## Usage

``` r
spreadsheet_properties_to_id(props)
```

## Arguments

- props:

  The properties defining the identifier.

## Value

The identifier corresponding to the properties.

## Examples

``` r
set_spreadsheet_paths(system.file("extdata", package = "rjd3providers"))
xls_s1_3 <- spreadsheet_series("Insee.xlsx", 1, 3)
id<-xls_s1_3$moniker$id
source<-spreadsheet_name()
props<-spreadsheet_id_to_properties(xls_s1_3$moniker$id)
props$gathering$period<-4
props$gathering$aggregation<-"Max"
M<-rjd3toolkit::to_ts(spreadsheet_name(), spreadsheet_properties_to_id(props))
props$gathering$aggregation<-"Min"
m<-rjd3toolkit::to_ts(spreadsheet_name(), spreadsheet_properties_to_id(props))
ts.plot(ts.union(M$data,m$data), col=c("red", "blue"))
```
