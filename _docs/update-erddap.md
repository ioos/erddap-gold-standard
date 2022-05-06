---
title: "How to update ERDDAP"
keywords: homepage
tags: [examples, use cases, table]
toc: true
summary: Guide on how to update ERDDAP
---

## Requirements
* ERDDAP is deployed using the Docker container as described in the [Quick Start](/ioos-gold-standard/index.html).

## Steps
1. Check [docker-erddap](https://hub.docker.com/r/axiom/docker-erddap/tags) has the version you want to update to.
2. Review **Things ERDDAP Administrators Need to Know and Do** on the [ERDDAP Changes](https://coastwatch.pfeg.noaa.gov/erddap/download/changes.html) page.
   1. Be sure to review all of the topics listed between your deployed version and the one you want to update to. Some of the changes impact the various configuration files and as such should be addressed.
3. Stop the running docker container 
   ```shell
   $ docker-compose down
   ```
4. Update image line in [`docker-compose.yml`](https://github.com/ioos/erddap-gold-standard/blob/master/docker-compose.yml#L5) to point to appropriate version you want to update to: ![](https://github.com/ioos/erddap-gold-standard/raw/gh-pages/_docs/images/docker-compose-edit.png)
5. Make the appropriate edits to the configuration files as researched in 1.
6. Spin up the new version 
   ```shell
   $ docker-compose up -d
   ```