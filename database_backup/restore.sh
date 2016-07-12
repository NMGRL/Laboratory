#!/usr/bin/env bash
# This a simple script for restoring a database from a directory containing a set of backup .sql files
# Use this script to restore databases backed up by Julian's automated backup powershell script.
# For some reason Julian's script has trouble mysqldumping large databases as a single file
# His solution was to dump each table as a separate file.
#
# This script simply iterates over a directory and imports all .sql files
#
# `mysql` mush be on the path for this script work
# by default the mysql connection attempt times out after 2 seconds

ROOT=$1
DATABASE=$2
HOST=$3
USER=$4

if [[ $ROOT == -h ]]; then
    echo usage: restore.sh [-h] root database host user
    exit
fi

echo Root: ${ROOT}
echo Database: ${DATABASE}

echo -n "Database Password: "
read -s pwd

echo
echo -------------------------------------

cd $ROOT
for i in $(ls ${ROOT}); do
    if [[ $i == *.sql ]]; then
        echo Uploading ${i}
        mysql --connect-timeout=2 -h${HOST} -u${USER} -p${pwd} ${DATABASE} < $i
        if [ $? -ne 0 ]; then
            break
        fi
    else
       echo Skipping $i
    fi
done