#!/bin/sh

DATE=`date "+%Y-%m-%dT%H_%M_%S"`

rclone sync source:52poke-backup/database target:$BACKUP_DB_TARGET/back-$DATE
rclone sync --exclude wiki/thumb/** --exclude wiki/temp/** --exclude webp-cache/** media:media.52poke.com target:$BACKUP_MEDIA_TARGET
rclone sync source:52poke-backup/nfs target:$BACKUP_NFS_TARGET
