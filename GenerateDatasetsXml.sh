#!/bin/bash
docker run --rm -it \
  -v "$(pwd)/datasets:/datasets" \
  -v "$(pwd)/logs:/erddapData/logs" \
  axiom/docker-erddap:latest \
  bash -c "cd webapps/erddap/WEB-INF/ && bash GenerateDatasetsXml.sh -verbose"
  