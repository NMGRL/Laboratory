#!/bin/sh
#===============================================
#Configuration
BACKUP_PATH=/data/backups/
USER=
PASSWORD=
BASE=${BACKUP_PATH}/base
#==============================================

# stop service
service mysql stop

# restore
innobackupex --copy-back ${BASE}

chown -R mysql:mysql /var/lib/mysql

# start service
service mysql start