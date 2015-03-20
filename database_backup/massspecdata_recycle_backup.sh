#!/bin/sh
#
#########################################
# r.earley 04-2004			#
# -- 					#
# script to take mysql dumps from	#
# the mass spec mysql DB for backup.	#
#########################################

#Set these
BACKUP_DIR=$HOME/backups
BACKUP_COMMAND="/usr/local/mysql/bin/mysqldump --user=root --password=DBArgon massspecdata"
BACKUP_LOG_DIR=$BACKUP_DIR/log
BACKUP_LOG_FILE="recycle.log"
SEND_EMAIL_ON_FAILURE="YES" # use YES or NO
ADDRESS_TO_NOTIFY="jirhiker@gmail.com"
MESSAGE="There was a failure in the mass spec DB backup.  Check the logs!"
#------------------------------

#Date variables
#DATE=`date "+%Y%m%d_%H%M"`
#WEEK=`date +%W`
#DAY_OF_THE_WEEK=`date +%a`
#------------------------------
echo "Doing Recycle"
#test if week dir exists, if not, make it.
#if [ ! -d "$BACKUP_DIR"/week$WEEK ]; then
#	mkdir $BACKUP_DIR/week$WEEK
#fi
#------------------------------

# run backup, redirecting stderr to the logfile (should be none, it it works)
# if it works, add a line to the logfile with Success,
# and link from  bkupdir/weekno/dumpfile to bkupdir/ms_data_dump.DayOfWeek
# (for simple next-day backups...this could be removed.
# if it fails, add a Failure line to the log,
# remove empty dumpfile and email someone if enabled.

if  $BACKUP_COMMAND | gzip > $BACKUP_DIR/ms_data_recycle.gz 2>>$BACKUP_LOG_DIR/$BACKUP_LOG_FILE ; then
	echo "`date` Backup Successful to file $BACKUP_DIR/ms_data_recycle.gz" >> $BACKUP_LOG_DIR/$BACKUP_LOG_FILE
else
echo "`date` Backup FAILED! with the message printed above.">> $BACKUP_LOG_DIR/$BACKUP_LOG_FILE
	if [ $SEND_EMAIL_ON_FAILURE = "YES" ]; then
	echo $MESSAGE  | mail -s "MYSQL Backup Problem"  $ADDRESS_TO_NOTIFY

fi
fi
