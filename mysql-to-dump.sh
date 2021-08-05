#!/bin/bash

/etc/init.d/mysql start &

echo Waiting 10s for mysql to start...
sleep 10

echo Done sleeping, proceed with db creation

echo create database dol | mysql

echo Done creating db, adding data into sql...

cat DOL-DB-3061.sql | mysql -b dol

echo Done adding data, making a usable dump file for sqlite3...

mysqldump --skip-extended-insert --compact dol > dol-dump.sql
