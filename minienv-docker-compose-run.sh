#!/bin/bash

docker-compose -f ${1}  -f ${2} up --force-recreate