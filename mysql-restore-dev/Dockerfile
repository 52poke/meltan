FROM mysql:8.0

ENV BACKUP_TARGET 52poke-backup/database
ENV RCLONE_CONFIG_MAGEARNA_TYPE s3
ENV MYSQL_HOST mysql
ENV MYSQL_DATABASE 52poke_wiki

RUN apt-get update && apt-get install -y zip curl man-db
RUN curl https://rclone.org/install.sh | bash

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]