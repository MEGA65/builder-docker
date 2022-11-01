
CONTAINERS=traefik \
		   jenkins \
		   megabuild \
		   megawin \
		   megatex
VOLUMES=vivadomnt

.PHONY: all $(CONTAINERS) $(VOLUMES)

all: $(CONTAINERS)

traefik: traefik/docker-compose.yml
	@echo -e "\nBuilding traefik container..."
	@( cd traefik ; docker-compose build && docker-compose up -d )

jenkins: jenkins/Dockerfile jenkins/docker-compose.yml
	@echo -e "\nBuilding jenkins container..."
	@( cd jenkins ; docker-compose build && docker-compose up -d )

megabuild: megabuild/Dockerfile
	@echo -e "\nBuilding megabuild container..."
	@docker build -t megabuild:latest megabuild

megawin: megawin/Dockerfile
	@echo -e "\nBuilding megawin container..."
	@docker build -t megawin:latest megawin

megatex: megatex/Dockerfile
	@echo -e "\nBuilding megatex container..."
	@docker build -t megatex:latest megatex

vivadomnt/Vivado-2019.2-installed.tar.gz:
	@echo -e "\nLinking frozen Vivado to vivadomnt..."
	ln ../dist/Vivado-2019.2-installed.tar.gz vivadomnt/Vivado-2019.2-installed.tar.gz

vivadomnt: vivadomnt/Vivado-2019.2-installed.tar.gz vivadomnt/vivado_wrapper.sh vivadomnt/vivado_unpack.sh
	@echo -e "\nBuilding vivado volume..."
	if [ $( docker volume inspect vivado_2019_2 ) ]; then \
		docker volume rm vivado_2019_2; \
	fi
	docker volume create vivado_2019_2
	docker run --rm \
		-v vivado_2019_2:/opt/Xilinx \
		-v `pwd`/vivadomnt/Vivado-2019.2-installed.tar.gz:/Vivado-2019.2-installed.tar.gz \
		-v `pwd`/vivadomnt/vivado_wrapper.sh:/vivado_wrapper.sh \
		-v `pwd`/vivadomnt/vivado_unpack.sh:/vivado_unpack.sh \
		megabuild bash vivado_unpack.sh

