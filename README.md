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

## megabuild

Base build container for MEGA65 repositories.

## megawin

Adds mingw support for Windows builds to megabuild, as needed by mega65-tools.

## megatex

Adds texlive for megabuild, as needed by mega65-user-guide.

## vivadomnt

A volume install using megabuild, that mounts to /opt/Xilinx
You need to use `--init -v vivado_2019_2:/opt/Xilinx` to use it together with megabuild for a core build.

