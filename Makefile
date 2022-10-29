
CONTAINERS=traefik \
		   jenkins \
		   megabuild \
		   megawin \
		   megatex \
		   megavivado

.PHONY: all $(CONTAINERS)

all: $(CONTAINERS)

traefik: traefik/docker-compose.yml
	@echo "Building traefik container..."
	@( cd traefik ; docker-compose build )

jenkins: jenkins/Dockerfile jenkins/docker-compose.yml
	@echo "Building jenkins container..."
	@( cd jenkins ; docker-compose build )

megabuild: megabuild/Dockerfile jenkins/docker-compose.yml
	@echo "Building megabuild container..."
	@( cd megabuild ; docker-compose build )

megawin: megabuild/Dockerfile jenkins/docker-compose.yml
	@echo "Building megawin container..."
	@( cd megawin ; docker-compose build )

megatex: megabuild/Dockerfile jenkins/docker-compose.yml
	@echo "Building megatex container..."
	@( cd megatex ; docker-compose build )

megavivado: megabuild/Dockerfile jenkins/docker-compose.yml
	@echo "Building megavivado container..."
	@if [ ! -e megavivado/Vivado-2019.2-installed.tar.gz ]; then \
		ln ../dist/Vivado-2019.2-installed.tar.gz megavivado/Vivado-2019.2-installed.tar.gz ; \
	fi
	@( cd megavivado ; docker-compose build )

