#!/bin/sh
#===============================================
#Configuration
BACKUP_PATH=/data/backups/
BASE=${BACKUP_PATH}/base
#==============================================

echo =========================================
echo Pruning Backups
echo =========================================

# remove old backups

#1. get backups to prune
#2. sort backups chronologically with oldest first
#3. prepare backup
#4. apply backup to base

echo Preparing Base
innobackupex --apply-log --redo-only ${BASE}


for d in `ls -t ${BACKUP_PATH}/inc | tail  -n +2`;
do

echo applying incremental backup ${d}
innobackupex --apply-log --redo-only ${BASE} --incremental-dir=inc/${d}

done

echo Preparing Base 2
innobackupex --apply-log ${BASE}

