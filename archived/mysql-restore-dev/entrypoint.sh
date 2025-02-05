#!/bin/bash

set -e

sleep 10

echo '[client]' > $HOME/.my.cnf
echo 'user=root' >> $HOME/.my.cnf
echo "password=$TMP_MYSQL_ROOT_PASSWORD" >> $HOME/.my.cnf

echo 'CREATE DATABASE tmp_52poke_wiki;' | mysql -h $TMP_MYSQL_HOST

BACKUP_DIR=`rclone lsd backup:$BACKUP_TARGET | awk '{print $NF}' | sort | tail -n 1`
rclone copy backup:$BACKUP_TARGET/$BACKUP_DIR/$BACKUP_DATABASE.sql.gz $HOME

(echo "SET SESSION SQL_LOG_BIN=0; SET SESSION FOREIGN_KEY_CHECKS = 0; SET SESSION UNIQUE_CHECKS = 0;"; gzip -dc $HOME/$BACKUP_DATABASE.sql.gz) | mysql -h $TMP_MYSQL_HOST tmp_52poke_wiki

rm $HOME/$BACKUP_DATABASE.sql.gz

mysql -h $TMP_MYSQL_HOST tmp_52poke_wiki <<EOF
SET SESSION SQL_LOG_BIN = 0;
SET SESSION FOREIGN_KEY_CHECKS = 0;
SET SESSION UNIQUE_CHECKS = 0;
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
INSERT text_v2 SELECT * FROM text WHERE old_id IN (SELECT CAST(SUBSTR(content_address, 4) AS INTEGER) AS old_id FROM content JOIN slots ON slots.slot_content_id = content.content_id JOIN revision ON revision.rev_id = slots.slot_revision_id);
DROP TABLE text;
RENAME TABLE text_v2 TO text;
EOF

mysqldump --single-transaction --add-drop-table -h $TMP_MYSQL_HOST tmp_52poke_wiki | gzip > $HOME/52poke_wiki.sql.gz

echo 'DROP DATABASE tmp_52poke_wiki;' | mysql -h $TMP_MYSQL_HOST

rm $HOME/.my.cnf
echo '[client]' > $HOME/.my.cnf
echo "user=$TARGET_MYSQL_USER" >> $HOME/.my.cnf
echo "password=$TARGET_MYSQL_PASSWORD" >> $HOME/.my.cnf

(echo "SET SESSION SQL_LOG_BIN=0; SET SESSION FOREIGN_KEY_CHECKS = 0; SET SESSION UNIQUE_CHECKS = 0;"; gzip -dc $HOME/52poke_wiki.sql.gz) | mysql -h $TARGET_MYSQL_HOST $TARGET_DATABASE
rm $HOME/52poke_wiki.sql.gz