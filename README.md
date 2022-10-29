# MEGA65 Buildhost Docker Container

This repository contains all docker containers needed on MEGA65 buildhost for jenkins.

They are not yet in a docker container registry format because I currently see no need as
distributed setup is not required. If this is the case at some future point in time, the
containers should be split out.

Makefile will use `docker-compose build` to build all containers locally.

## jenkins

Custom jenkins container that allows docker access to the host system.

## traefik

Proxy for exposing Jenkins frontend.

