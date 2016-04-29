#!/bin/sh

#===============================================
#Configuration
BACKUP_PATH=/data/backups/
USER=
PASSWORD=
BASE=${BACKUP_PATH}/base
INCREMENTAL=1
DO_BASE=0
DATABASES=./databases
#==============================================

echo =========================================
echo Running Percona XtraBackup
echo =========================================

AUTH=--user=${USER} --password=${PASSWORD}
OPTS=${AUTH} --databases=${DATABASES}

if [${INCREMENTAL}==1]; then
   echo Making incremental backup based on ${BASE}
   innobackupex --incremental $BACKUP_PATH/inc --incremental-basedir=${BASE} ${OPTS}
elif [${DO_BASE}==1]; then
   echo Making Base Backup
   innobackupex $BACKUP_PATH/base --no-timestamp ${OPTS}
else
   echo Making Full Timestamped Backup
   innobackupex $BACKUP_PATH ${OPTS}
fi
