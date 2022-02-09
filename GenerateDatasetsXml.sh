#!/bin/bash
source $(pwd)/.env
if [ -z $DATASETS_DIR ]; then
  DATASETS_DIR=/srv/data/erddap
fi
if [ -z $IMAGE ]; then
  IMAGE=cioosatlantic/docker-erddap:latest
fi
docker run --rm -it \
  -v "${DATASETS_DIR}:/datasets" \
  -v "$(pwd)/logs:/erddapData/logs" \
  ${IMAGE} \
  bash -c "cd webapps/erddap/WEB-INF/ && bash GenerateDatasetsXml.sh -verbose"
  
