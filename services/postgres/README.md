# PostgreSQL + Adminer

PostgreSQL database with Adminer web UI for database management.

## Quick Start

```bash
# Start the service
make postgres

# Access Adminer
https://adminer.localhost
```

## Configuration

Copy `.env.example` to `.env` and customize:

```bash
cp .env.example .env
```

## Login Credentials

* Server: `postgres`
* Username: `postgres` (default)
* Password: `postgres` (default)
* Database: Leave empty or specify your database name

## Ports

* PostgreSQL: `5432` (exposed to host)
* Adminer: Accessible via Caddy at <https://adminer.localhost>
