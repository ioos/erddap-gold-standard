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

### Update `<flagKeyKey>`

Change `<flagKeyKey>` to something new.

## Adding a new dataset

** TODO: add instructions. need to add the file to `datasets/` and then run `GenerateDatasetsXml.sh` and add that into `datasets.xml` ** 
