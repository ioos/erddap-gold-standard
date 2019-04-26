#!/bin/sh

NORMAL="-server -d64 -Xms1G -Xmx2G"
HEAP_DUMP="-XX:+HeapDumpOnOutOfMemoryError"
HEADLESS="-Djava.awt.headless=true"
EXTRAS="-XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled"
CONTENT_ROOT="-DerddapContentDirectory=$CATALINA_HOME/content/erddap"
JNA_DIR="-Djna.tmpdir=/tmp/"
FASTBOOT="-Djava.security.egd=file:/dev/./urandom"

JAVA_OPTS="$JAVA_OPTS $NORMAL $HEAP_DUMP $HEADLESS $EXTRAS $CONTENT_ROOT/ $JNA_DIR $FASTBOOT"
echo "ERDDAP running with: $JAVA_OPTS"
