# Overview

Example datasets and configuration for ERDDAP.

Uses the [ERDDAP Docker image](https://github.com/axiom-data-science/docker-erddap).

You can view this setup live at [https://standards.sensors.ioos.us/erddap/index.html](https://standards.sensors.ioos.us/erddap/index.html),
with documentation at [https://ioos.github.io/ioos-metadata/gold-standard-examples.html](https://ioos.github.io/ioos-metadata/gold-standard-examples.html).

# Download

You should `git clone` or download and unzip this repository from the green "Clone or download" button. Once cloned or downloaded, move into the directory.

```
$ ls
datasets erddap .gitignore README.md
```

# Run

```
docker run --rm \
  --name erddap_gold_standard \
  -p 8080:8080 \
  -v $(pwd)/erddap/conf/config.sh:/usr/local/tomcat/bin/config.sh \
  -v $(pwd)/erddap/conf/robots.txt:/usr/local/tomcat/webapps/ROOT/robots.txt \
  -v $(pwd)/erddap/content:/usr/local/tomcat/content/erddap \
  -v $(pwd)/erddap/data:/erddapData \
  -v $(pwd)/datasets:/datasets \
  -v /tmp/:/usr/local/tomcat/temp/ \
  --env ERDDAP_MIN_MEMORY=1G --env ERDDAP_MAX_MEMORY=2G \
 axiom/docker-erddap:2.18
```

or, copy the .env.template file to .env, and then run:

```
docker-compose up -d
```

After startup, go to http://localhost:8080/erddap/index.html

You can monitor http://localhost:8080/erddap/status.html to see the status of dataset loading.
If a dataset fails to load, you can see logs under `$(pwd)/erddap/data/logs`.

Note: ERDDAP caches datasets, so if you change one, you can force refresh by creating a file under `$(pwd)/erddap/data/hardFlag/`,
for example `touch $(pwd)/erddap/data/hardFlag/41024-sun2-sunset-nearshore`.
See [ERDDAP docs on flags](https://coastwatch.pfeg.noaa.gov/erddap/download/setup.html#hardFlag).

# Modify

These instructions are minimal, and are intended to get you up and running quickly so that you can test out ERDDAP.
For full instructions on how to set up your own ERDDAP server, see https://coastwatch.pfeg.noaa.gov/erddap/download/setup.html

## Configuration files overview

* `datasets/` -- Sample datasets
* `erddap/`
    * `erddap/conf/`
      * `erddap/conf/config.sh` -- [ERDDAP configuration](https://github.com/axiom-data-science/docker-erddap#erddap)
      * `erddap/conf/robots.txt` -- [Search engine crawler config](https://coastwatch.pfeg.noaa.gov/erddap/download/setup.html#robots)
    * `erddap/content/`
      * `erddap/content/datasets.xml` -- [Datasets configuration](https://coastwatch.pfeg.noaa.gov/erddap/download/setupDatasetsXml.html), references data in `datasets/` above
      * `erddap/content/images/erddap2.css` -- [CSS overrides](https://coastwatch.pfeg.noaa.gov/erddap/download/setup.html#erddapContent)


## Update `config.sh`

Set the following variables in `config.sh`

### Configure your institution

Update the `<admin.*>` tags by setting:

```
ERDDAP_adminInstitution=""
ERDDAP_adminInstitutionUrl=""
ERDDAP_adminIndividualName=""
ERDDAP_adminPosition=""
ERDDAP_adminPhone=""
ERDDAP_adminAddress=""
ERDDAP_adminCity=""
ERDDAP_adminStateOrProvince=""
ERDDAP_adminPostalCode=""
ERDDAP_adminCountry=""
ERDDAP_adminEmail=""
```


### Configure email

Update the `<email.*>` and `<emailEverythingTo>` tags by setting:

```
ERDDAP_emailEverythingTo=""
ERDDAP_emailDailyReportsTo=""
ERDDAP_emailFromAddress=""
ERDDAP_emailUserName=""
ERDDAP_emailPassword=""
ERDDAP_emailProperties=""
ERDDAP_emailSmtpHost=""
ERDDAP_emailSmtpPort=""
```

### Update for your domain

Update `<baseUrl>`, `<baseHttpsUrl>` and `<flagKeyKey>` to match your domain by setting:

```
ERDDAP_baseUrl=""
ERDDAP_baseHttpsUrl=""
ERDDAP_flagKeyKey=""
```

## Adding a new dataset

#### Steps

1. Add your `nc` file to `datasets/`.
1. Run `sh GenerateDatasetsXml.sh`. Results will output to the console and `logs/`.
1. Copy the resulting `<dataset>` to `erddap/content/datasets.xml`
1. Restart ERDDAP

#### Example

Say you have a file called `seward-sealife-center-astra.nc` that you've added to `datasets/`.

```
sh GenerateDatasetsXml.sh

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

#### Troubleshooting

The `DasDds` tool can help you find errors in datasets.xml, it is an interactive tool that will prompt you for a dataset ID.

```
sh DasDds.sh
```

You can find a log of what happened at `logs/DasDds.out`
