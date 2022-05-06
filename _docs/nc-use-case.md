---
title: "Adding a NetCDF file to ERDDAP"
keywords: homepage
tags: [getting_started, netcdf]
toc: true
#permalink: index.html
summary: NC file info stripped out of README.md
---

## Requirements
* ERDDAP is deployed using the Docker container as described in the [Quick Start](/erddap-gold-standard/index.html).
* You have access to the source netCDF file.

## Adding a new dataset

### Steps

1. Add your `nc` file to `datasets/`.
2. Run `GenerateDatasetsXml.sh`. Results will output to the console and `logs/`.
   ```shell
   $ ./GenerateDatasetsXml.sh
   ```
4. Copy the resulting dataset xml snippet to `erddap/content/datasets.xml`
5. [Flag dataset for reloading/Restart ERDDAP.](/erddap-gold-standard/adding-datasets.html#loadingrefreshing-the-dataset-in-erddap)

### Example

1. Say you have a file called `seward-sealife-center-astra.nc` that you've added to `datasets/`.

2. Navigate to your `~/erddap-gold-standard` directory and run the following command: 

    ```shell
    $ ./GenerateDatasetsXml.sh
    ```
    You should be able to see something similar to this: 

    ```text
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

    ```

4. Start answering ERDDAP questions:

   ```text
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
   standardizeWhat (-1 to get the class' default) (default="")
   ? 
   treatDimensionsAs (default="")
   ? 
   cacheFromUrl (default="")
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

   Ctrl-c to interrupt/terminate the program!
   ```

+ The resulting file will be generated in `~/erddap-gold-standard/logs/GenerateDatasetsXml.out`.


---
# TODO

5. Copy the results from `GenerateDatasetsXml.out` into `~/erddap-gold-standard/erddap/content/datasets.xml`.
   ```xml
   <?xml version="1.0" encoding="ISO-8859-1" ?>
      
   </erddapDatasets>
      <requestBlacklist />
      <dataset type="EDDTableFromMultidimNcFiles" datasetID="this is the first dataset" active="true"...>
      <dataset type="EDDTableFromMultidimNcFiles" datasetID="this is the second dataset" active="true"...>
      <dataset type="EDDTableFromMultidimNcFiles" datasetID="another_data_set" active="true"...>
      <dataset ... Your dataset from `GenerateDatasetsXml.out` goes here ... >

   </erddapDatasets>   
   ```
---

6. Reload ERDDAP by typing the following command:
   ```shell
   $ docker-compose restart
   ```

### Troubleshooting

The `DasDds` tool can help you find errors in datasets.xml, it is an interactive tool that will prompt you for a dataset ID.

```shell
$ sh DasDds.sh
```


You can find a log of what happened at `logs/DasDds.out`