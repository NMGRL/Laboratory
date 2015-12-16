#!/bin/sh
#
#########################################
# j.ross			#
# -- 					#
# prunes the backed up database archives
#########################################
# configuration
BACKUP_DIR=$HOME/backups
PRUNE_NAME=pychrondata*

cd $BACKUP_DIR

for D in week*; do
  cd $BACKUP_DIR/$D
  ls -t $PRUNE_NAME | tail  -n +2 | xargs rm
done
