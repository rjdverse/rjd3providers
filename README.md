
<!-- README.md is generated from README.Rmd. Please edit that file -->

# {rjd3providers} <a href="https://rjdverse.github.io/rjd3providers/"><img src="man/figures/logo.png" align="right" height="150" style="float:right; height:150px;"/></a>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/rjd3providers)](https://CRAN.R-project.org/package=rjd3providers)
[![Mentioned in Awesome Official
Statistics](https://awesome.re/mentioned-badge.svg)](http://www.awesomeofficialstatistics.org)

[![R-CMD-check](https://github.com/rjdverse/rjd3providers/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/rjdverse/rjd3providers/actions/workflows/R-CMD-check.yaml)
[![lint](https://github.com/rjdverse/rjd3providers/actions/workflows/lint.yaml/badge.svg)](https://github.com/rjdverse/rjd3providers/actions/workflows/lint.yaml)

[![GH Pages
built](https://github.com/rjdverse/rjd3providers/actions/workflows/pkgdown.yaml/badge.svg)](https://github.com/rjdverse/rjd3providers/actions/workflows/pkgdown.yaml)
<!-- badges: end -->

## Overview

**{rjd3providers}** provides tools to explore the default time series
providers (.xslx, .csv, .txt and .xml files) for JDemetra+ v3.x
Graphical User Interface. It allows to manipulate raw series files. For
example, using this R package, you will be able to:

- change the **path** of the raw data
- change the file **type**
- manipulate **monikers**
- change file **read properties**

## Installation

**{rjd3providers}** relies on the
[**{rJava}**](https://cran.r-project.org/web/packages/rJava/index.html)
package.

Running rjd3 packages requires **Java 17 or higher**. How to set up such
a configuration in R is explained
[here](https://jdemetra-new-documentation.netlify.app/#Rconfig)

### Latest release

To get the current stable version (from the latest release):

- From GitHub:

``` r
# install.packages("remotes")
remotes::install_github("rjdverse/rjd3providers@*release", build_vignettes = TRUE)
```

- From [r-universe](https://rjdverse.r-universe.dev/rjd3providers):

``` r
install.packages("rjd3providers", repos = c("https://rjdverse.r-universe.dev", "https://cloud.r-project.org"))
```

### Development version

You can install the development version of **{rjd3providers}** from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("rjdverse/rjd3providers")
```

## Usage

### Generate all the TS information

``` r
library("rjd3providers")

xlsx_file <- paste0(system.file("examples", package = "rjd3providers"), "/Insee.xlsx")
spreadsheet_content(xlsx_file)
#> $`FRANCE Textile`
#> [1] "Textiles, industries de l'habillement, industrie du cuir et de la chaussure 001562874"
#> [2] "Textiles 001563047"                                                                   
#> [3] "Préparation de fibres textiles et filature 001563401"                                 
#> [4] "Tissage 001563404"                                                                    
#> [5] "Ennoblissement textile 001563407"                                                     
#> [6] "Autres textiles 001563410"                                                            
#> [7] "Industrie de l'habillement 001563050"                                                 
#> [8] "Vêtements, autres qu'en fourrure 001563413"                                           
#> [9] "Articles à mailles 001563416"                                                         
#> 
#> $`FRANCE Mat. transport`
#> [1] "Industrie automobile 001562965"                             
#> [2] "Construction de véhicules automobiles 001562980"            
#> [3] "Carrosseries et remorques 001562983"                        
#> [4] "Equipements automobiles 001562986"                          
#> [5] "Autres matériels de transport 001562967"                    
#> [6] "Navale 001562989"                                           
#> [7] "Locomotives et autre matériel ferroviaire roulant 001562992"
#> [8] "Aéronautique et spatiale 001563059"                         
#> [9] "Matériels de transport n.c.a. 001563062"                    
#> 
#> $`FRANCE Mat. élect. `
#>  [1] "Produits informatiques, électroniques et optiques 001562888"                                              
#>  [2] "Composants et cartes électroniques 001562745"                                                             
#>  [3] "Ordinateurs et d'équipements périphériques 001562748"                                                     
#>  [4] "Equipements de communication 001562751"                                                                   
#>  [5] "Produits électroniques grand public 001562814"                                                            
#>  [6] "Instruments et d'appareils de mesure, d'essai et de navigation - horlogerie 001562817"                    
#>  [7] "Equipements d'irradiation médicale, d'équipements électro médicaux et électro thérapeutiques"             
#>  [8] "Matériels optique et photographique 001562823"                                                            
#>  [9] "Equipements électriques 001562890"                                                                        
#> [10] "Moteurs, génératrices et transformateurs électriques etmatériel de distribution et de commande électrique"
#> [11] "Piles et accumulateurs électriques 001562829"                                                             
#> [12] "Fils et câbles et matériel d'installation électrique 001562892"                                           
#> [13] "Appareils d'éclairage électrique 001562895"                                                               
#> [14] "Appareils ménagers 001562898"                                                                             
#> [15] "Autres matériels électriques 001562901"                                                                   
#> [16] "Machines et équipements n.c.a. 001562953"                                                                 
#> [17] "Machines d'usage général 001562904"                                                                       
#> [18] "Autres machines d'usage général 001562907"                                                                
#> [19] "Machines agricoles et forestières 001562910"                                                              
#> [20] "Machines de formage des métaux et machines-outils 001562974"                                              
#> [21] "Autres machines d'usage spécifique 001562977"                                                             
#> 
#> $`FRANCE Alim. et tabac`
#>  [1] "Industries alimentaires 001563038"                                                                 
#>  [2] "Transformation et conservation de la viande et préparation de produits à base de viande  001563291"
#>  [3] "Transformation et conservation de fruits et légumes 001563294"                                     
#>  [4] "Fabrication d'huiles et graisses végétales et animales 001563297"                                  
#>  [5] "Fabrication de produits laitiers 001563340"                                                        
#>  [6] "Travail des grains - fabrication de produits amylacés 001563343"                                   
#>  [7] "Fabrication de produits de boulangerie-pâtisserie et de pâtes alimentaires 001563346"              
#>  [8] "Fabrication d'autres produits alimentaires001563349"                                               
#>  [9] "Fabrication d'aliments pour animaux 001563352"                                                     
#> [10] "Fabrication de boissons 001563041"                                                                 
#> [11] "Fabrication de produits à base de tabac 001563044"

ts1 <- spreadsheet_series(file = xlsx_file, sheet = 1L, series = 3)
str(ts1)
#> List of 4
#>  $ name    : chr "FRANCE Textile\nPréparation de fibres textiles et filature 001563401"
#>  $ moniker :List of 2
#>   ..$ source: chr "XCLPRVDR"
#>   ..$ id    : chr "demetra://tsprovider/XCLPRVDR/20111201/SERIES?cleanMissing=false&file=C%3A%5CUsers%5CUTZK0M%5CAppData%5CLocal%5"| __truncated__
#>   ..- attr(*, "class")= chr "JD3_TSMONIKER"
#>  $ metadata:List of 3
#>   ..$ series.name     : chr "Préparation de fibres textiles et filature 001563401"
#>   ..$ sheet.gridLayout: chr "VERTICAL"
#>   ..$ sheet.name      : chr "FRANCE Textile"
#>  $ data    : Time-Series [1:236] from 1990 to 2010: 315 296 318 280 279 ...
#>   ..- attr(*, "name")= chr ""
#>  - attr(*, "class")= chr "JD3_TS"

all_ts <- spreadsheet_data(file = xlsx_file, sheet = 2L)
```

## Package Maintenance and contributing

Any contribution is welcome and should be done through pull requests
and/or issues. pull requests should include **updated tests** and
**updated documentation**. If functionality is changed, docstrings
should be added or updated.

## Licensing

The code of this project is licensed under the [European Union Public
Licence
(EUPL)](https://interoperable-europe.ec.europa.eu:443/collection/eupl/eupl-text-eupl-12).
