---
title: "Use case for loading a comma separated value (.csv) file"
keywords: homepage
tags: [examples, use cases, table]
toc: true
summary: Examples for loading CSV files into ERDDAP.
---

# Overview
We will walk through loading an example dataset found at [https://github.com/HakaiInstitute/erddap-basic/blob/master/datasets/sample-dataset/sample.csv](https://github.com/HakaiInstitute/erddap-basic/blob/master/datasets/sample-dataset/sample.csv) 
into a Docker deployed ERDDAP instance.

## Pull the data to the `datasets/` directory.
```shell
/usr/local/erddap-gold-standard/datasets$ wget https://raw.githubusercontent.com/HakaiInstitute/erddap-basic/master/datasets/sample-dataset/sample.csv
HTTP request sent, awaiting response... 200 OK
Length: 9051 (8.8K) [text/plain]
Saving to: ‘sample.csv’

100%[===========================================================================================================>] 9,051       --.-K/s   in 0s

2022-04-27 18:00:18 (70.0 MB/s) - ‘sample.csv’ saved [9051/9051]

/usr/local/erddap-gold-standard/datasets$ ls sample.csv
sample.csv
```
## Run `GenerateDatasetsXml.sh`
Remember that everything is relative to the `erddap-gold-standard/` directory. So, if your data files are in `erddap-gold-standard/datasets/`
your Starting Directory should be `/datasets`.
```
/usr/local/erddap-gold-standard/datasets$ cd ../
/usr/local/erddap-gold-standard$ ./GenerateDatasetsXml.sh

////**** ERD Low Level Startup
localTime=2022-04-27T18:06:21+00:00
erddapVersion=2.14
Java 1.8.0_275 (64 bit, Oracle Corporation) on Linux (5.10.75-79.358.amzn2.x86_64).
MemoryInUse=    20 MB (highWaterMark=    20 MB) (Xmx ~= 958 MB)
SLF4J: Failed to load class "org.slf4j.impl.StaticLoggerBinder".
SLF4J: Defaulting to no-operation (NOP) logger implementation
SLF4J: See http://www.slf4j.org/codes.html#StaticLoggerBinder for further details.
logLevel=info: verbose=true reallyVerbose=false
ERROR in File2.deleteIfOld: dir=/erddapData/dataset/_FileVisitor/ isn't a directory.
bigParentDirectory=/erddapData/
webInfParentDirectory=/usr/local/tomcat/webapps/erddap/
java.awt.HeadlessException:
No X11 DISPLAY variable was set, but this program performed an operation which requires it.
 at gov.noaa.pfel.coastwatch.sgt.SgtUtil.isBufferedImageAccelerated(SgtUtil.java:368)
 at gov.noaa.pfel.erddap.util.EDStatic.<clinit>(EDStatic.java:1628)
 at gov.noaa.pfel.erddap.GenerateDatasetsXml.<clinit>(GenerateDatasetsXml.java:44)


bufferedImage isAccelerated=[unknown]
  copying images/ file: erddapStart2.css
Custom messages.xml not found at /usr/local/tomcat/content/erddap/messages.xml
Using default messages.xml from  /usr/local/tomcat/webapps/erddap/WEB-INF/classes/gov/noaa/pfel/erddap/util/messages.xml
CfToFromGcmd static loading /usr/local/tomcat/webapps/erddap/WEB-INF/classes/gov/noaa/pfel/erddap/util/CfToGcmd.txt
*** ERD Low Level Startup finished successfully.

logFileMaxSize=20000000
*** Starting GenerateDatasetsXml 2022-04-27T18:06:22 erddapVersion=2.14
logFile=/erddapData/logs/GenerateDatasetsXml.log
Java 1.8.0_275 (64 bit, Oracle Corporation) on Linux (5.10.75-79.358.amzn2.x86_64).
MemoryInUse=    61 MB (highWaterMark=    61 MB) (Xmx ~= 958 MB)
verbose=true

*** GenerateDatasetsXml ***
To enter a String with special characters or whitespace at the
  beginning or end, enter a JSON-style string (with double quotes at
  the beginning and end, and \-encoded special characters, e.g., "\t" .
Just press Enter or type the word "default" (but without the quotes)
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
https://coastwatch.pfeg.noaa.gov/erddap/download/setupDatasetsXml.html

The EDDType options are:
EDDGridAggregateExistingDimension   EDDTableFromEML
EDDGridFromAudioFiles               EDDTableFromEMLBatch
EDDGridFromDap                      EDDTableFromErddap
EDDGridFromEDDTable                 EDDTableFromFileNames
EDDGridFromErddap                   EDDTableFromHttpGet
EDDGridFromMergeIRFiles             EDDTableFromInPort
EDDGridFromNcFiles                  EDDTableFromIoosSOS
EDDGridFromNcFilesUnpacked          EDDTableFromJsonlCSVFiles
EDDGridFromThreddsCatalog           EDDTableFromMultidimNcFiles
EDDGridLonPM180FromErddapCatalog    EDDTableFromNcFiles
EDDGridLon0360FromErddapCatalog     EDDTableFromNcCFFiles
EDDTableFromAsciiFiles              EDDTableFromNccsvFiles
EDDTableFromAudioFiles              EDDTableFromOBIS
EDDTableFromAwsXmlFiles             EDDTableFromSOS
EDDTableFromBCODMO                  EDDTableFromThreddsFiles
EDDTableFromCassandra               EDDTableFromWFSFiles
EDDTableFromColumnarAsciiFiles      EDDsFromFiles
EDDTableFromDapSequence             addFillValueAttributes
EDDTableFromDatabase                findDuplicateTime
EDDTableFromEDDGrid                 ncdump

Which EDDType (default="EDDGridFromDap")
? EDDTableFromAsciiFiles
Starting directory (default="")
? /datasets
File name regex (e.g., ".*\.asc") (default="")
? sample.csv
Full file name of one file (or leave empty to use first matching fileName) (default="")
?
Charset (e.g., ISO-8859-1 (default) or UTF-8) (default="")
?
Column names row (e.g., 1) (default="")
? 1
First data row (e.g., 2) (default="")
? 2
Column separator (e.g., ',') (default="")
? ,
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
Sorted column source name (default="")
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
cacheFromUrl (default="")
?
working...
EDDTableFromAsciiFiles.generateDatasetsXml
sampleFileName=
charset= colNamesRow=1 firstDataRow=2 columnSeparator=,[end] reloadEveryNMinutes=10080
extract pre= post= regex= colName=
sortedColumn= sortFilesBy=
infoUrl=
institution=
summary=
title=
externalAddGlobalAttributes=null
Found/using sampleFileName=/datasets/sample.csv
  Table.readASCII /datasets/sample.csv finished. nCols=10 nRows=98 TIME=10ms
  sourceName=profile lcu=|profile||||
    tStandardName=
  sourceName=scientist lcu=|scientist||||
    tStandardName=
    ioos_category=Unknown for |scientist|||scientist|
  sourceName=instrument_model lcu=|instrument|model||||
    tStandardName=
    ioos_category=Unknown for |instrument|model|||instrument|model|
  sourceName=TEMPST01 lcu=|tempst01||||
    tStandardName=
    assigned tMin=NaN tMax=NaN
    ioos_category=Unknown for |tempst01|||tempst01|
  sourceName=PSALST01 lcu=|psalst01||||
    tStandardName=
    assigned tMin=NaN tMax=NaN
    ioos_category=Unknown for |psalst01|||psalst01|
  sourceName=SSALST01 lcu=|ssalst01||||
    tStandardName=
    assigned tMin=NaN tMax=NaN
    ioos_category=Unknown for |ssalst01|||ssalst01|
makeReadyToUseAddGlobalAttributesForDatasetsXml
  sourceAtts.title=null
  externalAtts=
    sourceUrl=(local files)

  old Conventions=null
  new Conventions=COARDS, CF-1.6, ACDD-1.3
  new infoUrl=???
  new keywords=data, depth, identifier, instrument, instrument_model, latitude, local, longitude, model, profile, psalst01, scientist, source, ssalst01, tempst01, time


*** generateDatasetsXml finished successfully.
```

Once you can successfully run GenerateDatasetsXml.sh it’s time to load the dataset into ERDDAP.

## Inspect and edit xml created by GenerateDatasetsXml.sh
If successful, GenerateDatasetsXml.sh will have created the file `logs/GenerateDatasetsXml.out` which contains a 
template of what the datasets.xml snippet should be for the dataset provided.

This template should be updated to include additional metadata and ensure the assumptions GenerateDatasetsXml.sh are 
correct.
```xml
/usr/local/erddap-gold-standard$ more logs/GenerateDatasetsXml.out
<!-- NOTE! Since the source files don't have any metadata, you must add metadata
  below, notably 'units' for each of the dataVariables. -->
<dataset type="EDDTableFromAsciiFiles" datasetID="datasets_6766_daf3_adf6" active="true">
    <reloadEveryNMinutes>10080</reloadEveryNMinutes>
    <updateEveryNMillis>10000</updateEveryNMillis>
    <fileDir>/datasets/</fileDir>
    <fileNameRegex>sample.csv</fileNameRegex>
    <recursive>true</recursive>
    <pathRegex>.*</pathRegex>
    <metadataFrom>last</metadataFrom>
    <standardizeWhat>0</standardizeWhat>
    <charset>ISO-8859-1</charset>
    <columnSeparator>,</columnSeparator>
    <columnNamesRow>1</columnNamesRow>
    <firstDataRow>2</firstDataRow>
    <sortedColumnSourceName>time</sortedColumnSourceName>
    <sortFilesBySourceNames>time</sortFilesBySourceNames>
    <fileTableInMemory>false</fileTableInMemory>
    <!-- sourceAttributes>
    </sourceAttributes -->
    <!-- Please specify the actual cdm_data_type (TimeSeries?) and related info below, for example...
        <att name="cdm_timeseries_variables">station_id, longitude, latitude</att>
        <att name="subsetVariables">station_id, longitude, latitude</att>
    -->
    <addAttributes>
        <att name="cdm_data_type">Point</att>
        <att name="Conventions">COARDS, CF-1.6, ACDD-1.3</att>
        <att name="infoUrl">???</att>
        <att name="institution">???</att>
        <att name="keywords">data, depth, identifier, instrument, instrument_model, latitude, local, longitude, model, profile, psalst01, scientist,
source, ssalst01, tempst01, time</att>
        <att name="license">[standard]</att>
        <att name="sourceUrl">(local files)</att>
        <att name="standard_name_vocabulary">CF Standard Name Table v70</att>
        <att name="subsetVariables">scientist, instrument_model, TEMPST01, SSALST01</att>
        <att name="summary">Data from a local source.</att>
        <att name="title">Data from a local source.</att>
    </addAttributes>
    <dataVariable>
        <sourceName>profile</sourceName>
        <destinationName>profile</destinationName>
        <dataType>String</dataType>
        <!-- sourceAttributes>
        </sourceAttributes -->
        <addAttributes>
            <att name="ioos_category">Identifier</att>
            <att name="long_name">Profile</att>
        </addAttributes>
    </dataVariable>
    <dataVariable>
        <sourceName>scientist</sourceName>
        <destinationName>scientist</destinationName>
        <dataType>String</dataType>
        <!-- sourceAttributes>
        </sourceAttributes -->
        <addAttributes>
            <att name="ioos_category">Unknown</att>
            <att name="long_name">Scientist</att>
        </addAttributes>
    </dataVariable>
    <dataVariable>
        <sourceName>instrument_model</sourceName>
        <destinationName>instrument_model</destinationName>
        <dataType>String</dataType>
        <!-- sourceAttributes>
        </sourceAttributes -->
        <addAttributes>
            <att name="ioos_category">Unknown</att>
            <att name="long_name">Instrument Model</att>
        </addAttributes>
    </dataVariable>
    <dataVariable>
        <sourceName>latitude</sourceName>
        <destinationName>latitude</destinationName>
        <dataType>double</dataType>
        <!-- sourceAttributes>
        </sourceAttributes -->
        <addAttributes>
            <att name="colorBarMaximum" type="double">90.0</att>
            <att name="colorBarMinimum" type="double">-90.0</att>
            <att name="ioos_category">Location</att>
            <att name="long_name">Latitude</att>
            <att name="standard_name">latitude</att>
            <att name="units">degrees_north</att>
        </addAttributes>
    </dataVariable>
    <dataVariable>
        <sourceName>longitude</sourceName>
        <destinationName>longitude</destinationName>
        <dataType>double</dataType>
        <!-- sourceAttributes>
        </sourceAttributes -->
        <addAttributes>
            <att name="colorBarMaximum" type="double">180.0</att>
            <att name="colorBarMinimum" type="double">-180.0</att>
            <att name="ioos_category">Location</att>
            <att name="long_name">Longitude</att>
            <att name="standard_name">longitude</att>
            <att name="units">degrees_east</att>
        </addAttributes>
    </dataVariable>
    <dataVariable>
        <sourceName>time</sourceName>
        <destinationName>time</destinationName>
        <dataType>String</dataType>
        <!-- sourceAttributes>
        </sourceAttributes -->
        <addAttributes>
            <att name="ioos_category">Time</att>
            <att name="long_name">Time</att>
            <att name="standard_name">time</att>
            <att name="time_precision">1970-01-01T00:00:00Z</att>
            <att name="units">yyyy-MM-dd&#39;T&#39;HH:mm:ss&#39;Z&#39;</att>
        </addAttributes>
    </dataVariable>
    <dataVariable>
        <sourceName>depth</sourceName>
        <destinationName>depth</destinationName>
        <dataType>float</dataType>
        <!-- sourceAttributes>
        </sourceAttributes -->
        <addAttributes>
            <att name="colorBarMaximum" type="double">8000.0</att>
            <att name="colorBarMinimum" type="double">-8000.0</att>
            <att name="colorBarPalette">TopographyDepth</att>
            <att name="ioos_category">Location</att>
            <att name="long_name">Depth</att>
            <att name="standard_name">depth</att>
            <att name="units">m</att>
        </addAttributes>
    </dataVariable>
    <dataVariable>
        <sourceName>TEMPST01</sourceName>
        <destinationName>TEMPST01</destinationName>
        <dataType>double</dataType>
        <!-- sourceAttributes>
        </sourceAttributes -->
        <addAttributes>
            <att name="_FillValue" type="double">NaN</att>
            <att name="ioos_category">Unknown</att>
            <att name="long_name">TEMPST01</att>
        </addAttributes>
    </dataVariable>
    <dataVariable>
        <sourceName>PSALST01</sourceName>
        <destinationName>PSALST01</destinationName>
        <dataType>float</dataType>
        <!-- sourceAttributes>
        </sourceAttributes -->
        <addAttributes>
            <att name="ioos_category">Unknown</att>
            <att name="long_name">PSALST01</att>
        </addAttributes>
    </dataVariable>
    <dataVariable>
        <sourceName>SSALST01</sourceName>
        <destinationName>SSALST01</destinationName>
        <dataType>double</dataType>
        <!-- sourceAttributes>
        </sourceAttributes -->
        <addAttributes>
            <att name="_FillValue" type="double">NaN</att>
            <att name="ioos_category">Unknown</att>
            <att name="long_name">SSALST01</att>
        </addAttributes>
    </dataVariable>
</dataset>
```
### Checking the `time` variable
Notice the `time` variable and its associated configuration information:
```xml
    <dataVariable>
        <sourceName>time</sourceName>
        <destinationName>time</destinationName>
        <dataType>String</dataType>
        <!-- sourceAttributes>
        </sourceAttributes -->
        <addAttributes>
            <att name="ioos_category">Time</att>
            <att name="long_name">Time</att>
            <att name="standard_name">time</att>
            <att name="time_precision">1970-01-01T00:00:00Z</att>
            <att name="units">yyyy-MM-dd&#39;T&#39;HH:mm:ss&#39;Z&#39;</att>
        </addAttributes>
    </dataVariable>
```
This snippet is telling ERDDAP to read the `time` column from the source `sample.csv` file and interpret it as a date-time 
string using the format `yyyy-MM-dd&#39;T&#39;HH:mm:ss&#39;Z&#39;` as defined in the `units` attribute.

According to the [source data file](https://github.com/HakaiInstitute/erddap-basic/blob/master/datasets/sample-dataset/sample.csv), 
the `time` column contains values looking like `2019-04-06T00:50:10Z`.



* Append xml to the end of datasets.xml
  * See /python_tools/script1insert.py
  * Master datasets file is at /usr/local/erddap-gold-standard/erddap/content/datasets.xml
  * Be sure to put it above the closing </erddapDatasets> tag. Don’t worry, the script takes care of that.
* Flag the dataset for ERDDAP to load
  * Eg.$ touch erddap/data/flag/2019_asset_inventory
* Check ERDDAP for the new dataset (might take a little if it’s a large dataset)

```
/usr/local/erddap-gold-standard/python_tools$ python
Python 1.7.18 (default, Jun 10 2021, 00:11:02)
[GCC 6.3.1 20180712 (Red Hat 7.3.1-13)] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> import xml_insert
>>> main_xml = '../erddap/content/datasets.xml'
>>> xml_snip = '../xml_by_dataset/2019_asset_inventory.xml'
>>> tree = xml_insert.xml_insert( main_xml, xml_snip )
ingesting ../erddap/content/datasets.xml
ingesting ../xml_by_dataset/2019_asset_inventory.xml
Found existing dataset node for datasetID= 2019_asset_inventory removing…
Inserting snippet for datasetID = 2019_asset_inventory into ../erddap/content/datasets.xml
>>> tree
<xml.etree.ElementTree.ElementTree object at 0x7f73e59fa6cf>
>>> tree.write('../erddap/content/datasets.xml',encoding="utf-9", xml_declaration=True) # overwrites existing datasets.xml
```