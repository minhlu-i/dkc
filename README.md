# Docker Compose Files Repository

This repository is dedicated to storing various docker-compose.yml files used to set up different services.

## Services

Currently, we have docker-compose files for the following services:

- [RabbitMQ](rabbit-mq.docker-compose.yml)
- [PostgreSQL and PgAdmin4](postgresql-pgadmin4.docker-compose.yml)

## Usage

To use these docker-compose files, follow these steps:

1. Clone the repository
2. Navigate to the service folder you want to use
3. Run the following command:

```bash
docker-compose -f <filename> up -d
```
