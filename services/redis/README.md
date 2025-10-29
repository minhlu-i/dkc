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
* **RedisInsight**: Advanced Redis GUI with visualization and profiling

## Access

* **Redis**: `localhost:6379` (direct connection)
* **Redis Commander**: <https://redis-commander.localhost>
* **RedisInsight**: <https://redisinsight.localhost>

## Data Persistence

Data is stored in:

* Redis data: `./data/redis/`
* RedisInsight data: `./data/redisinsight/`

## Configuration

No additional configuration needed. Both UIs will automatically connect to the Redis instance.

## Notes

* RedisInsight runs as root user to avoid permission issues with log files
* Redis Commander uses a non-root user for better security
