
# ERDDAP Utilities

There is an `erddap_utils.sh` shell script that can be sourced to give some shortcut commands for common Docker-based ERDDAP tasks.

## Setup

Export the ERDDAP URL that you are working with:

`export ERDDAP_URL=cioosatlantic.ca`

Source the `erddap_utils.sh` script:

`source erddap_utils.sh`

You should now have access to a number of ERDDAP utility functions, all starting with 'erddap_...'. To see them all, type `erddap_` and hit tab key twice to show all possible shell autocompletions:

```
$ erddap_<tab><tab>
erddap_check_compliance       erddap_copy_gendata           erddap_generate_datasets_xml  erddap_refresh_dataset        
erddap_chown_content          erddap_dataset_ids            erddap_log_data               erddap_restart                
erddap_chown_datasets         erddap_dir                    erddap_log_docker  
...
```

## Listing dataset IDs

To show all dataset IDs available from the ERDDAP defined by $ERDDAP_URL, run:

```
erddap_dataset_ids
```

# ERDDAP Logs

To show the Docker-based logs:

```
erddap_log_docker
```

To show the `/erddapData/logs/log.txt` output, which is useful when adding new datasets:

```
erddap_log_data
```


