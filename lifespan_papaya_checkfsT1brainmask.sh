#!/bin/bash

if [ ! $# -eq 2 ]; then
    echo "usage: $0 /path/to/file /path/to/target/directory"
    echo "Where file is the list of subjects/runs to check"
    echo "And directory is a location to put the temporary files to check"
    exit 1
fi

FILEBASEPATH=/project_cephfs/3022048.01/quality_checks/Papaya/images/
TEMPLATEDIR=/project_cephfs/3022048.01/quality_checks/Papaya/src
CWD=`pwd`
TARGETDIR=$2
if [ -z ${TARGETDIR} ]; then
    TARGETDIR=`pwd`
fi

FILE=$1
FILEDIR=`dirname ${FILE}`
FILENAME=`basename ${FILE}`

USERNAME=$USER

#needs an input file of user IDs

if [ -d ${TARGETDIR} ]; then
    echo "Target directory already exists. Please specify a folder that doesn't exist"
    exit 1
fi

mkdir -p ${TARGETDIR}

cp ${FILEDIR}/${FILENAME} ${TARGETDIR}/

cd ${TARGETDIR}

#build local html file, set username/filename
cp ${TEMPLATEDIR}/* ./
echo 'username="'${USERNAME}'";' > envvars.js
echo 'filename="'${FILENAME}'";' >> envvars.js
echo 'checktype="checkfsT1brainmask";' >> envvars.js

mkdir todo
while read i
do
    SUB=`echo ${i}`
    cp ${FILEBASEPATH}/${SUB}_T1.nii ${TARGETDIR}/todo/
    cp ${FILEBASEPATH}/${SUB}_brain.finalsurfs.nii ${TARGETDIR}/todo/ 2> /dev/null
done < ${FILENAME}

tmp=`ls todo | grep T1 | head -1`
cp -a todo/${tmp} todo/test.nii.gz


#build images.json file
echo '[' > images.json
while read i
do
    SUB=`echo ${i}`
    t1="todo/${SUB}_T1.nii"
    brainmask="todo/${SUB}_brain.finalsurfs.nii"
    echo '["'${t1}'","'${brainmask}'"],' >> images.json
done < ${FILENAME}
echo '["todo/test.nii","todo/test.nii"]' >> images.json
echo ']' >> images.json

#open browser with local html file
