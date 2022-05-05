---
title: "ERDDAP Quick Start"
keywords: homepage
tags: [getting_started, about, overview]
toc: true
#permalink: index.html
summary: A quick start for deploying an ERDDAP server.
---

This page aims to provide a quick start for standing up an ERDDAP server using the [ERDDAP Docker image](https://github.com/axiom-data-science/docker-erddap) and a few IOOS Gold Standard 
Example datasets. You can view this setup live at <https://standards.sensors.ioos.us/erddap/index.html>, with dataset documentation at <https://ioos.github.io/ioos-metadata/gold-standard-examples.html>.

This getting started page provides instructions and links to external resources for setting up an ERDDAP server using a single Docker image. [Multi-node Kubernetes deployments](/erddap-gold-standard/kubernetes.html) are linked to under the **Other deployment** options sidebar.

## Requirements
There are a few items you need to have installed on your system to deploy ERDDAP using this repository.

1. Git: <https://git-scm.com/>
2. Docker: <https://www.docker.com/>
   1. Ubuntu Linux: <https://docs.docker.com/engine/install/ubuntu/>
   2. Windows: <https://docs.docker.com/desktop/windows/install/>
   3. Mac: <https://docs.docker.com/desktop/mac/install/>
3. _(optional)_ Docker compose: <https://docs.docker.com/compose/install/>

## Step 1: Download this Repo

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

## Step 2: Start the Docker daemon/engine

- Windows: 
   -  Search for Docker, and select **Docker Desktop** in the search results.
- Linux:
  - RedHat/CentOS: ```sudo systemctl start docker``` 
  - Ubuntu: ```sudo systemctl start docker```
- Mac: 
  - Double-click **Docker.app** in the Applications folder to start Docker.

## Step 3: Deploy ERDDAP locally
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

    or, copy the `.env.template` file to `.env`, and then run:

    ```shell
    $ docker-compose up -d
    ```
   1. Remember, when you run ERDDAP from the Docker container, various configuration files will be mounted into the 
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

    You can monitor <http://localhost:8080/erddap/status.html> to see the status of dataset loading.   

## Step 4: Next Steps
Once you have successfully deployed an ERDDAP using the Docker instance, it's time to start testing out what you can do. 
Below are links to a few of the topics that might be of interest:
* [Adding datasets to ERDDAP](/erddap-gold-standard/adding-datasets.html) - How to add new datasets to ERDDAP
* [Customizing your ERDDAP](/erddap-gold-standard/modify-erddap.html) - How to configure ERDDAP using environment variables.
* [Useful utilities](/erddap-gold-standard/erddap-utils.html) - Examples of a few other useful commands
