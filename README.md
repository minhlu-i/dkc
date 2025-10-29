# DKC – Docker Compose Library for Developers

**A collection of ready-to-use Docker Compose services for development, making it easy to set up popular tools quickly with automatic HTTPS via Caddy Docker Proxy.**

---

## 📦 Available Services

Each service is in its own directory with documentation:

* **[Caddy](services/caddy/)** - Automatic reverse proxy with HTTPS
* **[PostgreSQL + Adminer](services/postgres/)** - SQL database with web UI
* **[MongoDB + Mongo Express](services/mongo/)** - NoSQL database with web UI
* **[Redis + Commander + RedisInsight](services/redis/)** - In-memory database with web UIs
* **[RabbitMQ](services/rabbitmq/)** - Message broker with management UI
* **[ChartDB](services/chartdb/)** - Database schema visualization
* **[Whoami](services/whoami/)** - Simple service for testing Caddy setup

---

## 🚀 Getting Started

### 1. Clone this repository

```bash
git clone https://github.com/minhlu-i/dkc.git
cd dkc
```

### 2. Create the Caddy network (REQUIRED - First Time Only)

Before running any services, create the external `caddy` network:

```bash
docker network create caddy
```

Or use the Makefile:

```bash
make init
```

### 3. Start Caddy Docker Proxy

Start the Caddy reverse proxy first:

```bash
docker compose -f caddy.docker-compose.yml up -d
```

Or use the Makefile:

```bash
make caddy
```

### 4. Start any service you need

```bash
# Using Makefile (recommended)
make postgres
make redis
make mongo

# Or using docker compose directly
docker compose -f services/postgres/docker-compose.yml up -d
docker compose -f services/redis/docker-compose.yml up -d
```

Common Makefile commands:

```bash
# Start specific service
make postgres

# Stop specific service
make down-postgres

# View logs
make logs-postgres

# Start all services
make up-all

# Stop all services
make down-all

# Show all available commands
make help
```

### 5. Access services via browser

All services are automatically accessible via HTTPS at `https://<service>.localhost`:

* **Adminer (PostgreSQL):** <https://adminer.localhost>
* **Mongo Express:** <https://mongo-express.localhost>
* **RabbitMQ Management:** <https://rabbitmq.localhost>
* **Redis Commander:** <https://redis-commander.localhost>
* **RedisInsight:** <https://redisinsight.localhost>
* **ChartDB:** <https://chartdb.localhost>
* **Whoami (test):** <https://whoami.localhost>

### 6. Stop services when done

```bash
# Stop specific service
make down-postgres

# Stop all services
make down-all

# Stop all and remove volumes
make clean
```

---

## 🔧 How It Works

### Caddy Docker Proxy

This setup uses **caddy-docker-proxy** which automatically:

* Detects Docker containers with Caddy labels
* Creates reverse proxy configurations dynamically
* Provisions HTTPS certificates (self-signed for `.localhost` domains)
* Routes traffic based on domain names

No manual configuration files needed - just add labels to your services!

### Label Format

Each service uses these labels:

```yaml
labels:
  caddy: <domain>.localhost
  caddy.reverse_proxy: "{{upstreams <port>}}"
```

---

## 🔧 Service-Specific Configuration

### PostgreSQL & Adminer

**Environment Variables** (optional `.env` file):

```bash
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_PORT=5432
```

**Login credentials for Adminer:**

* Server: `postgres`
* Username: `postgres` (or your POSTGRES_USER)
* Password: `postgres` (or your POSTGRES_PASSWORD)
* Database: Leave empty or specify your database name

### MongoDB & Mongo Express

**Environment Variables** (optional `.env` file):

```bash
MONGO_USER=localhost
MONGO_PASSWORD=localhost
```

### RabbitMQ

**Default credentials:**

* Username: `rabbitmq`
* Password: `rabbitmq`

---

## 📝 Additional Notes

### Caddy Docker Proxy Benefits

* **Auto Discovery:** Automatically detects containers via Docker socket
* **Auto HTTPS:** Self-signed certificates for `.localhost` domains
* **Zero Config:** No Caddyfile needed - everything via labels
* **Dynamic Updates:** Add/remove services without restarting Caddy

### Troubleshooting

**Browser warning "Your connection is not private" (NET::ERR_CERT_AUTHORITY_INVALID):**

This is normal for `.localhost` domains with self-signed certificates. You have 3 options:

#### Option 1: Bypass the warning (Quick)

* Click "Advanced" → "Proceed to [site].localhost (unsafe)"
* Or type `thisisunsafe` on the warning page (no input field needed)

#### Option 2: Trust Caddy CA Certificate (Recommended for WSL2/Windows)

1. Extract the Caddy root certificate:

   ```bash
   docker compose -f caddy.docker-compose.yml exec caddy cat /data/caddy/pki/authorities/local/root.crt > caddy-root.crt
   ```

2. Import to Windows Certificate Store:
   * Open file explorer: `explorer.exe .`
   * Double-click `caddy-root.crt`
   * Click "Install Certificate"
   * Select "Current User" → Next
   * Choose "Place all certificates in the following store" → Browse
   * Select "Trusted Root Certification Authorities" → OK
   * Next → Finish
   * Restart your browser

3. All `.localhost` sites will now show secure HTTPS!

#### Option 3: Trust on Linux (Ubuntu/Debian)

```bash
sudo cp caddy-root.crt /usr/local/share/ca-certificates/caddy-local.crt
sudo update-ca-certificates
```

**Caddy network not found:**

```bash
# Create the network
docker network create caddy
```

**Service not accessible via domain:**

```bash
# Check if Caddy is running
docker ps | grep caddy

# View Caddy logs
docker compose -f caddy.docker-compose.yml logs -f

# Restart Caddy to pick up new services
docker compose -f caddy.docker-compose.yml restart
```

**Port conflicts:**

```bash
# Check what's using a port
lsof -i :<port_number>

# Example: Check if port 80/443 are available
sudo lsof -i :80
sudo lsof -i :443
```

**Docker service not starting:**

```bash
# View logs
make logs-<service>

# Or with docker compose
docker compose -f services/<service>/docker-compose.yml logs -f

# Check container status
docker ps -a

# Check networks
docker network ls
docker network inspect caddy
```

### Adding New Services

1. Create service directory: `services/your-service/`

2. Add `docker-compose.yml`:

   ```yaml
   services:
     your-service:
       image: your-image
       container_name: your-service
       networks:
         - service-network
         - caddy
       labels:
         caddy: your-service.localhost
         caddy.reverse_proxy: "{{upstreams <port>}}"
       restart: unless-stopped

   networks:
     service-network:
       driver: bridge
     caddy:
       external: true
   ```

3. Add `README.md` and `.env.example` (optional)

4. Start the service - Caddy will auto-detect it!

   ```bash
   make your-service
   ```

---

## 💡 Contributions

Got a new service or a helpful tip? Feel free to submit a PR or open an issue!

---

Happy coding and enjoy your streamlined local environment! 🚀
