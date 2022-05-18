---
title: "Customize your ERDDAP"
keywords: customize
tags: [modify, customize]
toc: true
#permalink: index.html
summary: A how-to guide for modifying an ERDDAP server.
---
## Customizing ERDDAP

These are minimal instructions for customizing ERDDAP and are intended to get you up and running quickly so that you can 
test out ERDDAP.

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

Starting with ERDDAP v2.13, ERDDAP administrators can override any value in setup.xml by specifying an environment 
variable named `ERDDAP_valueName` before running ERDDAP. For example, use `ERDDAP_baseUrl` overrides the `<baseUrl>` 
value. The `config.sh` script assists with setting those environment variables. Below are some of the configurations
you may want to set up.

#### Configure your institution

Update the `<admin.*>` tags by setting:

```shell
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
To configure the email address update the `<email.*>` and `<emailEverythingTo>` tags by setting:

```shell
ERDDAP_emailEverythingTo=""
ERDDAP_emailDailyReportsTo=""
ERDDAP_emailFromAddress=""
ERDDAP_emailUserName=""
ERDDAP_emailPassword=""
ERDDAP_emailProperties=""
ERDDAP_emailSmtpHost=""
ERDDAP_emailSmtpPort=""
```

For example, with a NOAA email accounts use the following settings:
```shell
ERDDAP_emailSmtpHost="http://smtp.gmail.com/"
ERDDAP_emailSmtpPort="587" 
ERDDAP_emailProperties="mail.smtp.starttls.enable|true"
```

#### Update for your domain

Update `<baseUrl>`, `<baseHttpsUrl>` and `<flagKeyKey>` to match your domain by setting:

```shell
ERDDAP_baseUrl=""
ERDDAP_baseHttpsUrl=""
ERDDAP_flagKeyKey=""
```