#!/bin/bash

APP="Flask-Docker"

MAX_SIZE=50

BACKUP_DIR="$HOME/LOG_BACKUPS"

FILE_SIZE=`du -m /var/log/flask-docker-db-backup.log | tr -s '\t' ' ' | cut -d' ' -f1`

if [ $FILE_SIZE -gt $MAX_SIZE ]
then
	TIMESTAMP=`date +%F-%H%M`
	BACKUP_NAME="$APP-$TIMESTAMP"

	if [ ! -e $BACKUP_DIR ]
	then
		mkdir $BACKUP_DIR
	fi

	mv /var/log/flask-docker-db-backup.log $BACKUP_NAME
	tar -zcvf $BACKUP_DIR/$BACKUP_NAME.tgz $BACKUP_NAME
	rm -rf BACKUP_NAME
	touch /var/log/flask-docker-db-backup.log
fi  