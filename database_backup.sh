#!/bin/bash
# dump massspecdata locks tables by default
echo -n Database password:
read -s password
echo

# mysqldump \
#   -h129.138.12.160 \
#   -uroot \
#   -p$password \
#   --master-data \
#   massspecdata > masspecdata_bk.sql
#
# #dump pychron database
# mysqldump \
#   -h129.138.12.160 \
#   -uroot \
#   -p$password \
#   --master-data \
#   --single-transaction \
#   pychrondata > pychrondata_bk.sql
