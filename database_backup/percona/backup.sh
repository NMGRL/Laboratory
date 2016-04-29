#!/bin/sh

#===============================================
#Configuration
BACKUP_PATH=/data/backups/
USER=
PASSWORD=
BASE=${BACKUP_PATH}/base
DATABASES=

#==============================================
while getopts "ibd:" opt; do
  case $opt in
  i)
    INCREMENTAL=1
    ;;
  b)
    DO_BASE=1
    ;;
  d)
    DATABASES=$OPTARG
    ;;
  \?)
    echo "Invalid option: -$OPTARG"
    ;;
  esac
done


echo =========================================
echo Running Percona XtraBackup
echo =========================================

if [${INCREMENTAL}==1]; then
   echo Making incremental backup based on ${BASE}
   innobackupex ${BACKUP_PATH}/inc --incremental-basedir=${BASE} --incremental
                --user=${USER} --password=${PASSWORD} --databases="${DATABASES}" 2>$1

elif [${DO_BASE}==1]; then
   echo Making Base Backup
   innobackupex $BACKUP_PATH/base --no-timestamp
                --user=${USER} --password=${PASSWORD} --databases="${DATABASES}" 2>$1
else
   echo Making Full Timestamped Backup
   innobackupex $BACKUP_PATH
                --user=${USER} --password=${PASSWORD} --databases="${DATABASES}" 2>$1
fi
