#!/bin/sh

set -e

mkdir -p /root/backup/database/

pg_dumpall -c -h $POSTGRES_HOST -p $POSTGRES_PORT -U postgres | gzip > /root/backup/database/postgres_backup.gz

rclone copy /root/backup/database backup:$BACKUP_TARGET
