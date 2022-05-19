---
title: "How to update ERDDAP"
keywords: homepage
toc: true
summary: Guide on how to update ERDDAP
---

## Requirements
* ERDDAP is deployed using the Docker container as described in the [Quick Start](/erddap-gold-standard/index.html).

## Steps
1. Check that [docker-erddap](https://hub.docker.com/r/axiom/docker-erddap/tags) has the version you want to update to.
2. Review **Things ERDDAP Administrators Need to Know and Do** on the [ERDDAP Changes](https://coastwatch.pfeg.noaa.gov/erddap/download/changes.html) page.
   1. Be sure to review all of the topics listed between your deployed version and the one you want to update to. Some of the changes impact the various configuration files and as such should be addressed.
3. Stop the running docker container 
   ```shell
   $ docker-compose down
   ```
4. Update `image:` in [docker-compose.yml](https://github.com/ioos/erddap-gold-standard/blob/master/docker-compose.yml#L5) to point to appropriate version you want to update to.
5. Make the appropriate edits to the configuration files as researched in **Step 1**.
6. Spin up the new version 
   ```shell
   $ docker-compose up -d
   ```
7. Check <http://localhost:8080/erddap/status.html> to see the status of your ERDDAP.

## What to do if something breaks
1. If there is a problem, visit <http://localhost:8080/erddap/status.html> (which flushes log information to the log file), then look for
an error message related to the dataset in `/erddap/data/logs/log.txt`.