#
# Percona Server 5.6 Dockerfile
#
# https://github.com/dockerfile/percona
#

# Pull base image.
FROM dockerfile/ubuntu

MAINTAINER Marcus Bointon <marcus@synchromedia.co.uk>

ENV DEBIAN_FRONTEND noninteractive

# Update everything
RUN apt-get update -qq && apt-get upgrade -y -q && apt-get dist-upgrade -y -q

# Add Percona repo
RUN apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A
#RUN gpg -a --export CD2EFD2A | apt-key add -
RUN echo "deb http://repo.percona.com/apt `lsb_release -cs` main" > /etc/apt/sources.list.d/percona.list && \
    echo "deb-src http://repo.percona.com/apt `lsb_release -cs` main" >> /etc/apt/sources.list.d/percona.list
RUN apt-get update -qq

# Install Percona Server and xtrabackup
RUN apt-get install -y -qq percona-server-5.6 xtrabackup

# Clean up
RUN rm -rf /var/lib/apt/lists/*

# Set up MySQL
RUN sed -i 's/^\(bind-address\s.*\)/# \1/' /etc/mysql/my.cnf && \
  sed -i 's/^\(log_error\s.*\)/# \1/' /etc/mysql/my.cnf && \
  echo "mysqld_safe &" > /tmp/config && \
  echo "sleep 5" >> /tmp/config && \
  echo "mysql -e 'GRANT ALL PRIVILEGES ON *.* TO \"root\"@\"%\" WITH GRANT OPTION;'" >> /tmp/config && \
  bash /tmp/config && \
  rm -f /tmp/config

# Define mountable directories.
VOLUME ["/data", "/etc/mysql", "/var/lib/mysql"]

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["mysqld_safe"]

# Expose ports.
EXPOSE 3306
