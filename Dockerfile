FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y --no-install-recommends install \
    ca-certificates \
    zip \
    unzip \
    p7zip \
    git \
    sqlite3 \
    mariadb-server \
    mariadb-client \
    mono-complete \
    wget

# Grab the db files
#RUN wget https://sourceforge.net/projects/dolserver/files/latest/download

WORKDIR /app

# # Method to work with local files
# ARG DB_NAME="Database DoL 1.9.6r3061"
ARG BIN_NAME="DOLServer_linux_net45_Debug"

# COPY ./releases/${DB_NAME}.7z /app/
# COPY ./releases/${BIN_NAME}.zip /app/

# Dynamically get files at boot time.
RUN wget https://github.com/ahungry/docker-dol/releases/download/0.0.1/DOLServer_linux_net45_Debug.zip

# RUN p7zip -d "${DB_NAME}.7z"
RUN unzip "${BIN_NAME}.zip"

# This one seems better than the db shipped in the snapshotted release db name
# handles case sensitivity issues.
# WOW!  This is 600 MB - definitely will want to snapshot/cache this in the real release
RUN git clone https://github.com/ahungry/db-public.git
RUN cp db-public/src/scripts/config/config.example.yml db-public/src/scripts/config/config.yml
RUN cd db-public/src/scripts/bin/linux && ./concat
RUN mv db-public/src/scripts/bin/linux/public-db.sql DOL-DB-3061.sql

# Need to boot server
COPY ./mysql-to-dump.sh /app/

RUN /app/mysql-to-dump.sh

# RUN /etc/init.d/mysql start
# RUN echo create database dol | mysql
# RUN cat DOL-DB-3061.sql | mysql -b dol
# RUN mysqldump --skip-extended-insert --compact dol > dol-dump.sql

RUN git clone https://github.com/ahungry/mysql2sqlite

# This is a hardcoded name in the 7z file

# Ideally, we would translate this from mysql on the fly to ensure
# it's always the most up to date, but we could just use sqlite dump.
RUN ./mysql2sqlite/mysql2sqlite dol-dump.sql > dol.sqlite3
RUN cat dol.sqlite3 | sqlite3 dol.db

COPY ./serverconfig.xml /app/config/serverconfig.xml
COPY ./boot.sh /app/

# Launch the game server
CMD /app/boot.sh
#CMD LANG=en_US.CP1252 mono --debug --gc=sgen --server DOLServer.exe

#CMD bash
