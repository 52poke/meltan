#!/bin/bash

set -e

mkdir -p /root/backup/database/
cd /root/backup/database/

databases=`mongo --quiet --host $MONGO_HOST --username root --password $MONGO_ROOT_PASSWORD --eval "db.getMongo().getDBNames()" | grep '"' | tr -d '\[\]",' `

for db in $databases; do
  mongodump --host $MONGO_HOST -d $db --username root --password $MONGO_ROOT_PASSWORD --authenticationDatabase admin --out .
  if [ -d "$db" ]; then
    tar czf $db.tar.gz $db
    rm -rf $db
  fi
done

rclone copy /root/backup/database backup:$BACKUP_TARGET