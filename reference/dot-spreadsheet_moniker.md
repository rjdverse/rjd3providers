# Generates a java moniker for the corresponding id.

Generates a java moniker for the corresponding id.

## Usage

``` r
.spreadsheet_moniker(id)
```

## Arguments

- id:

  Identifier of the requested information.

## Value

An internal Java moniker.

## Examples

``` r

.spreadsheet_moniker("toy_id")
#> [1] "Java-Object{XCLPRVDR<@>toy_id}"
```
