#!/bin/bash

# DB1 = 43.231.128.56 port 12340
# DB2 = 43.231.128.56 port 12345
# STG = 103.58.100.39 port 5432

/etc/init.d/postgresql-9.3 stop

rm -rf /var/lib/pgsql/9.3/data/*

sudo -u postgres pg_basebackup -h 103.58.101.115 -p 5432 -D /var/lib/pgsql/9.3/data -U replicador -v -P

# This is for Postgresql Replication
# cp /var/lib/pgsql/9.3/recovery.conf /var/lib/pgsql/9.3/data/

/etc/init.d/postgresql-9.3 start

# if postgresql server cannot start, runs below command :
# /usr/pgsql-9.3/bin/pg_resetxlog -f /var/lib/pgsql/9.3/data
