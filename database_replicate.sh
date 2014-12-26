#!/bin/bash
echo -n Master password:
read -s password
echo

# #dump massspecdata database
echo "Dump massspecdata"
# mysqldump \
#   -h129.138.12.160 \
#   -uroot \
#   -p$password \
#   --master-data \
#   massspecdata > masspecdata_bk.sql


# #dump pychron database
echo "Dump pychrondata"
mysqldump \
  -h129.138.12.160 \
  -uroot \
  -p$password \
  --master-data \
  --single-transaction \
  pychrondata > pychrondata_bk.sql

echo -n Slave password:
read -s password
echo

mysql -uroot \
 -p$password \
 -e "STOP SLAVE;"

mysql -uroot \
      -p$password \
      -e "DROP DATABASE IF EXISTS massspecdata; DROP DATABASE IF EXISTS pychrondata;"

# echo "Upload massspecdata"
# mysql -uroot \
#       -p$password \
#       massspecdata < massspecdata_bk.sql

echo "Upload pychrondata"

mysql -uroot \
      -p$password
      pychrondata < pychrondata_bk.sql

mysql -uroot \
      -p$password \
      -e "START SLAVE;"


mysql -uroot \
      -p$password \
      -e "SHOW SLAVE STATUS\G" > status

echo $status
