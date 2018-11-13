#!/bin/sh

docker rm -f $(docker ps -aq)
 
 rm -rf /usr/local/*
