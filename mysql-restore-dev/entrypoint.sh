#!/bin/sh

set -e

echo '[client]' > /root/.my.cnf
echo 'user=root' >> /root/.my.cnf
echo "password=$MYSQL_ROOT_PASSWORD" >> /root/.my.cnf

BACKUP_DIR=`rclone lsd magearna:$BACKUP_TARGET | awk '{print $NF}' | sort | tail -n 1`
rclone cat magearna:$BACKUP_TARGET/$BACKUP_DIR/$MYSQL_DATABASE.sql.gz | gzip -d | mysql -h $MYSQL_HOST -u root $MYSQL_DATABASE

mysql -h $MYSQL_HOST $MYSQL_DATABASE <<EOF
DROP TABLE IF EXISTS objectcache;

CREATE TABLE objectcache (
  keyname varbinary(255) NOT NULL default '' PRIMARY KEY,
  value mediumblob,
  exptime datetime
) ENGINE=InnoDB, DEFAULT CHARSET=utf8;
CREATE INDEX exptime ON objectcache (exptime);

CREATE TABLE IF NOT EXISTS revision_v2 LIKE revision;
INSERT revision_v2 SELECT * FROM revision WHERE rev_id IN (SELECT page_latest FROM page);
DROP TABLE revision;
RENAME TABLE revision_v2 TO revision;

CREATE TABLE IF NOT EXISTS text_v2 LIKE text;
INSERT text_v2 SELECT * FROM text WHERE old_id IN (SELECT rev_text_id FROM revision);
DROP TABLE text;
RENAME TABLE text_v2 TO text;
EOF