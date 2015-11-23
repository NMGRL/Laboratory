#!/bin/sh

SEND_EMAIL_ON_FAILURE="YES" # use YES or NO
ADDRESS_TO_NOTIFY=
MESSAGE="There was a failure in the re.  Check the logs!"
USER=
PASSWD=

# dump slave status
mysql -u$USER -p$PASSWD -e "show slave status\G" > status.txt
error=$(awk '/Slave_SQL_Running: No|Slave_IO_Running: No/' status.txt)
if [ -n "$error" ]; then
  if [ $SEND_EMAIL_ON_FAILURE = "YES" ]; then
    echo $MESSAGE\n$error | mail -s "MYSQL Replication Problem"  $ADDRESS_TO_NOTIFY
  fi
fi

rm status.txt
