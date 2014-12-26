#!/bin/sh
#
#########################################
# r.earley 04-2004			#
# -- 					#
# script to take mysql dumps from	#
# a mysql DB for backup.	        #
#########################################	

#Set these 
BACKUP_DIR="/Volumes/database_backups/backup"
BACKUP_COMMAND="/usr/local/mysql/bin/mysqldump --user=root --password=DBArgon pychrondata"
BACKUP_LOG_DIR="/Volumes/database_backups/log"
BACKUP_LOG_FILE="current.log"
SEND_EMAIL_ON_FAILURE="YES" # use YES or NO
ADDRESS_TO_NOTIFY="jirhiker@gmail.com"
MESSAGE="There was a failure in the DB backup.  Check the logs!"
#------------------------------

#Date variables
DATE=`date "+%Y%m%d_%H%M"`
WEEK=`date +%W`
DAY_OF_THE_WEEK=`date +%a`
#------------------------------
echo "Backing up"
#test if week dir exists, if not, make it.
if [ ! -d "$BACKUP_DIR"/week$WEEK ]; then
	mkdir $BACKUP_DIR/week$WEEK	
fi
#------------------------------

# run backup, redirecting stderr to the logfile (should be none, if it works)
# if it works, add a line to the logfile with Success, 
# and link from  bkupdir/weekno/dumpfile to bkupdir/pychrondata_dump.DayOfWeek 
# (for simple next-day backups...this could be removed.
# if it fails, add a Failure line to the log, 
# remove empty dumpfile and email someone if enabled.

if  $BACKUP_COMMAND | gzip > $BACKUP_DIR/week$WEEK/pychrondata_dump.$DATE.gz 2>>$BACKUP_LOG_DIR/$BACKUP_LOG_FILE ; then 
	echo "`date` Backup Successful to file $BACKUP_DIR/week$WEEK/pychrondata_dump.$DATE" >> $BACKUP_LOG_DIR/$BACKUP_LOG_FILE
# ln -fs $BACKUP_DIR/week$WEEK/pychrondata_dump.$DATE $BACKUP_DIR/pychrondata_dump.most_recent
else
echo "`date` Backup FAILED! with the message printed above.">> $BACKUP_LOG_DIR/$BACKUP_LOG_FILE
	rm $BACKUP_DIR/week$WEEK/pychrondata_dump.$DATE
	if [ $SEND_EMAIL_ON_FAILURE = "YES" ]; then
	echo $MESSAGE  | mail -s "MYSQL Backup Problem"  $ADDRESS_TO_NOTIFY

fi
fi


