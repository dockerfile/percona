#!/usr/bin/env bash
mysqld_safe &
# Wait until MySQL is up
while ! mysqladmin ping; do
    sleep 1
done
mysql -e 'GRANT ALL PRIVILEGES ON *.* TO \"root\"@\"%\" WITH GRANT OPTION;'
