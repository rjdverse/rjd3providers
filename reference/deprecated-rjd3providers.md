# Deprecated functions

These functions are deprecated and are kept only for backward
compatibility. Users should use the corresponding non-deprecated
functions instead:

- `spreadsheet_to_id()` \\\to\\
  [`spreadsheet_properties_to_id()`](https://rjdverse.github.io/rjd3providers/reference/spreadsheet_properties_to_id.md)

- `spreadsheet_id_properties()` \\\to\\
  [`spreadsheet_id_to_properties()`](https://rjdverse.github.io/rjd3providers/reference/spreadsheet_id_to_properties.md)

- `txt_to_id()` \\\to\\
  [`txt_properties_to_id()`](https://rjdverse.github.io/rjd3providers/reference/txt_properties_to_id.md)

- `txt_id_properties()` \\\to\\
  [`txt_id_to_properties()`](https://rjdverse.github.io/rjd3providers/reference/txt_id_to_properties.md)

- `xml_to_id()` \\\to\\
  [`xml_properties_to_id()`](https://rjdverse.github.io/rjd3providers/reference/xml_properties_to_id.md)

- `xml_id_properties()` \\\to\\
  [`xml_id_to_properties()`](https://rjdverse.github.io/rjd3providers/reference/xml_id_to_properties.md)

## Usage

``` r
spreadsheet_to_id(props)

spreadsheet_id_properties(id)

txt_to_id(props)

txt_id_properties(id)

xml_to_id(props)

xml_id_properties(id)
```

## Arguments

- props:

  The properties defining the identifier.

- id:

  Identifier of a series or of a collection of series.

## Value

The same value as returned by the corresponding non-deprecated function.
The returned object represents an encoded identifier for a spreadsheet
series or collection.

The same output as
[`spreadsheet_id_to_properties`](https://rjdverse.github.io/rjd3providers/reference/spreadsheet_id_to_properties.md).
It is a list with the elements of the identifier: file, sheet, series,
and gathering (which contains period, aggregation, partialAggregation,
and cleanMissing flags).

The same output as
[`txt_properties_to_id()`](https://rjdverse.github.io/rjd3providers/reference/txt_properties_to_id.md):
a string representing the internal identifier.

The same output as
[`txt_id_to_properties()`](https://rjdverse.github.io/rjd3providers/reference/txt_id_to_properties.md):
a list with the elements of the id (file, series, format, gathering,
etc.).

Returns the same output as
[`xml_properties_to_id()`](https://rjdverse.github.io/rjd3providers/reference/xml_properties_to_id.md):
an internal identifier corresponding to the XML properties.

Returns the same output as
[`xml_id_to_properties()`](https://rjdverse.github.io/rjd3providers/reference/xml_id_to_properties.md):
a list of the XML identifier’s properties (file, collection\[, series\],
charset, fullNames).

## Examples

``` r
# \donttest{
# Deprecated: use spreadsheet_properties_to_id() instead
set_spreadsheet_paths(system.file("extdata", package = "rjd3providers"))
#> Error in .jcall("jdplus/spreadsheet/base/r/SpreadSheets", "V", "setPaths",     .jarray(paths)): java.lang.UnsupportedClassVersionError: jdplus/toolkit/base/api/timeseries/TsProvider has been compiled by a more recent version of the Java Runtime (class file version 65.0), this version of the Java Runtime only recognizes class file versions up to 61.0
xls_s1_3 <- spreadsheet_series("Insee.xlsx", 1, 3)
#> Error in .jcall(obj = "jdplus/toolkit/base/r/util/Providers", returnSig = "Ljdplus/toolkit/base/api/timeseries/util/ObsGathering;",     method = "obsGathering", as.integer(period), as.character(aggregationType),     as.logical(allowPartialAggregation), !as.logical(cleanMissing)): RcallMethod: cannot determine object class
id<-xls_s1_3$moniker$id
#> Error: object 'xls_s1_3' not found
source<-spreadsheet_name()
#> Error in .jfield("jdplus/spreadsheet/base/api/SpreadSheetProvider", "S",     name = "NAME"): cannot find class jdplus/spreadsheet/base/api/SpreadSheetProvider
# props<-spreadsheet_id_properties(xls_s1_3$moniker$id) # DEPRECATED
props<-spreadsheet_id_to_properties(xls_s1_3$moniker$id) # RECOMMENDED
#> Error in .jcall("jdplus/spreadsheet/base/r/SpreadSheets", "Ljdplus/toolkit/base/tsp/DataSet;",     "decode", id): java.lang.UnsupportedClassVersionError: jdplus/toolkit/base/api/timeseries/TsProvider has been compiled by a more recent version of the Java Runtime (class file version 65.0), this version of the Java Runtime only recognizes class file versions up to 61.0
props$gathering$period<-4
#> Error: object 'props' not found
props$gathering$aggregation<-"Max"
#> Error: object 'props' not found
# M<-rjd3toolkit::to_ts(spreadsheet_name(),
#                       spreadsheet_to_id(props))
M<-rjd3toolkit::to_ts(spreadsheet_name(), # DEPRECATED
                      spreadsheet_properties_to_id(props)) # RECOMMENDED
#> Error in .jfield("jdplus/spreadsheet/base/api/SpreadSheetProvider", "S",     name = "NAME"): cannot find class jdplus/spreadsheet/base/api/SpreadSheetProvider
props$gathering$aggregation<-"Min"
#> Error: object 'props' not found
# m<-rjd3toolkit::to_ts(spreadsheet_name(),
#                       spreadsheet_to_id(props)) # DEPRECATED
m<-rjd3toolkit::to_ts(spreadsheet_name(),
                      spreadsheet_properties_to_id(props)) # RECOMMENDED
#> Error in .jcall(obj = "jdplus/toolkit/base/api/timeseries/TsMoniker",     returnSig = "Ljdplus/toolkit/base/api/timeseries/TsMoniker;",     method = "of", source, id): java.lang.UnsupportedClassVersionError: jdplus/toolkit/base/api/timeseries/TsProvider has been compiled by a more recent version of the Java Runtime (class file version 65.0), this version of the Java Runtime only recognizes class file versions up to 61.0
ts.plot(ts.union(M$data,m$data), col=c("red", "blue"))
#> Error: object 'M' not found
# }

# \donttest{
# Deprecated: use spreadsheet_id_to_properties() instead
set_spreadsheet_paths(system.file("extdata", package = "rjd3providers"))
#> Error in .jcall("jdplus/spreadsheet/base/r/SpreadSheets", "V", "setPaths",     .jarray(paths)): RcallMethod: cannot determine object class
xls_s1_3 <- spreadsheet_series("Insee.xlsx", 1, 3)
#> Error in .jcall(obj = "jdplus/toolkit/base/r/util/Providers", returnSig = "Ljdplus/toolkit/base/api/timeseries/util/ObsGathering;",     method = "obsGathering", as.integer(period), as.character(aggregationType),     as.logical(allowPartialAggregation), !as.logical(cleanMissing)): java.lang.NoClassDefFoundError: Could not initialize class jdplus.spreadsheet.base.r.SpreadSheets
id<-xls_s1_3$moniker$id
#> Error: object 'xls_s1_3' not found
# print(spreadsheet_id_properties(id)) # DEPRECATED
print(spreadsheet_id_to_properties(id)) # RECOMMENDED
#> Error: object 'id' not found
# }
# \donttest{
# Deprecated: use txt_properties_to_id() instead
set_txt_paths(system.file("extdata", package = "rjd3providers"))
#> Error in .jcall("jdplus/text/base/r/TxtFiles", "V", "setPaths", .jarray(paths)): RcallMethod: cannot determine object class
txt_15 <- txt_series("ABS.csv", series = 15, delimiter = "COMMA")
#> Error in .jcall(obj = "jdplus/text/base/r/Utility", returnSig = "Ljdplus/toolkit/base/tsp/util/ObsFormat;",     method = "obsFormat", as.character(locale), as.character(dateFmt),     as.character(numberFmt), as.logical(ignoreNumberGrouping)): java.lang.UnsupportedClassVersionError: jdplus/toolkit/base/api/timeseries/TsProvider has been compiled by a more recent version of the Java Runtime (class file version 65.0), this version of the Java Runtime only recognizes class file versions up to 61.0
id<-txt_15$moniker$id
#> Error: object 'txt_15' not found
source<-txt_name()
#> Error in .jfield("jdplus/text/base/api/TxtProvider", name = "NAME"): cannot find class jdplus/text/base/api/TxtProvider
# props<-txt_id_properties(id) # DEPRECATED
props<-txt_id_to_properties(id) # RECOMMENDED
#> Error in .jcall("jdplus/text/base/r/TxtFiles", "Ljdplus/toolkit/base/tsp/DataSet;",     "decode", id): java.lang.UnsupportedClassVersionError: jdplus/toolkit/base/api/timeseries/TsProvider has been compiled by a more recent version of the Java Runtime (class file version 65.0), this version of the Java Runtime only recognizes class file versions up to 61.0
props$gathering$period<-4
#> Error: object 'props' not found
props$gathering$aggregation<-"Max"
#> Error: object 'props' not found
# M<-rjd3toolkit::to_ts(txt_name(), txt_to_id(props)) # DEPRECATED
M<-rjd3toolkit::to_ts(txt_name(), txt_properties_to_id(props)) # RECOMMENDED
#> Error in .jfield("jdplus/text/base/api/TxtProvider", name = "NAME"): cannot find class jdplus/text/base/api/TxtProvider
props$gathering$aggregation<-"Min"
#> Error: object 'props' not found
# m<-rjd3toolkit::to_ts(txt_name(), txt_to_id(props)) # DEPRECATED
m<-rjd3toolkit::to_ts(txt_name(), txt_properties_to_id(props)) # RECOMMENDED
#> Error in .jcall(obj = "jdplus/toolkit/base/api/timeseries/TsMoniker",     returnSig = "Ljdplus/toolkit/base/api/timeseries/TsMoniker;",     method = "of", source, id): java.lang.UnsupportedClassVersionError: jdplus/toolkit/base/api/timeseries/TsProvider has been compiled by a more recent version of the Java Runtime (class file version 65.0), this version of the Java Runtime only recognizes class file versions up to 61.0
ts.plot(ts.union(M$data,m$data), col=c("red", "blue"))
#> Error: object 'M' not found
# }
# \donttest{
# Deprecated: use txt_id_to_properties() instead
set_txt_paths(system.file("extdata", package = "rjd3providers"))
#> Error in .jcall("jdplus/text/base/r/TxtFiles", "V", "setPaths", .jarray(paths)): RcallMethod: cannot determine object class
txt_15 <- txt_series("ABS.csv", series = 15, delimiter = "COMMA")
#> Error in .jcall(obj = "jdplus/text/base/r/Utility", returnSig = "Ljdplus/toolkit/base/tsp/util/ObsFormat;",     method = "obsFormat", as.character(locale), as.character(dateFmt),     as.character(numberFmt), as.logical(ignoreNumberGrouping)): java.lang.NoClassDefFoundError: Could not initialize class jdplus.text.base.r.TxtFiles
id<-txt_15$moniker$id
#> Error: object 'txt_15' not found
# print(txt_id_properties(id)) # DEPRECATED
print(txt_id_to_properties(id)) # RECOMMENDED
#> Error: object 'id' not found
# }
# \donttest{
# Deprecated: use xml_properties_to_id() instead
set_xml_paths(system.file("extdata", package = "rjd3providers"))
#> Error in .jcall("jdplus/text/base/r/XmlFiles", "V", "setPaths", .jarray(paths)): RcallMethod: cannot determine object class
xml_1_5 <- xml_series("Prod.xml", 1, 5, charset = "iso-8859-1")
#> Error in .jcall("jdplus/text/base/r/XmlFiles", "Ljdplus/toolkit/base/tsp/DataSource;",     "source", as.character(file), as.character(charset)): java.lang.UnsupportedClassVersionError: jdplus/toolkit/base/api/timeseries/TsProvider has been compiled by a more recent version of the Java Runtime (class file version 65.0), this version of the Java Runtime only recognizes class file versions up to 61.0
# q <- xml_id_properties(xml_1_5$moniker$id) # DEPRECATED
q <- xml_id_to_properties(xml_1_5$moniker$id) # RECOMMENDED
#> Error: object 'xml_1_5' not found
q$series <- 50
#> Error in q$series <- 50: object of type 'closure' is not subsettable
# xml_to_id(q) # DEPRECATED
xml_properties_to_id(q) # RECOMMENDED
#> Error in id$charset: object of type 'closure' is not subsettable
# }

# \donttest{
# Deprecated: use xml_id_to_properties() instead
set_xml_paths(system.file("extdata", package = "rjd3providers"))
#> Error in .jcall("jdplus/text/base/r/XmlFiles", "V", "setPaths", .jarray(paths)): RcallMethod: cannot determine object class
xml_1_5 <- xml_series("Prod.xml", 1, 5, charset = "iso-8859-1")
#> Error in .jcall("jdplus/text/base/r/XmlFiles", "Ljdplus/toolkit/base/tsp/DataSource;",     "source", as.character(file), as.character(charset)): java.lang.NoClassDefFoundError: Could not initialize class jdplus.text.base.r.XmlFiles
# xml_id_properties(xml_1_5$moniker$id) # DEPRECATED
xml_id_to_properties(xml_1_5$moniker$id) # RECOMMENDED
#> Error: object 'xml_1_5' not found
xml_1 <- xml_data("Prod.xml", 1, charset = "iso-8859-1")
#> Error in .jcall("jdplus/text/base/r/XmlFiles", "Ljdplus/toolkit/base/tsp/DataSource;",     "source", as.character(file), as.character(charset)): RcallMethod: cannot determine object class
# xml_id_properties(xml_1$moniker$id) # DEPRECATED
xml_id_to_properties(xml_1$moniker$id) # RECOMMENDED
#> Error in .jcall("jdplus/text/base/r/XmlFiles", "Ljdplus/toolkit/base/tsp/DataSet;",     "decode", id): java.lang.NoClassDefFoundError: Could not initialize class jdplus.text.base.r.XmlFiles
# }
```
