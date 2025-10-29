# Project Structure

This document explains the organization of the DKC repository.

## Directory Layout

```
dkc/
├── services/              # All services organized by name
│   ├── caddy/            # Caddy reverse proxy
│   │   ├── docker-compose.yml
│   │   └── README.md
│   ├── postgres/         # PostgreSQL + Adminer
│   │   ├── docker-compose.yml
│   │   ├── .env.example
│   │   └── README.md
│   ├── mongo/            # MongoDB + Mongo Express
│   │   ├── docker-compose.yml
│   │   ├── .env.example
│   │   └── README.md
│   ├── redis/            # Redis + Commander + RedisInsight
│   │   ├── docker-compose.yml
│   │   └── README.md
│   ├── rabbitmq/         # RabbitMQ message broker
│   │   ├── docker-compose.yml
│   │   ├── .env.example
│   │   └── README.md
│   ├── chartdb/          # Database schema visualization
│   │   ├── docker-compose.yml
│   │   ├── .env.example
│   │   └── README.md
│   └── whoami/           # Test service
│       ├── docker-compose.yml
│       └── README.md
├── data/                 # Persistent data volumes
├── mcp/                  # MCP related configurations
├── Makefile             # Automation commands
├── README.md            # Main documentation
├── LICENSE              # MIT License
└── .gitignore           # Git ignore rules

```

## Service Structure

Each service follows this pattern:

```
services/<service-name>/
├── docker-compose.yml    # Docker Compose configuration
├── README.md            # Service-specific documentation
└── .env.example         # Environment variables template (optional)
```

## Makefile Commands

The Makefile provides convenient shortcuts:

- `make help` - Show all available commands
- `make init` - Initialize Caddy network
- `make <service>` - Start a specific service
- `make down-<service>` - Stop a specific service
- `make logs-<service>` - View logs for a service
- `make up-all` - Start all services
- `make down-all` - Stop all services
- `make clean` - Stop all and remove volumes

## Network Architecture

All services connect to two networks:

1. **caddy** (external) - Shared network for reverse proxy
2. **service-network** (internal) - Service-specific network

Example:

```
postgres <---> postgres-network <---> adminer
                                        |
                                     caddy-network
                                        |
                                      caddy
```

## Adding a New Service

1. Create directory: `services/your-service/`
2. Add `docker-compose.yml` with Caddy labels
3. Add `README.md` with service documentation
4. Add `.env.example` if needed
5. Run `make your-service` to start

The Makefile will automatically detect the new service!

## Data Persistence

- Named volumes: Managed by Docker (postgres)
- Bind mounts: Local `./data/` directory (redis, mongo)

Check each service's README for specific data storage details.
