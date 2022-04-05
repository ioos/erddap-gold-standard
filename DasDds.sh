#!/bin/bash
export $(xargs < .env)
docker run --rm -it \
  -v "$(pwd)/datasets:/datasets" \
  -v "$(pwd)/logs:/erddapData/logs" \
  -v "$(pwd)/erddap/content:/usr/local/tomcat/content/erddap" \
  ${IMAGE} \
  bash -c "cd webapps/erddap/WEB-INF/ && bash DasDds.sh"
  
