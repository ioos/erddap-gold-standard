#!/bin/bash
export $(xargs < .env)
if [ -z $DATASETS_DIR ]; then
  DATASETS_DIR=/srv/data/erddap
fi
docker run --rm -it \
  -v "${DATASETS_DIR}:/datasets" \
  -v "$(pwd)/logs:/erddapData/logs" \
  -v "$(pwd)/erddap/content:/usr/local/tomcat/content/erddap" \
  ${IMAGE} \
  bash -c "cd webapps/erddap/WEB-INF/ && bash DasDds.sh"

