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
A wide variety of data can be accepted by ERDDAP. To see a comprehensive list, check the ERDDAP source documentation on [datasetTypes](https://coastwatch.pfeg.noaa.gov/erddap/download/setupDatasetsXml.html#datasetTypes). 
In this page we walk through the overall process for adding a dataset to a Docker deployed ERDDAP.

For specific examples on how to ingest a few common data types into ERDDAP, see the following pages:
* [NetCDF](/erddap-gold-standard/nc-use-case.html)
* [CSV](/erddap-gold-standard/csv-use-case.html)
* EML metadata file - TBD

### Working on the `datasets.xml` file

From the [canonical ERDDAP docs](https://coastwatch.pfeg.noaa.gov/erddap/download/setupDatasetsXml.html): 
> After you have followed the ERDDAP installation instructions, you must edit the datasets.xml file in tomcat/content/erddap/ to describe the datasets that your ERDDAP installation will serve.

`datasets.xml` is the master configuration file for all of the datasets you will be serving through ERDDAP. As such, 
this file will become large and difficult to manage. It is recommended that ERDDAP administrators store each dataset's xml 
snippet separately, then use a tool to combine all of the xml snippets into a master `datasets.xml`. See [adding xml snippet to datasets.xml](#adding-xml-snippet-to-datasetsxml) for options.

###  Run `GenerateDatasetsXML.sh`
Remember that everything is relative to the `erddap-gold-standard/` directory. So, if your data files are in `erddap-gold-standard/datasets/`
your **Starting Directory** should be `/datasets`.

- To run [GenerateDatasetsXml.sh](https://github.com/ioos/erddap-gold-standard/blob/master/GenerateDatasetsXml.sh) using Docker:

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
Now that you have your xml snippet ready to go, we need to add that xml snippet to datasets.xml. There are various ways you 
can go about doing this, including: copy and paste the xml (prone to errors in xml syntax), concatenating files together, or 
using a programming language to build the final file. Below are two examples

### Use the shell command [`cat`](https://www.gnu.org/software/coreutils/manual/html_node/cat-invocation.html) to concatenate all of the xml snippets together:
```shell
$ ls
01-head.xml  dataset1.xml  dataset2.xml  tail.xml
$ cat 01-head.xml dataset1.xml dataset2.xml tail.xml > datasets.xml
$ cp datasets.xml erddap/content/datasets.xml
```
### Use Python's [`xml.etree.ElementTree`](https://docs.python.org/3/library/xml.etree.elementtree.html) package to insert elements into a template:
```python
import xml.etree.ElementTree as ET

main_xml = '/erddap/content/datasets.xml'
xml_snip = '/logs/GenerateDatasetsXml.out'

# read master datasets.xml
main_tree = ET.parse(main_xml)
main_root = main_tree.getroot()

# read individual xml snippet for one dataset
snip_tree = ET.parse(xml_snip)
snip_root = snip_tree.getroot()

# insert snippet into master datasets.xml
main_root.append(snip_root)

# write a new master datasets.xml
main_tree.write('datasets.xml', encoding="utf-8")
```
Then copy the new datasets.xml to the old one:
```shell
$ cp datasets.xml erddap/content/datasets.xml
```

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
* Note that this isn't a great option for a public server.

## FAQ

* If a dataset fails to load, you can see logs under `/erddap/data/logs`.
* If a dataset fails to load, visit <http://localhost:8080/erddap/status.html> (which flushes log information to the log file), then look for an error message related to the dataset in `/erddap/data/logs/log.txt`.