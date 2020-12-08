#!/bin/bash
DATA_DIR="../datasets/coast_of_bays"
DATA_URL="https://pacgis01.dfo-mpo.gc.ca/FGPPublic/COAST_Of_BAys/ResDoc2/TEXT_FILES.zip"
DATA_ZIP=TEXT_FILES.zip

mkdir $DATA_DIR
cd $DATA_DIR
wget $DATA_URL
unzip $DATA_ZIP
rm $DATA_ZIP

