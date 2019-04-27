# Overview

Example datasets and configuration for ERDDAP.

Uses the [ERDDAP Docker image](https://github.com/axiom-data-science/docker-erddap).

You can view this setup live at [https://standards.sensors.ioos.us/erddap/index.html](https://standards.sensors.ioos.us/erddap/index.html), 
with documentation at [https://ioos.github.io/ioos-metadata/gold-standard-examples.html](https://ioos.github.io/ioos-metadata/gold-standard-examples.html).

# Run

```
docker run --rm \
  -p 8080:8080 \
  -v $(pwd)/erddap/conf/setenv.sh:/usr/local/tomcat/bin/setenv.sh \
  -v $(pwd)/erddap/conf/robots.txt:/usr/local/tomcat/webapps/ROOT/robots.txt \
  -v $(pwd)/erddap/content:/usr/local/tomcat/content/erddap \
  -v $(pwd)/erddap/data:/erddapData \
  -v $(pwd)/datasets:/datasets \
  -v /tmp/:/usr/local/tomcat/temp/ \
 axiom/docker-erddap:1.82
```

After startup, go to http://localhost:8080/erddap/index.html 

# Modify

These instructions are minimal, and are intended to get you up and running quickly so that you can test out ERDDAP.
For full instructions on how to set up your own ERDDAP server, see https://coastwatch.pfeg.noaa.gov/erddap/download/setup.html

## Configuration files overview

* `datasets/` -- Sample datasets
* `erddap/`
    * `erddap/conf/`
        * `erddap/conf/robots.txt` -- [Search engine crawler config](https://coastwatch.pfeg.noaa.gov/erddap/download/setup.html#robots)
        * `erddap/conf/setenv.sh` -- [Configure application resources (memory, JAVA_OPTS, etc)](https://coastwatch.pfeg.noaa.gov/erddap/download/setup.html#WindowsMemory)
    * `erddap/content/`
        * `erddap/content/setup.xml` -- General server configuration
        * `erddap/content/datasets.xml` -- [Datasets configuration](https://coastwatch.pfeg.noaa.gov/erddap/download/setupDatasetsXml.html), references data in `datasets/` above
        * `erddap/content/images/erddap2.css` -- [CSS overrides](https://coastwatch.pfeg.noaa.gov/erddap/download/setup.html#erddapContent)

## Update `setup.xml`

### Configure your institution

Update the `<baseUrl>`, `<baseHttpsUrl>`, `<flagKeyKey>`, and `<admin.*>` tags.

### Configure email

Update the `<email.*>` and `<emailEverythingTo>` tags. 

### Update for your domain

Update `<baseUrl>`, `<baseHttpsUrl>` to match your domain.

## Adding a new dataset

#### Steps

1. Add your `nc` file to `datasets/`.
1. Run `GenerateDatasetsXml.sh`. Results will output to the console and `logs/`.
    ```
    docker run --rm -it \
      -v $(pwd)/datasets:/datasets \
      -v $(pwd)/logs:/erddapData/logs \
      axiom/docker-erddap:latest \
      bash -c "cd webapps/erddap/WEB-INF/ && bash GenerateDatasetsXml.sh -verbose"
    ```
1. Copy the resulting `<dataset>` to `erddap/content/datasets.xml`
1. Restart ERDDAP

#### Example

Say you have a file called `seward-sealife-center-astra.nc` that you've added to `datasets/`.

```
~/dev/ioos/erddap-gold-standard$ docker run --rm -it \
>   -v $(pwd)/datasets:/datasets \
>   -v $(pwd)/logs:/erddapData/logs \
>   axiom/docker-erddap:latest \
>   bash -c "cd webapps/erddap/WEB-INF/ && bash GenerateDatasetsXml.sh -verbose"

*** GenerateDatasetsXml ***
Press Enter or type the word "default" (but without the quotes)
  to get the default value.
Type the word "nothing" (but without quotes) or "" (2 double quotes)
  to change from a non-nothing default back to nothing (a 0-length string).
Press ^D or ^C to exit this program at any time.
Or, you can put all the answers as parameters on the command line.
Results are shown on the screen and put in
/erddapData/logs/GenerateDatasetsXml.out
DISCLAIMER:
  The chunk of datasets.xml made by GenerateDatasetsXml isn't perfect.
  YOU MUST READ AND EDIT THE XML BEFORE USING IT IN A PUBLIC ERDDAP.
  GenerateDatasetsXml relies on a lot of rules-of-thumb which aren't always
  correct.  *YOU* ARE RESPONSIBLE FOR ENSURING THE CORRECTNESS OF THE XML
  THAT YOU ADD TO ERDDAP'S datasets.xml FILE.
For detailed information, see
http://coastwatch.pfeg.noaa.gov/erddap/download/setupDatasetsXml.html

The EDDType options are:
EDDGridAggregateExistingDimension   EDDTableFromDatabase
EDDGridFromAudioFiles               EDDTableFromEML
EDDGridFromDap                      EDDTableFromEMLBatch
EDDGridFromEDDTable                 EDDTableFromErddap
EDDGridFromErddap                   EDDTableFromFileNames
EDDGridFromMergeIRFiles             EDDTableFromInPort
EDDGridFromNcFiles                  EDDTableFromIoosSOS
EDDGridFromNcFilesUnpacked          EDDTableFromMultidimNcFiles
EDDGridFromThreddsCatalog           EDDTableFromNcFiles
EDDGridLonPM180FromErddapCatalog    EDDTableFromNcCFFiles
EDDTableFromAsciiFiles              EDDTableFromNccsvFiles
EDDTableFromAudioFiles              EDDTableFromOBIS
EDDTableFromAwsXmlFiles             EDDTableFromSOS
EDDTableFromBCODMO                  EDDTableFromThreddsFiles
EDDTableFromCassandra               EDDTableFromWFSFiles
EDDTableFromColumnarAsciiFiles      EDDsFromFiles
EDDTableFromDapSequence             ncdump

Which EDDType (default="EDDGridFromDap")
? EDDTableFromMultidimNcFiles
Starting directory (default="")
? /datasets
File name regex (e.g., ".*\.nc") (default="")
? seward-sealife-center-astra.nc
Full file name of one file (or leave empty to use first matching fileName) (default="")
? 
DimensionsCSV (or "" for default) (default="")
? 
ReloadEveryNMinutes (e.g., 10080) (default="")
? 
PreExtractRegex (default="")
? 
PostExtractRegex (default="")
? 
ExtractRegex (default="")
? 
Column name for extract (default="")
? 
Remove missing value rows (true|false) (default="")
? 
Sort files by sourceNames (default="")
? 
infoUrl (default="")
? 
institution (default="")
? 
summary (default="")
? 
title (default="")
? 
working...

*** EDDTableFromMultidimNcFiles.generateDatasetsXml
fileDir=/datasets fileNameRegex=seward-sealife-center-astra.nc
sampleFileName= useDimensionsCSV= reloadEveryNMinutes=10080
extract pre= post= regex= colName=
removeMVRows=true sortFilesBy=
infoUrl=
institution=
summary=
title=
externalAddGlobalAttributes=null
Found/using sampleFileName=/datasets/seward-sealife-center-astra.nc

*** generateDatasetsXml finished successfully.
```

The resulting `<dataset>` is in `logs/GenerateDatasetsXml.out`. 
Copy this into `datasets.xml` and reload ERDDAP.