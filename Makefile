
SHELL := /bin/bash

CONTAINERS=traefik \
		   jenkins \
		   megabuild \
		   megawin \
		   megatex
VOLUMES=vivadomnt

.PHONY: all prune $(CONTAINERS) $(VOLUMES)

all: $(CONTAINERS)

prune:
	@echo -e "\nPruning docker images..."
	@docker image prune -f

traefik: traefik/docker-compose.yml
	@echo -e "\nBuilding traefik container..."
	@( cd traefik ; docker-compose build && docker-compose up -d )

jenkins: jenkins/Dockerfile jenkins/docker-compose.yml
	@echo -e "\nBuilding jenkins container..."
	@( cd jenkins ; docker-compose build && docker-compose up -d )

megabuild/910828.BIN:
	@echo -e "\nLinking Cloanto base ROM to megabuild..."
	ln ../dist/910828.BIN megabuild/910828.BIN

megabuild: megabuild/Dockerfile megabuild/910828.BIN
	@echo -e "\nBuilding megabuild container..."
	if [[ -n "$(FORCE)" ]]; then \
		docker build --no-cache=true -t megabuild:latest --build-arg CC65_VERSION=`date +%s` megabuild ;\
	else \
		docker build -t megabuild:latest megabuild ;\
	fi	

megawin: megawin/Dockerfile
	@echo -e "\nBuilding megawin container..."
	@docker build -t megawin:latest megawin

megatex: megatex/Dockerfile
	@echo -e "\nBuilding megatex container..."
	@docker build -t megatex:latest megatex

vivadomnt/Vivado-2019.2-installed.tar.gz:
	@echo -e "\nLinking frozen Vivado to vivadomnt..."
	ln ../dist/Vivado-2019.2-installed.tar.gz vivadomnt/Vivado-2019.2-installed.tar.gz

vivadomnt/Vivado-2022.2-installed.tar.gz:
	@echo -e "\nLinking frozen Vivado to vivadomnt..." ; \
	ln ../dist/Vivado-2022.2-installed.tar.gz vivadomnt/Vivado-2022.2-installed.tar.gz

vivadomnt_2019_2: vivadomnt/Vivado-2019.2-installed.tar.gz vivadomnt/vivado_wrapper.sh vivadomnt/vivado_unpack.sh
	@echo -e "\nBuilding vivado_2019_2 volume..."; \
	if [ $( docker volume inspect vivado_2019_2 ) ]; then \
		docker volume rm vivado_2019_2; \
	fi
	@echo -e "\nMaking wrapper scripts..."; \
	perl -pe 's/==VER==/2019.2/g' < vivadomnt/vivado_unpack.sh > vivadomnt/vivado_unpack_2019_2.sh ; \
	perl -pe 's/==VER==/2019.2/g' < vivadomnt/vivado_wrapper.sh > vivadomnt/vivado_wrapper_2019_2.sh
	docker volume create vivado_2019_2
	docker run --rm \
		-v vivado_2019_2:/opt/Xilinx \
		-v `pwd`/vivadomnt/Vivado-2019.2-installed.tar.gz:/Vivado-2019.2-installed.tar.gz \
		-v `pwd`/vivadomnt/vivado_wrapper_2019_2.sh:/vivado_wrapper.sh \
		-v `pwd`/vivadomnt/vivado_unpack_2019_2.sh:/vivado_unpack.sh \
		megabuild bash vivado_unpack.sh

vivadomnt_2022_2: vivadomnt/Vivado-2022.2-installed.tar.gz vivadomnt/vivado_wrapper.sh vivadomnt/vivado_unpack.sh
	@echo -e "\nBuilding vivado_2022_2 volume..."; \
	if [ $( docker volume inspect vivado_2022_2 ) ]; then \
		docker volume rm vivado_2022_2; \
	fi
	@echo -e "\nMaking wrapper scripts..."; \
	perl -pe 's/==VER==/2022.2/g' < vivadomnt/vivado_unpack.sh > vivadomnt/vivado_unpack_2022_2.sh ; \
	perl -pe 's/==VER==/2022.2/g' < vivadomnt/vivado_wrapper.sh > vivadomnt/vivado_wrapper_2022_2.sh
	docker volume create vivado_2022_2
	docker run --rm \
		-v vivado_2022_2:/opt/Xilinx \
		-v `pwd`/vivadomnt/Vivado-2022.2-installed.tar.gz:/Vivado-2022.2-installed.tar.gz \
		-v `pwd`/vivadomnt/vivado_wrapper_2022_2.sh:/vivado_wrapper.sh \
		-v `pwd`/vivadomnt/vivado_unpack_2022_2.sh:/vivado_unpack.sh \
		megabuild bash vivado_unpack.sh

vivadomnt_2023_2: vivadomnt/Vivado-2023.2-installed.tar.gz vivadomnt/vivado_wrapper.sh vivadomnt/vivado_unpack.sh
	@echo -e "\nBuilding vivado_2023_2 volume..."; \
	if [ $( docker volume inspect vivado_2023_2 ) ]; then \
		docker volume rm vivado_2023_2; \
	fi
	@echo -e "\nMaking wrapper scripts..."; \
	perl -pe 's/==VER==/2023.2/g' < vivadomnt/vivado_unpack.sh > vivadomnt/vivado_unpack_2023_2.sh ; \
	perl -pe 's/==VER==/2023.2/g' < vivadomnt/vivado_wrapper.sh > vivadomnt/vivado_wrapper_2023_2.sh
	docker volume create vivado_2023_2
	docker run --rm \
		-v vivado_2023_2:/opt/Xilinx \
		-v `pwd`/vivadomnt/Vivado-2023.2-installed.tar.gz:/Vivado-2023.2-installed.tar.gz \
		-v `pwd`/vivadomnt/vivado_wrapper_2023_2.sh:/vivado_wrapper.sh \
		-v `pwd`/vivadomnt/vivado_unpack_2023_2.sh:/vivado_unpack.sh \
		megabuild bash vivado_unpack.sh

