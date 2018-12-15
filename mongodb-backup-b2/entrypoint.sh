#!/bin/sh

mkdir -p /root/.config/rclone/
echo '[b2]' > /root/.config/rclone/rclone.conf
echo 'type = b2' >> /root/.config/rclone/rclone.conf
echo "account = $(cat /run/secrets/b2_account)" >> /root/.config/rclone/rclone.conf
echo "key = $(cat /run/secrets/b2_key)" >> /root/.config/rclone/rclone.conf

mkdir -p /root/backup/database/
cd /root/backup/database/
mongodump --host mongo -d paradise --username paradise --password $(cat /run/secrets/mongodb_paradise) --out .
mongodump --host mongo -d forums --username forums --password $(cat /run/secrets/mongodb_forums) --out .
tar czf paradise.tar.gz paradise
tar czf forums.tar.gz forums
rm -rf paradise
rm -rf forums
rclone copy /root/backup/database b2:52poke-backup/database
