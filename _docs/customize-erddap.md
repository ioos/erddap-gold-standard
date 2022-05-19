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

For the initial setup, you MUST at least change these settings: 
* `<bigParentDirectory>`
* `<emailEverythingTo>`
* `<baseUrl>` 
* `<email.*>`
* `<admin.*>` (and `<baseHttpsUrl>` when you set up https)

#### Configure administrator information
The settings below contain information about the ERDDAP administrator and is used for the SOS and WMS servers. 
Update the `<admin.*>` tags by setting:

```shell
ERDDAP_adminInstitution=""
ERDDAP_adminInstitutionUrl=""
ERDDAP_adminIndividualName=""
ERDDAP_adminPosition=""
ERDDAP_adminPhone="+1 ###-###-####"
ERDDAP_adminAddress=""
ERDDAP_adminCity=""
ERDDAP_adminStateOrProvince=""
ERDDAP_adminPostalCode=""
ERDDAP_adminCountry=""
ERDDAP_adminEmail=""
```

#### Configure email
Email account information is used for sending emails to the `emailEverythingTo` and `emailDailyReportsTo` email 
addresses and for sending emails related to subscriptions. So if you don't setup the email system, your ERDDAP 
won't support subscriptions (including allowing other ERDDAP's to subscribe to datasets on your ERDDAP).

If you don't want your ERDDAP to send emails, change the `emailSmtpHost` tag contents to be nothing.

It is a security risk to put your email password in a plain text file like this. To mitigate that problem, we strongly 
recommend that you:
1. Set up an email account just for ERDDAP's use, e.g., erddap@yourInstitution.org That has other benefits as well: more 
than one ERDDAP administrator can then be given access to that email account.
2. Make the permissions of this `setup.xml` file `rw` (read+write) for the user who will run Tomcat and ERDDAP 
(user=tomcat?) and no permissions (not read or write) for the group and other users. 
 
`emailProperties` is a list of additional properties in the form `prop1|value1|prop2|value2`. The default is nothing.

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

For example, with NOAA email accounts would use the following settings:
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