#!/bin/bash

echo Time to boot server, copying database into data/
[ -f /app/data/dol.db ] || cp /app/dol.db /app/data/dol.db
ls  -l /app/data
sleep 5

echo Prepare for a wave of spam for the server boot up
sleep 5
LANG=en_US.CP1252 mono --debug --gc=sgen --server DOLServer.exe
