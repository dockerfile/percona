#!/usr/bin/env bash
mysqld_safe &
# Wait until MySQL is up
mysqladmin --silent --wait=20 ping || exit 1
mysql -e 'GRANT ALL PRIVILEGES ON *.* TO "root"@"%" WITH GRANT OPTION;'
