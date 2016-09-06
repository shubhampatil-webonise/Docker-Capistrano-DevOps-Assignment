#!/bin/bash

DATABASE="test"
APP="Flask-Docker"

MONGO_HOST="127.0.0.1"
MONGO_PORT="27017"

TIMESTAMP=`date +%F-%H%M`

BACKUP_DIR="$HOME/DB_BACKUPS"
BACKUP_NAME="$APP-$TIMESTAMP"

if [ ! -e $BACKUP_DIR ]
then
	mkdir $BACKUP_DIR
fi

mongodump -d $DATABASE
mv dump $BACKUP_NAME
tar -zcvf $BACKUP_DIR/$BACKUP_NAME.tgz $BACKUP_NAME
rm -rf $BACKUP_NAME

find $BACKUP_DIR/* -mtime +30 -delete