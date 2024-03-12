#!/bin/bash
# generate nco-yaml (readable yaml representation of nco-json)
# representations of gold standard datasets
# usage:
#   generate nco-yaml files from datasets/*.nc files:
#     ./datasets-yml/datasets.yml.sh
#   check that nco-yaml files are up-to-date:
#     ./datasets-yml/datasets.yml.sh -c
#
# requirements:
#   ncks/nco (https://nco.sourceforge.net/nco.html)
#   yq v4 (https://mikefarah.gitbook.io/yq/)

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd "$DIR"

CHECK=0
while getopts ":c" opt; do
  case ${opt} in
    c )
      CHECK=1
      ;;
    \? )
      echo "Invalid option: $OPTARG" 1>&2
      ;;
    : )
      echo "Invalid option: $OPTARG requires an argument" 1>&2
      ;;
  esac
done
shift $((OPTIND -1))

# check for required commands
for c in ncks yq; do
  if ! command -v $c &> /dev/null; then
    echo "Command $c is required but missing" >&2
    exit 1
  fi
done

# write nco-yaml for each dataset
for d in ../datasets/*.nc; do
  YML="$(basename $d).yml"
  NCO_YAML="$(ncks -mM --json "$d" | yq -p=json)"
  if [ "$CHECK" == "1" ]; then
    # if in check mode, make sure yaml files exist for all datasets
    # and don't differ from generated output
    if [ ! -f "$YML" ]; then
      echo "$d doesn't have an existing yml file">&2
      exit 1
    fi
    NC_CHECKSUM=$(echo -n "$NCO_YAML" | md5sum | cut -f1 -d\ )
    YAML_CHECKSUM=$(md5sum $YML | cut -f1 -d\ )
    if [ "$NC_CHECKSUM" != "$YAML_CHECKSUM" ]; then
      echo "$d metadata checksum differs from existing yaml file">&2
      exit 1
    fi
  else
    # if not in check mode, write nco-yaml
    echo -n "$NCO_YAML" > "$YML"
  fi
done
