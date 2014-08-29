## Percona Server Dockerfile


This repository contains a **Dockerfile** for [Percona Server](http://www.percona.com/software/percona-server) for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/dockerfile/percona/) published to the public [Docker Hub Registry](https://registry.hub.docker.com/).


### Dependencies

* [dockerfile/ubuntu](http://dockerfile.github.io/#/ubuntu)


### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/dockerfile/percona/) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull dockerfile/percona`

   (alternatively, you can build an image from Dockerfile: `docker build -t="dockerfile/percona" github.com/dockerfile/percona`)


### Usage

#### Run `mysqld-safe`

    docker run -d --name mysql -p 3306:3306 dockerfile/percona

#### Run `mysqld-safe` with persistent data directory.

    docker run -d -p 3306:3306 -v <data-dir>:/data --name mysql dockerfile/percona

#### Run `mysql`

    docker run -it --rm --link mysql:mysql dockerfile/percona bash -c 'mysql -h $MYSQL_PORT_3306_TCP_ADDR'
