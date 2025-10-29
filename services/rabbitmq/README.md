# RabbitMQ

Message broker with management UI.

## Quick Start

```bash
# Start the service
make rabbitmq

# Access Management UI
https://rabbitmq.localhost
```

## Configuration

Copy `.env.example` to `.env` and customize:

```bash
cp .env.example .env
```

## Default Credentials

* Username: `rabbitmq`
* Password: `rabbitmq`

## Ports

* AMQP: `5672` (exposed to host)
* Management UI: Accessible via Caddy at <https://rabbitmq.localhost>
