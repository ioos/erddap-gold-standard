---
title: "Adding datasets to ERDDAP"
keywords: datasets
tags: [datasets, overview]
toc: true
#permalink: index.html
summary: A how-to guide for adding datasets to an ERDDAP server.
---

## Requirements
* ERDDAP is deployed using the Docker container as described in the [Quick Start](/erddap-gold-standard/index.html).

## Adding a new dataset
The [Use Cases](/erddap-gold-standard/use-cases.html) page demonstrates how to ingest a few common data types into ERDDAP. Examples currently include datasets imported from NetCDF, CSV, and from an EML metadata file.

### Working on the `datasets.xml` file

From the [canonical ERDDAP docs](https://coastwatch.pfeg.noaa.gov/erddap/download/setupDatasetsXml.html): 
> After you have followed the ERDDAP installation instructions, you must edit the datasets.xml file in tomcat/content/erddap/ to describe the datasets that your ERDDAP installation will serve.

###  Run `GenerateDatasetsXML.sh`
Remember that everything is relative to the `erddap-gold-standard/` directory. So, if your data files are in `erddap-gold-standard/datasets/`
your **Starting Directory** should be `/datasets`.

- To run [GenerateDatasetsXml.sh](https://github.com/ioos/erddap-gold-standard/blob/master/GenerateDatasetsXml.sh) within your Docker environment:

```shell
$ ./GenerateDatasetsXml.sh
```

## Inspect and edit xml created by `GenerateDatasetsXml.sh`
If successful, `GenerateDatasetsXml.sh` will have created the file `/logs/GenerateDatasetsXml.out` which contains a 
template of what the `datasets.xml` snippet should be for the dataset provided.

### Things to check for:
1. Check the `license` attribute and ensure it correctly depicts your organizations licensing policy.
2. Check for [LLAT variables](https://coastwatch.pfeg.noaa.gov/erddap/download/setupDatasetsXml.html#LLAT) and that those are correctly assumed.
3. Ensure your metadata is appropriately documenting the data you are serving. Check for:
   1. `units`
   2. `long_name`
4. 

## Adding xml snippet to datasets.xml
- What is a "best practice" to cp/append the output from `GenerateDatasetsXml.sh` into `/erddap/content/datasets.xml`?

- Make sure to add the text between ...
     
     ```xml
    <?xml version="1.0" encoding="ISO-8859-1" ?>
        
    </erddapDatasets>
        <requestBlacklist />
        <dataset type="EDDTableFromMultidimNcFiles" datasetID="morro-bay-bs1-met" active="true"...>
        <dataset type="EDDTableFromMultidimNcFiles" datasetID="org_cormp_cap2" active="true"...>
        <dataset type="EDDTableFromMultidimNcFiles" datasetID="org_cormp_cap2" active="true"...>
        <dataset ... ???your new dataset goes here??? ... >
    </erddapDatasets>     
    ```
          
- Do we need to append that text every time a new dataset is generated? 

## Loading/Refreshing the dataset in ERDDAP

### Using the flag system
ERDDAP has a nice flagging system which tells ERDDAP to immediately reload a dataset. The system functions by putting a 
file with the same name as the datasetID you want to refresh, in the `/erddap/data/flag/` or `/erddap/data/hardFlag/` directories. 
To learn more about ERDDAP's flagging system, see [this documentation](https://coastwatch.pfeg.noaa.gov/erddap/download/setup.html#flag).
  * For example, to flag a dataset with the `datasetID` = `sample`, use:
    ```shell
    $ touch erddap/data/flag/sample
    ```

### Reload ERDDAP-docker Container
If you want to refresh all of the datasets in your ERDDAP, you can always reload the entire docker container:
```shell
$ docker-compose restart
```

## FAQ

* If a dataset fails to load, you can see logs under `/erddap/data/logs`.
* ERDDAP caches datasets, so if you change one, you can force refresh by using the hardFlag system. For example `touch /erddap/data/hardFlag/41024-sun2-sunset-nearshore`. 