# Caddy Docker Proxy

Automatic reverse proxy with HTTPS for all services.

## Quick Start

```bash
# Create network (first time only)
make init

# Start Caddy
make caddy
```

## How It Works

Caddy automatically:

* Detects Docker containers with Caddy labels
* Creates reverse proxy configurations
* Provisions HTTPS certificates (self-signed for `.localhost`)
* Routes traffic based on domain names

## Configuration

No manual configuration needed! Services are auto-discovered via Docker labels.

## Troubleshooting

View Caddy logs:

```bash
make logs-caddy
```

Restart Caddy:

```bash
make down-caddy
make caddy
```
