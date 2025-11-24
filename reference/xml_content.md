# Provides the content of an xml file designed for time series.

Provides the content of an xml file designed for time series.

## Usage

``` r
xml_content(file, charset = NULL)
```

## Arguments

- file:

  The considered file.

- charset:

  The character set used in the file (NULL to use the default).

## Value

Provides all the names of the time series contained in the file, grouped
by collection.

## Examples

``` r
set_xml_paths(system.file("extdata", package = "rjd3providers"))
xml_content("Prod.xml")
#> $`industrial production`
#>   [1] "Industries manufacturières"                                                                            
#>   [2] "Industries alimentaires et fabrication de boissons"                                                    
#>   [3] "Industrie du tabac"                                                                                    
#>   [4] "Industrie textile"                                                                                     
#>   [5] "Fabrication d'articles d'habillement, confection d'ouvrages divers en tissu, fabrication de chaussures"
#>   [6] "Industrie du bois et industries connexes"                                                              
#>   [7] "Industrie du papier et du carton"                                                                      
#>   [8] "Industrie du cuir"                                                                                     
#>   [9] "Industrie chimique et industrie du caoutchouc"                                                         
#>  [10] "Industrie chimique"                                                                                    
#>  [11] "Industrie du caoutchouc"                                                                               
#>  [12] "Industrie des dérivés du pétrole et du charbon"                                                        
#>  [13] "Industrie des produits minéraux non métalliques"                                                       
#>  [14] "Industrie métallurgique de base"                                                                       
#>  [15] "Sidérurgie"                                                                                            
#>  [16] "Industrie des métaux non ferreux"                                                                      
#>  [17] "Industrie des fabrications métalliques"                                                                
#>  [18] "Fabrication d'ouvrages en métaux à l'exclusion des machines et du matériel de transport"               
#>  [19] "Construction de machines, à l'exclusion des machines électriques"                                      
#>  [20] "Construction électrique"                                                                               
#>  [21] "Construction de matériel de transport"                                                                 
#>  [22] "Appareils de mesure de laboratoire, etc..."                                                            
#>  [23] "Production d'électricité"                                                                              
#>  [24] "Distribution d'eau"                                                                                    
#>  [25] "Industries alimentaires et fabrication de boissons"                                                    
#>  [26] "Industries alimentaires"                                                                               
#>  [27] "Confitures et produits connexes"                                                                       
#>  [28] "Meuneries"                                                                                             
#>  [29] "Sucre"                                                                                                 
#>  [30] "Huiles végétales et animales"                                                                          
#>  [31] "Margarine"                                                                                             
#>  [32] "Fabrication de boissons"                                                                               
#>  [33] "Brasseries"                                                                                            
#>  [34] "Distilleries d'alcool"                                                                                 
#>  [35] "Industrie du tabac"                                                                                    
#>  [36] "Industrie textile: filature et tissage"                                                                
#>  [37] "Filature"                                                                                              
#>  [38] "Coton fin"                                                                                             
#>  [39] "Cocons"                                                                                                
#>  [40] "Laine cardée"                                                                                          
#>  [41] "Laine peignée"                                                                                         
#>  [42] "Lin et chanvre"                                                                                        
#>  [43] "Jute"                                                                                                  
#>  [44] "Industrie textile: filature et tissage"                                                                
#>  [45] "Tissage"                                                                                               
#>  [46] "Tissus de coton"                                                                                       
#>  [47] "Tissus de lin"                                                                                         
#>  [48] "Tissus de laine"                                                                                       
#>  [49] "Tissus de fibres chimiques"                                                                            
#>  [50] "Tissus de jute"                                                                                        
#>  [51] "Bonneterie"                                                                                            
#>  [52] "Filatures et corderies de fibres dures"                                                                
#>  [53] "Fabrication d'articles non dénommés ailleurs"                                                          
#>  [54] "Fabrication d'articles d'habillement, confection d'ouvrages divers en tissu, fabrication de chaussures"
#>  [55] "Articles d'habillement"                                                                                
#>  [56] "Autres ouvrages en tissu"                                                                              
#>  [57] "Chaussures et pantoufles"                                                                              
#>  [58] "Industrie du cuir"                                                                                     
#>  [59] "Cuirs lourds"                                                                                          
#>  [60] "Cuirs légers"                                                                                          
#>  [61] "Industrie du bois et industries connexes"                                                              
#>  [62] "Industrie du papier et du carton"                                                                      
#>  [63] "Production"                                                                                            
#>  [64] "Transformation"                                                                                        
#>  [65] "Industrie chimique et industrie du caoutchouc"                                                         
#>  [66] "Industrie chimique"                                                                                    
#>  [67] "Chimie de base"                                                                                        
#>  [68] "Transformation des matières plastiques"                                                                
#>  [69] "Savon"                                                                                                 
#>  [70] "Azote"                                                                                                 
#>  [71] "Industrie du caoutchouc"                                                                               
#>  [72] "Industrie des dérivés du pétrole et du charbon"                                                        
#>  [73] "Raffineries de pétrole"                                                                                
#>  [74] "Agglomérés de houille"                                                                                 
#>  [75] "Industrie des produits minéraux non métalliques"                                                       
#>  [76] "Terre cuite"                                                                                           
#>  [77] "Verre"                                                                                                 
#>  [78] "Verre plat"                                                                                            
#>  [79] "Verre creux"                                                                                           
#>  [80] "Ciment"                                                                                                
#>  [81] "Produits céramiques"                                                                                   
#>  [82] "Chaux, dolomie, plâtre, aggloméré plâtre, etc..."                                                      
#>  [83] "Industrie métallurgique de base"                                                                       
#>  [84] "Sidérurgie"                                                                                            
#>  [85] "Fonte"                                                                                                 
#>  [86] "Acier brut"                                                                                            
#>  [87] "Produits finis"                                                                                        
#>  [88] "Aciéries de moulage, fonderies, tréfileries, étirage et laminage"                                      
#>  [89] "Aciéries de moulages"                                                                                  
#>  [90] "Fonderies de fer"                                                                                      
#>  [91] "Tréfileries, étirage, laminage"                                                                        
#>  [92] "Industrie métallurgique de base"                                                                       
#>  [93] "Industrie des métaux non ferreux"                                                                      
#>  [94] "Produits bruts"                                                                                        
#>  [95] "Cuivre"                                                                                                
#>  [96] "Zinc"                                                                                                  
#>  [97] "Plomb"                                                                                                 
#>  [98] "Etain"                                                                                                 
#>  [99] "Demi-produits"                                                                                         
#> [100] "Cokeries dépendant de l'industrie métallurgique"                                                       
#> [101] "Industrie des fabrications métalliques"                                                                
#> [102] "Fabrication d'ouvrages en métaux à l'exclusion des machines et du matériel de transport"               
#> [103] "Forge, estampage, gros emboutissage"                                                                   
#> [104] "Travail de la tôle, etc..."                                                                            
#> [105] "Accessoires métalliques du bâtiment"                                                                   
#> [106] "Ponts, charpentes, etc..."                                                                             
#> [107] "Armes et munitions"                                                                                    
#> [108] "Industrie des fabrications métalliques"                                                                
#> [109] "Construction de machines, à l'exclusion des machines électriques"                                      
#> [110] "Machines motrices, etc..."                                                                             
#> [111] "Machines-outils, etc..."                                                                               
#> [112] "Constructions mécaniques"                                                                              
#> [113] "Appareils de levage, pesage, etc..."                                                                   
#> [114] "Appareils pour diverses industries"                                                                    
#> [115] "Machines textiles et accessoires"                                                                      
#> [116] "Industrie des fabrications métalliques"                                                                
#> [117] "Construction électrique"                                                                               
#> [118] "Machines rotatives et statiques"                                                                       
#> [119] "Appareils industriels et électro-domestiques"                                                          
#> [120] "Autres produits"                                                                                       
#> [121] "Industrie des fabrications métalliques"                                                                
#> [122] "Construction de matériel de transport"                                                                 
#> [123] "Construction navale"                                                                                   
#> [124] "Automobiles, cycles, etc..."                                                                           
#> [125] "Matériel de chemin de fer et tramways"                                                                 
#> [126] "Industrie aéronautique"                                                                                
#> [127] "Appareils de mesure de laboratoire, etc..."                                                            
#> 
print(xml_content)
#> function (file, charset = NULL) 
#> {
#>     jsource <- .xml_source(file, charset)
#>     sheets <- .jcall("jdplus/text/base/r/XmlFiles", "[S", "sheets", 
#>         jsource)
#>     rslt <- list()
#>     n <- length(sheets)
#>     for (i in 1:n) {
#>         series <- .jcall("jdplus/text/base/r/XmlFiles", "[S", 
#>             "series", jsource, as.integer(i))
#>         rslt[[sheets[i]]] <- series
#>     }
#>     return(rslt)
#> }
#> <bytecode: 0x5627e6af93f8>
#> <environment: namespace:rjd3providers>
```
