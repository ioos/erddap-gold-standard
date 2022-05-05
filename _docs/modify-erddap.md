---
title: "Modifying ERDDAP"
keywords: customize
tags: [modify, customize]
toc: true
#permalink: index.html
summary: A how-to guide for modifying an ERDDAP server.
---
## Modifying ERDDAP

These instructions are minimal, and are intended to get you up and running quickly so that you can test out ERDDAP.  
For full instructions on how to set up your own ERDDAP server, see <https://coastwatch.pfeg.noaa.gov/erddap/download/setup.html>.

### Configuration files overview

* `datasets/` -- Sample datasets. This is where you put your source data files to be loaded in ERDDAP.
* `erddap/`
    * `erddap/conf/`
      * `erddap/conf/config.sh` -- [ERDDAP configuration using Environment Variables](https://coastwatch.pfeg.noaa.gov/erddap/download/setup.html#setupEnvironmentVariables), see [below](#update-configsh) for more details.
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