# Provides the content of a spreadsheet designed for time series.

Provides the content of a spreadsheet designed for time series.

## Usage

``` r
spreadsheet_content(file)
```

## Arguments

- file:

  The considered workbook.

## Value

Provides all the names of the time series contained in the workbook,
organized by worksheet; the output is a list of lists of names.

## Examples

``` r
# \donttest{
set_spreadsheet_paths(system.file("extdata", package = "rjd3providers"))
print(spreadsheet_content("Insee.xlsx"))
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
#> 
# }
```
