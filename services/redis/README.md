# Redis + Commander + RedisInsight

Redis in-memory database with two web UIs for management.

## Quick Start

```bash
# Start the service
make redis

# Access web UIs
https://redis-commander.localhost
https://redisinsight.localhost
```

## Features

* **Redis Commander**: Lightweight web UI for Redis management
* **RedisInsight**: Advanced Redis GUI with visualization

## Ports

* Redis: `6379` (exposed to host)
* Redis Commander: Accessible via Caddy
* RedisInsight: Accessible via Caddy

## Data Persistence

Data is stored in `./data/redis/` and `./data/redisinsight/`
