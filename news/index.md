# Changelog

## rjd3providers 3.7.0.9000

All notable changes to this project will be documented in this file.

The format is based on [Keep a
Changelog](https://keepachangelog.com/en/1.1.0/), and this project
adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

### [Unreleased](https://github.com/rjdverse/rjd3providers/compare/v3.6.0...HEAD)

#### Changed

- New JARS

### [3.6.0](https://github.com/rjdverse/rjd3providers/compare/v3.5.1...v3.6.0) - 2025-11-24

#### Added

- Missing documentation
  [\#44](https://github.com/rjdverse/rjd3providers/issues/44)
- New way to read a spreadsheet with name and index of a sheet or of a
  series [\#25](https://github.com/rjdverse/rjd3providers/issues/25)

#### Changed

- Rename `spreadsheet_properties()` into
  [`spreadsheet_id_to_properties()`](https://rjdverse.github.io/rjd3providers/reference/spreadsheet_id_to_properties.md)
  [\#38](https://github.com/rjdverse/rjd3providers/issues/38)
- Rename `spreadsheet_id()` into
  [`spreadsheet_properties_to_id()`](https://rjdverse.github.io/rjd3providers/reference/spreadsheet_properties_to_id.md)
  [\#38](https://github.com/rjdverse/rjd3providers/issues/38)
- Rename `txt_id()` into
  [`txt_properties_to_id()`](https://rjdverse.github.io/rjd3providers/reference/txt_properties_to_id.md)
  [\#38](https://github.com/rjdverse/rjd3providers/issues/38)
- Rename `txt_properties()` into
  [`txt_id_to_properties()`](https://rjdverse.github.io/rjd3providers/reference/txt_id_to_properties.md)
  [\#38](https://github.com/rjdverse/rjd3providers/issues/38)
- Rename `xml_id()` into
  [`xml_properties_to_id()`](https://rjdverse.github.io/rjd3providers/reference/xml_properties_to_id.md)
  [\#38](https://github.com/rjdverse/rjd3providers/issues/38)
- Rename `xml_properties()` into
  [`xml_id_to_properties()`](https://rjdverse.github.io/rjd3providers/reference/xml_id_to_properties.md)
  [\#38](https://github.com/rjdverse/rjd3providers/issues/38)
- The arguments `period`, `aggregation` and `partialAggregation` are
  renamed with `gathering.` at the beginning (so `gathering.period`,
  `gathering.aggregation` and `gathering.partialAggregation`)

#### Removed

- The argument `includeMissing` is removed in favour of `cleanMissing`
  (which is technically the contrary of `includeMissing`)

#### Fixed

- Conversion from id to properties and vice versa
  [\#33](https://github.com/rjdverse/rjd3providers/issues/33)

### [3.5.1](https://github.com/rjdverse/rjd3providers/compare/v3.5.0...v3.5.1) - 2025-06-18

### [3.5.0](https://github.com/rjdverse/rjd3providers/compare/v3.2.3...v3.5.0) - 2025-04-09

#### Removed

- functions to change path of a WS

### [3.2.3](https://github.com/rjdverse/rjd3providers/compare/v3.2.2...v3.2.3) - 2024-07-12

#### Added

- new functions to update path for txt `txt_update_path`
- new functions to update path for spreadsheet `spreadsheet_update_path`

#### Changed

- New JARS
  [v3.7.1](https://github.com/jdemetra/jdplus-main/releases/tag/v3.7.1)

### [3.2.2](https://github.com/rjdverse/rjd3providers/compare/v3.2.1...v3.2.2) - 2024-03-15

#### Changed

- Merge pull request
  [\#17](https://github.com/rjdverse/rjd3providers/issues/17) from
  rjdemetra/develop
- v3.2.2

### [3.2.1](https://github.com/rjdverse/rjd3providers/compare/v3.2.0...v3.2.1) - 2023-12-12

#### Added

- New JARS

### [3.2.0](https://github.com/rjdverse/rjd3providers/compare/v3.1.0...v3.2.0) - 2023-11-24

#### Changed

- Merge pull request
  [\#11](https://github.com/rjdverse/rjd3providers/issues/11) from
  rjdemetra/develop
- v3.2.0

### [3.1.0](https://github.com/rjdverse/rjd3providers/releases/tag/v3.1.0) - 2023-10-11

#### Changed

- Merge pull request
  [\#5](https://github.com/rjdverse/rjd3providers/issues/5) from
  rjdemetra/develop
- v3.1.0
