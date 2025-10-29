# Makefile to run docker compose for each service

# Find all service directories
SERVICE_DIRS := $(wildcard services/*)
# Extract service names from directory paths
SERVICES := $(notdir $(SERVICE_DIRS))
# Exclude caddy from dynamic services list to avoid conflict
OTHER_SERVICES := $(filter-out caddy,$(SERVICES))

# Declare phony targets
.PHONY: all help init caddy cert up-all down-all clean logs $(SERVICES) $(addprefix down-,$(SERVICES)) $(addprefix logs-,$(SERVICES))

# Default target shows help
all: help

# Help target
help:
	@echo "DKC - Docker Compose Library"
	@echo ""
	@echo "Available targets:"
	@echo "  make init          - Create caddy network (run once)"
	@echo "  make caddy         - Start Caddy reverse proxy"
	@echo "  make cert          - Extract Caddy CA certificate"
	@echo "  make up-all        - Start all services"
	@echo "  make down-all      - Stop all services"
	@echo "  make clean         - Stop all services and remove volumes"
	@echo "  make logs          - Show logs from all services"
	@echo ""
	@echo "Service-specific targets:"
	@echo "  make <service>       - Start specific service"
	@echo "  make down-<service>  - Stop specific service"
	@echo "  make logs-<service>  - Show logs for specific service"
	@echo ""
	@echo "Available services:"
	@for service in $(SERVICES); do echo "  - $$service"; done

# Initialize caddy network
init:
	@echo "Creating caddy network..."
	@docker network create caddy 2>/dev/null || echo "Network 'caddy' already exists"

# Start Caddy (explicit target with dependency)
caddy: init
	@echo "Starting Caddy reverse proxy..."
	docker compose -f services/caddy/docker-compose.yml up -d

# Extract Caddy CA certificate
cert:
	@echo "Extracting Caddy CA certificate..."
	@docker compose -f services/caddy/docker-compose.yml exec caddy cat /data/caddy/pki/authorities/local/root.crt > caddy-root.crt 2>/dev/null || \
		(echo "Error: Cannot extract certificate. Make sure Caddy is running (run 'make caddy' first)" && exit 1)
	@if [ -f caddy-root.crt ]; then \
		echo "✓ Certificate extracted to: caddy-root.crt"; \
		echo ""; \
		echo "To trust this certificate:"; \
		echo ""; \
		echo "Windows (WSL2):"; \
		echo "  1. Open: explorer.exe ."; \
		echo "  2. Double-click caddy-root.crt"; \
		echo "  3. Install Certificate → Current User"; \
		echo "  4. Place in: Trusted Root Certification Authorities"; \
		echo "  5. Restart your browser"; \
		echo ""; \
		echo "Linux (Ubuntu/Debian):"; \
		echo "  sudo cp caddy-root.crt /usr/local/share/ca-certificates/caddy-local.crt"; \
		echo "  sudo update-ca-certificates"; \
		echo ""; \
		echo "macOS:"; \
		echo "  sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain caddy-root.crt"; \
	fi

# up-all starts caddy first, then other services
up-all: caddy $(OTHER_SERVICES)

# down-all stops all services
down-all: $(addprefix down-,$(SERVICES))

# Clean: stop all and remove volumes
clean: down-all
	@echo "Removing all volumes..."
	@docker volume prune -f

# Show logs from all services
logs:
	@for service in $(SERVICES); do \
		echo "=== Logs for $$service ==="; \
		docker compose -f services/$$service/docker-compose.yml logs --tail=20; \
		echo ""; \
	done

# Dynamic target to start a specific service (excluding caddy)
$(OTHER_SERVICES):
	@echo "Starting service '$@'..."
	docker compose -f services/$@/docker-compose.yml up -d

# Dynamic target to stop a specific service
down-%:
	@echo "Stopping service '$*'..."
	docker compose -f services/$*/docker-compose.yml down

# Dynamic target to show logs for a specific service
logs-%:
	@echo "Logs for service '$*':"
	docker compose -f services/$*/docker-compose.yml logs -f
