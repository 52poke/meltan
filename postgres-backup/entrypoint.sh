#!/bin/sh

set -e

mkdir -p /root/backup/database/

pg_dumpall -h $POSTGRES_HOST -U postgres | gzip > /root/backup/database/postgres_backup.gz

rclone copy /root/backup/database backup:$BACKUP_TARGET
