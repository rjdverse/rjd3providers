# Set an option for providers

Set an option for providers

## Usage

``` r
get_providers_option(name)
```

## Arguments

- name:

  Name of the option

## Value

The requested option or NULL if it doesn't exist

## Examples

``` r
providers_option("test", "DUMMY")
get_providers_option("test")
#> [1] "DUMMY"
```
