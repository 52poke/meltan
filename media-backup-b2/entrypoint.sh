#!/bin/sh

mkdir -p /root/.config/rclone/

echo '[b2]' > /root/.config/rclone/rclone.conf
echo 'type = b2' >> /root/.config/rclone/rclone.conf
echo "account = $(cat /run/secrets/b2_account)" >> /root/.config/rclone/rclone.conf
echo "key = $(cat /run/secrets/b2_key)" >> /root/.config/rclone/rclone.conf
echo '[s3]' >> /root/.config/rclone/rclone.conf
echo 'type = s3' >> /root/.config/rclone/rclone.conf
echo 'env_auth = false' >> /root/.config/rclone/rclone.conf
echo "access_key_id = $(cat /run/secrets/aws_access_key)" >> /root/.config/rclone/rclone.conf
echo "secret_access_key = $(cat /run/secrets/aws_secret)" >> /root/.config/rclone/rclone.conf
echo "region = ap-northeast-1" >> /root/.config/rclone/rclone.conf

rclone sync --exclude wiki/thumb/** --exclude wiki/temp/** --exclude webp-cache/** s3:media.52poke.com b2:52poke-backup/static/media
