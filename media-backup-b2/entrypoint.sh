#!/bin/sh

echo '[b2]' > /etc/rclone.conf
echo 'type = b2' >> /etc/rclone.conf
echo "account = $(cat /run/secrets/b2_account)" >> /etc/rclone.conf
echo "key = $(cat /run/secrets/b2_key)" >> /etc/rclone.conf
echo '[s3]' >> /etc/rclone.conf
echo 'type = s3' >> /etc/rclone.conf
echo 'env_auth = false' >> /etc/rclone.conf
echo "access_key_id = $(cat /run/secrets/aws_access_key)" >> /etc/rclone.conf
echo "secret_access_key = $(cat /run/secrets/aws_secret)" >> /etc/rclone.conf
echo "region = ap-northeast-1" >> /etc/rclone.conf

rclone sync --exclude wiki/thumb/** --exclude wiki/temp/** s3:media.52poke.com b2:52poke-backup/static/media
