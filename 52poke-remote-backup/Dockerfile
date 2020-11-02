FROM debian:buster

ENV BACKUP_DB_TARGET 52poke-backup/database
ENV BACKUP_MEDIA_TARGET media.52poke.com
ENV BACKUP_NFS_TARGET 52poke-backup/nfs
ENV RCLONE_CONFIG_SOURCE_TYPE b2
ENV RCLONE_CONFIG_MEDIA_TYPE s3
ENV RCLONE_CONFIG_TARGET_TYPE s3

RUN apt-get update && apt-get install -y zip curl man-db
RUN curl https://rclone.org/install.sh | bash

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]