---
title: "Getting Started with ERDDAP"
keywords: homepage
tags: [getting_started, about, overview]
toc: false
#permalink: index.html
summary: A more robust how-to guide for deploying, managing, and updating an erddap server.
---

This page aims to provide an easy-to-use walkthrough for standing up an ERDDAP server using the [ERDDAP Docker image](https://github.com/axiom-data-science/docker-erddap) and IOOS Gold Standard 
Example datasets. You can view this setup live at [https://standards.sensors.ioos.us/erddap/index.html](https://standards.sensors.ioos.us/erddap/index.html), with dataset documentation at [https://ioos.github.io/ioos-metadata/gold-standard-examples.html](https://ioos.github.io/ioos-metadata/gold-standard-examples.html).

This getting started page provides instructions and links to external resources for setting up an ERDDAP server using a single Docker image. Multi-node Kubernetes deployments are described [elsewhere](https://link_to_what_Joe_drafts).

### Docker local development for ERDDAP
#### Install Docker 

Ubuntu Linux: https://docs.docker.com/engine/install/ubuntu/
Windows: https://docs.docker.com/desktop/windows/install/
Mac: https://docs.docker.com/desktop/mac/install/

#### Install Docker compose 
For all operating system, please check : https://docs.docker.com/compose/install/

### Start the docker daemon/engine

- Windows:
- Linux:
  - RedHat/CentOS: ```sudo systemctl start docker``` 
  - Ubuntu: 
- Mac: 
  - Run the Applications/Docker application.

### Linux/Mac/Windows


1. Create a folder to clone the ERDDAP repository into, or just into your home directory (***ps.*** There are several ways to clone repositories available on GitHub. Please check [here](https://docs.github.com/en/get-started/getting-started-with-git/about-remote-repositories)):

```
cd ~
git clone git@github.com:ioos/erddap-gold-standard.git
cd erddap-gold-standard
docker-compose up -d

```

2. You should be able to see something similar to the following:

```
Creating network "erddap-gold-standard_default" with the default driver
Pulling erddap (axiom/docker-erddap:2.18)...
2.18: Pulling from axiom/docker-erddap
Digest: sha256:1ae5c7637ba14db60c5a0cd143e9fc1eb4115cdd8f030f40b22d1fdbea919ba3
Status: Downloaded newer image for axiom/docker-erddap:2.18
Creating erddap_gold_standard ... done
```

3. Connecting to your new ERDDAP server:

In your web browser navigate to
http://localhost:8080/erddap/index.html
You should now see the standard ERDDAP Website
![](https://i.imgur.com/Ae9vWmH.png)

## Working on the datasets.xml file (MD file)

### Sample Datasets

#### NetCDF

#### CSV

Sample dataset:
[https://github.com/HakaiInstitute/erddap-basic/blob/master/datasets/sample-dataset/sample.csv](https://github.com/HakaiInstitute/erddap-basic/blob/master/datasets/sample-dataset/sample.csv)

Sample datasets.xml config:
[https://github.com/HakaiInstitute/erddap-basic/blob/master/datasets/sample-dataset/sample.csv](https://github.com/HakaiInstitute/erddap-basic/blob/master/config/datasets.xml)

- Putting the file in the datasets/ folder
- Running GenerateDatasetsXml.sh
- Mapping column names
- Adding units

### generateDatasetsXML[.sh, .bat]

- To run GenerateDatasetsXml.sh within your Docker environment:

    `bash GenerateDatasetsXml.sh`

- If this was successful, it will create a snippet which is output to logs folder. Paste that snipped into the file `/erddap/content/datasets.xml`. 


- What is a "best practice" to cp/append the output from `GenerateDatasetsXml.sh` into `/erddap/content/datasets.xml`?

- ?? Make sure to add the text between ...?
     
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
          
- Do you we need to append that text every time a new dataset is generated? 


- Reload ERDDAP-docker, by running:`docker-compose restart` 