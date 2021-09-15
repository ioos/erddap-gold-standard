#!/bin/bash
if [ -e "$(pwd)/.env" ]; then
  DATASETS_DIR=`grep DATASETS_DIR $(pwd)/.env | sed s/.*\=//`
fi
if [ -z $DATASETS_DIR ]; then
  DATASETS_DIR=$(pwd)/datasets
fi
docker run --rm -it \
  -v "${DATASETS_DIR}:/datasets" \
  -v "$(pwd)/logs:/erddapData/logs" \
  axiom/docker-erddap:latest \
  bash -c "cd webapps/erddap/WEB-INF/ && bash GenerateDatasetsXml.sh -verbose"
  
