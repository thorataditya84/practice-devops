#!/bin/bash

DB_USER=dbuser
DB_PASS=dbpass

TIME_NOW="$(date +'%Y_%m_%d_%H_%M_%S')"

BACKUP_FILE="db_backup_$TIMENOW".gz
BACKUP_DIR="/opt/db_backup_dir"

PATH_OF_BACKUP_FILE="$BACKUP_DIR/$BACKUP_FILE"
LOG_FILE="$BACKUP_DIR/"backup_log_"$(date +'%Y_%m')".txt


echo "mysqldump started at $(date +'%d-%m-%Y %H:%M:%S')" >> "$LOG_FILE"
mysqldump --user=$DB_USER --password=$DB_PASS --default-character-set=utf8 mydatabase | gzip > "$PATH_OF_BACKUP_FILE"
echo "mysqldump finished at $(date +'%d-%m-%Y %H:%M:%S')" >> "$LOG_FILE"

chown $MY_USER "$PATH_OF_BACKUP_FILE"
chown $MY_USER "$LOG_FILE"
echo "file permission changed" >> "$LOG_FILE"

find "$BACKUP_DIR" -name db_backup_* -mtime +8 -exec rm {} \;
echo "old files deleted" >> "$LOG_FILE"
