FROM ubuntu:20.04

ENV non_interactive=y

RUN apt-get update && apt-get install \
    mono \
    wget

# Grab the db files
RUN wget https://sourceforge.net/projects/dolserver/files/latest/download
