FROM docker.io/library/mariadb:10.9

ENV BACKUP_TARGET 52poke-backup/database
ENV BACKUP_DATABASE 52poke_wiki
ENV RCLONE_CONFIG_BACKUP_TYPE s3
ENV TMP_MYSQL_HOST mysql
ENV TARGET_MYSQL_HOST mysql
ENV TARGET_DATABASE 52poke_wiki

RUN apt-get update && apt-get install -y zip curl man-db
RUN curl https://rclone.org/install.sh | bash

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
