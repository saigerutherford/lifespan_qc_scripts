#!/bin/bash

CWD=`pwd`
TARGETDIR=$1
if [ -z ${TARGETDIR} ]; then
    echo "Need to provide target directory to clean up"
    exit 1
fi

cd ${TARGETDIR}
FILENAME=`cat envvars.js | grep filename | sed 's/filename="//' | sed 's/";//'`
rm -rf index.html todo papaya.css papaya.js papaya_qc_code.js envvars.js images.json ${FILENAME}

cd ${CWD}
rmdir ${TARGETDIR}
if [ ! $? -eq 0 ]; then
    echo "Couldn't remove target directory."
    exit 1
fi
