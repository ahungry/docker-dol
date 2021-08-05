FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y --no-install-recommends install \
    ca-certificates \
    zip \
    unzip \
    p7zip \
    git \
    sqlite3 \
    wget

# Grab the db files
#RUN wget https://sourceforge.net/projects/dolserver/files/latest/download

WORKDIR /app

ARG DB_NAME="Database DoL 1.9.6r3061.7z"
ARG BIN_NAME="DOLServer_linux_net45_Debug.zip"

COPY ./releases/${DB_NAME} /app/
COPY ./releases/${BIN_NAME} /app/

RUN p7zip -d "${DB_NAME}"
RUN unzip "${BIN_NAME}"

RUN git clone https://github.com/ahungry/mysql2sqlite
RUN ./mysql2sqlite/mysql2sqlite "${DB_NAME}" > dol.sqlite
RUN cat dol.sqlite3 | sqlite3 dol.db

CMD bash
