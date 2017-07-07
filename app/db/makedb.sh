#!/bin/bash

cat db.sql dump.sql > tmp.sql
mysql -u root -P 3306 -v -p < tmp.sql