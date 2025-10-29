# MongoDB + Mongo Express

MongoDB NoSQL database with Mongo Express web UI.

## Quick Start

```bash
# Start the service
make mongo

# Access Mongo Express
https://mongo-express.localhost
```

## Configuration

Copy `.env.example` to `.env` and customize:

```bash
cp .env.example .env
```

## Default Credentials

* Username: `localhost`
* Password: `localhost`

## Ports

* MongoDB: `27017` (exposed to host)
* Mongo Express: Accessible via Caddy at <https://mongo-express.localhost>
