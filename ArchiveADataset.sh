#!/bin/bash
docker run --rm -it \
  -v "${DATASETS_DIR}:/datasets" \
  -v "$(pwd)/logs:/erddapData/logs" \
  -v "$(pwd)/erddap/content:/usr/local/tomcat/content/erddap" \
  -v "$(pwd)/erddap/data:/erddapData" \                                                                                                                                                                                                                                          axiom/docker-erddap:latest \
  bash -c "cd webapps/erddap/WEB-INF/ && bash ArchiveADataset.sh -verbose"
