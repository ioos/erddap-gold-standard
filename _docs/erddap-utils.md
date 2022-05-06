---
title: "ERDDAP Utilities"
keywords: homepage
tags: [utilities]
toc: true
summary: Some useful utilities
---

# ERDDAP Utilities

There is an `erddap_utils.sh` shell script that can be sourced to give some shortcut commands for common Docker-based ERDDAP tasks.

## Setup

Export the ERDDAP URL that you are working with, or edit this value in the script:

`export ERDDAP_URL=http://127.0.0.1:8080/erddap`

Source the `erddap_utils.sh` script:

`source erddap_utils.sh`

You should now have access to a number of ERDDAP utility functions, all starting with 'erddap_...'. To see them all, type `erddap_` and hit tab key twice to show all possible shell autocompletions:

```
$ erddap_<tab><tab>
erddap_check_compliance       erddap_copy_gendata           erddap_gendata_cat            erddap_index_html             erddap_refresh_dataset
erddap_chown_content          erddap_dataset_ids            erddap_gendata_mv             erddap_log_data               erddap_restart
erddap_chown_datasets         erddap_dir                    erddap_generate_datasets_xml  erddap_log_docker             erddap_vars
...
```

If you would like these functions available on login, add the line `source /path/to/erddap_cmds.sh` to your `~/.bashrc` file.

## Show exported variables

```
 erddap_vars
ERDDAP_DIR: /home/jcullis/docker/jc-erddap-gold-standard/erddap-gold-standard
ERDDAP_DATASETS_XML: /home/jcullis/docker/jc-erddap-gold-standard/erddap-gold-standard/erddap/content/datasets.xml
ERDDAP_DATA_DIR: /home/jcullis/docker/jc-erddap-gold-standard/erddap-gold-standard/datasets
ERDDAP_GENDATA_DIR: /home/jcullis/docker/jc-erddap-gold-standard/erddap-gold-standard/generate_datasets
ERDDAP_URL: http://127.0.0.1:8080/erddap
```

## Change into ERDDAP directory

```
erddap_dir
```

## Docker ERDDAP restart

```
erddap_restart
```

## Listing all dataset IDs

To show all dataset IDs available from the ERDDAP defined by $ERDDAP_URL, run:

```
$ erddap_dataset_ids
datasetID
allDatasets
org_cormp_cap2
usf_comps_c10_inwater
morro-bay-bs1-met
```

## ERDDAP Logs

To show the Docker-based logs:

```
erddap_log_docker
```

To show the `/erddapData/logs/log.txt` output, which is useful when adding new datasets:

```
erddap_log_data
```

## Refreshing datasets

ERDDAP caches information about datasets so changes may not show up. In that case, you can fully refresh a dataset using a `hardFlag` with:

```
erddap_refresh_dataset <dataset id>
```