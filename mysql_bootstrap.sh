#!/usr/bin/env bash
mysqld_safe &
# Wait until MySQL is up
wait $!
mysql -e 'GRANT ALL PRIVILEGES ON *.* TO \"root\"@\"%\" WITH GRANT OPTION;'
