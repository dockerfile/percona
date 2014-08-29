#
# Percona Server 5.6 Dockerfile
#
# https://github.com/dockerfile/percona
#

# Pull base image.
FROM dockerfile/ubuntu

ADD mysql_bootstrap.sh /tmp/mysql_bootstrap.sh

RUN apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A && \
    echo "deb http://repo.percona.com/apt `lsb_release -cs` main" > /etc/apt/sources.list.d/percona.list && \
    echo "deb-src http://repo.percona.com/apt `lsb_release -cs` main" >> /etc/apt/sources.list.d/percona.list && \
    apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y -qq percona-server-5.6 && \
    rm -rf /var/lib/apt/lists/* && \
    sed -i 's/^\(bind-address\s.*\)/# \1/' /etc/mysql/my.cnf && \
    sed -i 's/^\(log_error\s.*\)/# \1/' /etc/mysql/my.cnf && \
    bash /tmp/mysql_bootstrap.sh && \
    rm -f /tmp/mysql_bootstrap.sh

# Define mountable directories.
VOLUME ["/data", "/etc/mysql", "/var/lib/mysql"]

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["mysqld_safe"]

# Expose ports.
EXPOSE 3306
