[![](https://img.shields.io/badge/GitHub-Pages-blue)](https://ioos.github.io/erddap-gold-standard/) [![](https://img.shields.io/badge/ERDDAP-Deployed-green)](https://standards.sensors.ioos.us/erddap/index.html)

# Overview

Example datasets and configuration for ERDDAP.

Uses the [ERDDAP Docker image](https://github.com/axiom-data-science/docker-erddap).

You can view this setup live at <https://standards.sensors.ioos.us/erddap/index.html>.

Documentation can be found at <https://ioos.github.io/erddap-gold-standard/>.

# Datasets

The gold standard datasets are
[IOOS Metadata Profile](https://ioos.github.io/ioos-metadata/ioos-metadata-profile-v1-2.html)
compliant NetCDF files stored in the `./datasets` directory.

Yaml text representations of the NetCDF metadata (based on nco-json output) are also
included for easy discoverability and access in the `./datasets-yml` directory.
See the `./datasets-yml/datasets.yml.sh` script for more details.
