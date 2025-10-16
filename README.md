# DKC – Docker Compose Library for Developers

**This folder is a collection of ready-to-use `docker-compose.yml` files, making it easy to set up popular development services quickly.**

---

## 📦 Available Services

Currently, you'll find docker-compose files for these popular services:

* **ChartDB** (`chartdb.docker-compose.yml`)
* **MongoDB** (`mongo.docker-compose.yml`)
* **PostgreSQL & Adminer** (`postgresql-adminer.docker-compose.yml`)
* **RabbitMQ** (`rabbit-mq.docker-compose.yml`)
* **Redis Stack** (`redis-stack.docker-compose.yml`)

---

## 🚀 Getting Started

1. **Clone this repository:**

   ```bash
   git clone https://github.com/minhlu-i/dkc.git
   cd dkc
   ```

2. **Spin up the service you need:**

   ```bash
   docker compose -f <filename> up -d
   ```

   *Example:*

   ```bash
   docker compose -f postgresql-adminer.docker-compose.yml up -d
   ```

3. **Stop and remove the service when done:**

   ```bash
   docker compose -f <filename> down
   ```

---

## 🌐 Access Services with Friendly Local Domains Using Caddy

Instead of accessing your services at `localhost:<port>`, use **Caddy** to access them via pretty local domains like `adminer.localhost`, `rabbit-mq.localhost`, etc.

### Option 1: Run Caddy Standalone (Recommended)

Run Caddy directly from this directory without system-wide installation:

```bash
# Start Caddy with your Caddyfile (foreground)
caddy run --config Caddyfile

# Or run in background
caddy start --config Caddyfile

# After editing Caddyfile, reload config (zero downtime)
caddy reload --config Caddyfile

# Stop Caddy
caddy stop
```

**Note:** You must specify `--config Caddyfile` when running from a custom directory. Caddy will remember this path for reload commands.

### Option 2: Install Caddy as System Service (macOS)

If you prefer running Caddy as a system service:

```bash
# Install via Homebrew
brew install caddy

# Copy Caddyfile to Caddy config directory
cp Caddyfile /opt/homebrew/etc/Caddyfile

# Start service
brew services start caddy

# Restart after config changes
brew services restart caddy
```

**Note:** With Option 2, you need to manually copy `Caddyfile` each time you update it.

### Access your services

Once Caddy is running, open your browser and navigate to:

* **Adminer (PostgreSQL):** <https://adminer.localhost>
* **RabbitMQ Management:** <https://rabbit-mq.localhost>
* **Redis Commander:** <https://redis-commander.localhost>
* **Red Insight (Redis):** <https://red-insight.localhost>
* **ChartDB:** <https://chartdb.localhost>

---

## 🔧 Service-Specific Configuration

### PostgreSQL & Adminer

**Environment Variables** (optional `.env` file):

```bash
# PostgreSQL
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_PORT=5432

# Adminer
ADMINER_PORT=8080
```

**Access Adminer:**

* **Via Caddy:** <https://adminer.localhost>
* **Direct:** <http://localhost:8080>

**Login credentials:**

* Server: `postgres` (auto-filled via ADMINER_DEFAULT_SERVER)
* Username: `postgres` (or your POSTGRES_USER)
* Password: `postgres` (or your POSTGRES_PASSWORD)
* Database: Leave empty or specify your database name

---

## 📝 Additional Notes

### Caddy Benefits

* **Auto HTTPS:** Automatically provides HTTPS certificates for local domains – no manual SSL setup required
* **Zero Downtime:** Use `caddy reload` to apply config changes without stopping
* **Simple Config:** Clean, easy-to-read Caddyfile syntax

### Troubleshooting

**Port conflicts:**

```bash
# Check what's using a port
lsof -i :<port_number>

# Example: Check PostgreSQL port
lsof -i :5432
```

**Caddy not working:**

```bash
# Validate Caddyfile syntax
caddy validate --config Caddyfile

# Format Caddyfile
caddy fmt --overwrite Caddyfile

# Check if ports 80/443 are available
sudo lsof -i :80
sudo lsof -i :443
```

**Docker service not starting:**

```bash
# View logs
docker compose -f <filename> logs -f

# Check container status
docker ps -a
```

### Adding New Services

1. Create `service-name.docker-compose.yml`
2. Add to `Caddyfile`:

   ```caddyfile
   service-name.localhost {
       tls internal
       reverse_proxy localhost:<port>
   }
   ```

3. Reload Caddy: `caddy reload --config Caddyfile`
4. Update this README

---

## 💡 Contributions

* Got a new service or a helpful tip? Feel free to submit a PR or open an issue!

---

Happy coding and enjoy your streamlined local environment! 🚀

---
