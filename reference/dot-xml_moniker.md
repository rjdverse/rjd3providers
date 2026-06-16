# Generates a java moniker for the corresponding id.

Generates a java moniker for the corresponding id.

## Usage

``` r
.xml_moniker(id)
```

## Arguments

- id:

  Identifier of the requested information.

## Value

An internal java moniker.

## Examples

``` r

.xml_moniker("toy_id")
#> [1] "Java-Object{Xml<@>toy_id}"
```
