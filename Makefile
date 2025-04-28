# Makefile to run docker compose for each compose file

# Find all files ending with .docker-compose.yml
COMPOSE_FILES := $(wildcard *.docker-compose.yml)
# Derive service names by removing .docker-compose.yml suffix
SERVICES := $(COMPOSE_FILES:.docker-compose.yml=)

# Declare phony targets
.PHONY: all up-all down-all $(SERVICES)

# Default target runs all services
all: up-all

# up-all depends on all service targets
up-all: $(SERVICES)

# down-all stops all services
down-all: $(addprefix down-,$(SERVICES))

# Dynamic target to start a specific service
$(SERVICES):
	@echo "Starting docker compose for service '$@'"
	docker compose -f $@.docker-compose.yml up -d

# Dynamic target to stop a specific service
down-%:
	@echo "Stopping docker compose for service '$*'"
	docker compose -f $*.docker-compose.yml down
