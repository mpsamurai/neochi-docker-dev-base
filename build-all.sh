#!/usr/bin/env bash

docker-compose -f docker-compose-arm32v6-run-on-x64.yml build
docker push mpsamurai/neochi-dev-base:20190424-arm32v6

docker-compose -f docker-compose-x64.yml build
docker push mpsamurai/neochi-dev-base:20190424-x64

docker-compose -f docker-compose-raspbian-run-on-x64.yml build
docker push mpsamurai/neochi-dev-base:20190424-raspbian