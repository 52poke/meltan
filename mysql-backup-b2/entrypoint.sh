#!/bin/sh

echo '[mysqldump]' > /root/.my.cnf
echo 'user=root' >> /root/.my.cnf
echo "password=$(cat /run/secrets/mysql_root)" >> /root/.my.cnf

mkdir -p /root/.config/rclone/
echo '[b2]' > /root/.config/rclone/rclone.conf
echo 'type = b2' >> /root/.config/rclone/rclone.conf
echo "account = $(cat /run/secrets/b2_account)" >> /root/.config/rclone/rclone.conf
echo "key = $(cat /run/secrets/b2_key)" >> /root/.config/rclone/rclone.conf

mkdir -p /root/backup/database/
mysqldump -h mysql -u root 52poke | gzip > /root/backup/database/52poke.sql.gz && \
mysqldump -h mysql -u root 52poke_bbs | gzip > /root/backup/database/52poke_bbs.sql.gz && \
mysqldump -h mysql -u root --ignore-table=52poke_wiki.objectcache 52poke_wiki | gzip > /root/backup/database/52poke_wiki.sql.gz && \
rclone copy /root/backup/database b2:52poke-backup/database
