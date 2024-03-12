#!/bin/bash
docker run --rm -it \
  -v "$(pwd)/datasets:/datasets" \
  -v "$(pwd)/logs:/erddapData/logs" \
  -v "$(pwd)/erddap/content:/usr/local/tomcat/content/erddap" \
  -e ERDDAP_flagKeyKey=flag-key-not-needed-for-dasdds \
  axiom/docker-erddap:2.23-jdk17-openjdk \
  bash -c "cd webapps/erddap/WEB-INF/ && bash DasDds.sh"
