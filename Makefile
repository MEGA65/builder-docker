
CONTAINERS=traefik \
		   jenkins

.PHONY: all $(CONTAINERS)

all: $(CONTAINERS)

traefik: traefik/docker-compose.yml
	@echo "Building traefik container..."
	@( cd traefik ; docker-compose build )

jenkins: jenkins/Dockerfile jenkins/docker-compose.yml
	@echo "Building jenkins container..."
	@( cd jenkins ; docker-compose build )

