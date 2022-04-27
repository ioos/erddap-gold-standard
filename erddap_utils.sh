export ERDDAP_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
export ERDDAP_DATASETS_XML=${ERDDAP_DIR}/erddap/content/datasets.xml
export ERDDAP_DATA_DIR=${ERDDAP_DIR}/datasets
export ERDDAP_GENDATA_DIR=${ERDDAP_DIR}/gen_datasets
if [ -z $ERDDAP_URL ]; then
    export ERDDAP_URL=cioosatlantic.ca
fi


erddap_generate_datasets_xml() {
    pushd $ERDDAP_DIR
    sudo bash GenerateDatasetsXml.sh
    popd
}

erddap_copy_gendata() {
    dataset_id=$1
    if [ -z $dataset_id ]; then
        echo "Usage: erddap_copy_gendata <dataset id>"
    else
        pushd $ERDDAP_DIR
        mkdir -p $ERDDAP_GENDATA_DIR
        mv $ERDDAP_DIR/erddap/data/GenerateDatasetsXml.out $ERDDAP_GENDATA_DIR/${dataset_id}.xml
        echo "The latest generated XML has been copied to $ERDDAP_GENDATA_DIR/${dataset_id}.xml"
    fi
}

erddap_dir() {
    cd $ERDDAP_DIR
}

erddap_chown_datasets() {
    sudo chown $USER ${ERDDAP_DATASETS_XML}
}

erddap_chown_content() {
    sudo chown -R $USER ${ERDDAP_DIR}/erddap/content
}

erddap_dataset_ids() {
    if [ ! -z $ERDDAP_APACHE_PASS ]; then
        curl https://$ERDDAP_URL/erddap/tabledap/allDatasets.tsv?datasetID
    else
        curl https://$ERDDAP_URL/erddap/tabledap/allDatasets.tsv?datasetID
    fi
}

erddap_refresh_dataset() {
    dataset_id=$1
    flag_file=${ERDDAP_DIR}/erddap/data/hardFlag/${dataset_id}
    echo "Creating the following flag file to force refresh of dataset $dataset_id"
    echo $flag_file
    sudo touch $flag_file
    echo "Restart ERDDAP to complete the dataset refresh"
}

erddap_log_docker() {
    sudo docker logs erddap_gold_standard 2>&1 | less
}

erddap_log_data() {
    sudo docker exec erddap_gold_standard tail -n 300 /erddapData/logs/log.txt 2>&1 | less
}

erddap_restart() {
    pushd $ERDDAP_DIR
    sudo docker restart erddap_gold_standard
    popd
}

erddap_check_compliance() {
    # TODO
    x=
}
