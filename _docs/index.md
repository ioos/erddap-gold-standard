---
title: "Getting Started with ERDDAP"
keywords: homepage
tags: [getting_started, about, overview]
toc: true
#permalink: index.html
summary: A more robust how-to guide for deploying, managing, and updating an erddap server.
---

This page aims to provide an easy-to-use walkthrough for standing up an ERDDAP server using the [ERDDAP Docker image](https://github.com/axiom-data-science/docker-erddap) and IOOS Gold Standard 
Example datasets. You can view this setup live at <https://standards.sensors.ioos.us/erddap/index.html>, with dataset documentation at <https://ioos.github.io/ioos-metadata/gold-standard-examples.html>.

This getting started page provides instructions and links to external resources for setting up an ERDDAP server using a single Docker image. Multi-node Kubernetes deployments are described [elsewhere](/erddap-gold-standard/kubernetes.html).

## Download this Repo

Create a folder to clone the ERDDAP repository into, or just into your home directory. For more help on cloning repositories available on GitHub, please check [here](https://docs.github.com/en/get-started/getting-started-with-git/about-remote-repositories).

```shell
$ git clone https://github.com/ioos/erddap-gold-standard.git
```

Now let's have a look at what we downloaded.

```shell
$ cd erddap-gold-standard/
$ ls -Ap
.env.template  .gitignore          DasDds.sh  docker-compose.yml  erddap_utils.sh         README.md
.git/          ArchiveADataset.sh  datasets/  erddap/             GenerateDatasetsXml.sh
```

## Docker local development for ERDDAP
### Install Docker 

Ubuntu Linux: <https://docs.docker.com/engine/install/ubuntu/>

Windows: <https://docs.docker.com/desktop/windows/install/>

Mac: <https://docs.docker.com/desktop/mac/install/>

### Install Docker compose 
For all operating systems, take a look at: <https://docs.docker.com/compose/install/>

### Start the docker daemon/engine

- Windows:
- Linux:
  - RedHat/CentOS: ```sudo systemctl start docker``` 
  - Ubuntu: ```sudo systemctl start docker```
- Mac: 
  - Run the Applications/Docker application.

## Deploy ERDDAP locally
1. Run it! 
    ```shell
    $ docker run --rm \
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

    ```shell
    $ docker-compose up -d
    ```
   1. Remember, when you run ERDDAP from the docker container, various configuration files will be mounted into the 
      container from your local system. Review the various mount points (`-v` flags in your `docker run`/`docker-compose.yml`)
      to ensure you know where the appropriate files are coming from and going to.
2. You should be able to see something similar to the following:

    ```shell
    Creating network "erddap-gold-standard_default" with the default driver
    Pulling erddap (axiom/docker-erddap:2.18)...
    2.18: Pulling from axiom/docker-erddap
    Digest: sha256:1ae5c7637ba14db60c5a0cd143e9fc1eb4115cdd8f030f40b22d1fdbea919ba3
    Status: Downloaded newer image for axiom/docker-erddap:2.18
    Creating erddap_gold_standard ... done
    ```

3. Connecting to your new ERDDAP server:

    In your web browser navigate to <http://localhost:8080/erddap/index.html>. 
    You should now see the standard ERDDAP Website:
    ![Standard ERDDAP Website](https://github.com/ioos/erddap-gold-standard/raw/gh-pages/_docs/images/standard_erddap_site.png "Standard ERDDAP Site")

    You can monitor [http://localhost:8080/erddap/status.html](http://localhost:8080/erddap/status.html) to see the status of dataset loading.   
	
## Modifying ERDDAP

These instructions are minimal, and are intended to get you up and running quickly so that you can test out ERDDAP.  
For full instructions on how to set up your own ERDDAP server, see [https://coastwatch.pfeg.noaa.gov/erddap/download/setup.html](https://coastwatch.pfeg.noaa.gov/erddap/download/setup.html).

### Configuration files overview

* `datasets/` -- Sample datasets. This is where you put your source data files to be loaded in ERDDAP.
* `erddap/`
    * `erddap/conf/`
      * `erddap/conf/config.sh` -- [ERDDAP configuration](https://github.com/axiom-data-science/docker-erddap#erddap)
      * `erddap/conf/robots.txt` -- [Search engine crawler config](https://coastwatch.pfeg.noaa.gov/erddap/download/setup.html#robots)
    * `erddap/content/`
      * `erddap/content/datasets.xml` -- [Datasets configuration](https://coastwatch.pfeg.noaa.gov/erddap/download/setupDatasetsXml.html), references data in `datasets/` above
      * `erddap/content/images/erddap2.css` -- [CSS overrides](https://coastwatch.pfeg.noaa.gov/erddap/download/setup.html#erddapContent)


### Update `config.sh`

Set the following variables in `config.sh`

#### Configure your institution

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


#### Configure email

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

#### Update for your domain

Update `<baseUrl>`, `<baseHttpsUrl>` and `<flagKeyKey>` to match your domain by setting:

```
ERDDAP_baseUrl=""
ERDDAP_baseHttpsUrl=""
ERDDAP_flagKeyKey=""
```

## Adding a new dataset
The [Use Cases](use-cases.md) page demonstrates how to ingest a few common data types into ERDDAP. Examples currently include datasets imported from NetCDF, CSV, and from an EML metadata file.

### Working on the datasets.xml file

From the [canonical ERDDAP docs](https://coastwatch.pfeg.noaa.gov/erddap/download/setupDatasetsXml.html): 
> After you have followed the ERDDAP installation instructions, you must edit the datasets.xml file in tomcat/content/erddap/ to describe the datasets that your ERDDAP installation will serve.

###  Run GenerateDatasetsXML[.sh, .bat]
Remember that everything is relative to the `erddap-gold-standard/` directory. So, if your data files are in `erddap-gold-standard/datasets/`
your **Starting Directory** should be `/datasets`.

- To run [GenerateDatasetsXml.sh](https://github.com/ioos/erddap-gold-standard/blob/master/GenerateDatasetsXml.sh) within your Docker environment:

```shell
$ ./GenerateDatasetsXml.sh
```

## Inspect and edit xml created by GenerateDatasetsXml.sh
If successful, GenerateDatasetsXml.sh will have created the file `/logs/GenerateDatasetsXml.out` which contains a 
template of what the datasets.xml snippet should be for the dataset provided.

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

## ERDDAP Utilities

Examples of a few other useful commands are provided on the [ERDDAP Utilities](/erddap-gold-standard/erddap-utils.html) page

## FAQ

* If a dataset fails to load, you can see logs under `/erddap/data/logs`.
* ERDDAP caches datasets, so if you change one, you can force refresh by using the hardFlag system. For example `touch /erddap/data/hardFlag/41024-sun2-sunset-nearshore`.  