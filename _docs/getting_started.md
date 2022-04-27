# Getting Started With ERDDAP

## Notes to flush out


  - dasdds[.sh, .bat] (Jeff)
  - Fewer iterations per concise guidance (compared with "900-950")
  - Spatial data: what's the difference in markup
  - Ownership
  - Snippetize datasets.xml ([Jinja](https://jinja.palletsprojects.com/en/3.1.x/), other tools?)  
  - Nice example of a CSV file
      - Bio data (https://ioos.github.io/mbon-docs/mbon-data-flow.html#ra-erddap)
- Docker (MD file)
  - GitHub actions?
  - persistence of datasets.xml 
- Kubernetes and setup of a YAML file for that (MD file)
  - persistence of datasets.xml
- Tools for easing data integration into ERDDAP
- Make this all less vague, no more jazz hands
- Mention the Google Group: https://groups.google.com/g/erddap
- References to the original ERDDAP docs
- Make this doc SEARCHABLE
  - Jekyll ( Matt started a new template)

- On-premises development
- 
Goals:

- Work with the Gold Standard guide
- But also tear it out of its Docker context
- Encapulate details in proper sections of documentation
  - see those lines above with "(MD file)" by them
- local -> try out dataset -> times 999 -> deploy


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
git clone https://github.com/ioos/erddap-gold-standard.git
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

#### Update Docker image/ERDDAP instance
* https://github.com/ioos/erddap-gold-standard/issues/8

## Working on the datasets.xml file (MD file)

### Sample Datasets

#### NetCDF

#### CSV

Sample dataset:
https://github.com/HakaiInstitute/erddap-basic/blob/master/datasets/sample-dataset/sample.csv

Sample datasets.xml config:
https://github.com/HakaiInstitute/erddap-basic/blob/master/config/datasets.xml

- Putting the file in the datasets/ folder
    - 
- Running GenerateDatasetsXml.sh
- Mapping column names
- Adding units
- 

### generateDatasetsXML[.sh, .bat]

- To run GenerateDatasetsXml.sh within your Docker environment:

    `bash GenerateDatasetsXml.sh`

- If this was successful, it will create a snippet which is output to logs folder. Paste that snipped into the file ???`/erddap/content/datasets.xml`???. 


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
