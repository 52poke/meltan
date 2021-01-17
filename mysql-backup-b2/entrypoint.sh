#!/bin/sh

set -e

echo '[client]' > /root/.my.cnf
echo 'user=root' >> /root/.my.cnf
echo "password=$MYSQL_ROOT_PASSWORD" >> /root/.my.cnf
echo '[mysqldump]' >> /root/.my.cnf
echo 'user=root' >> /root/.my.cnf
echo "password=$MYSQL_ROOT_PASSWORD" >> /root/.my.cnf

mkdir -p /root/backup/database/

databases=`mysql -h $MYSQL_HOST -u root -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema)"`

for db in $databases; do
  mysqldump --single-transaction -h $MYSQL_HOST -u root $MYSQLDUMP_OPT $db | gzip > /root/backup/database/$db.sql.gz
done

rclone copy /root/backup/database b2:$B2_TARGET
