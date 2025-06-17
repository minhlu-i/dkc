# DKC – Docker Compose Library for Developers

**This folder is a collection of ready-to-use `docker-compose.yml` files, making it easy to set up popular development services quickly.**

---

## 📦 Available Services

Currently, you’ll find docker-compose files for these popular services:

* **ChartDb** (`chartdb.docker-compose.yml`)
* **MongoDB** (`mongo.docker-compose.yml`)
* **PostgreSQL & PgAdmin4** (`postgresql-pgadmin4.docker-compose.yml`)
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
   `docker compose -f mongo.docker-compose.yml up -d`

3. **Stop and remove the service when done:**

   ```bash
   docker compose -f <filename> down
   ```

---

## 🌐 Access Services with Friendly Local Domains Using Caddy

Instead of accessing your service at `localhost:<port>`, set up **Caddy** to use pretty local domains like `pgadmin.localhost`, `mongo.localhost`, etc.

### 1. Install Caddy (Homebrew for macOS)

```bash
brew install caddy
```

### 2. (Optional) Soft link your `Caddyfile` to `/opt/homebrew/etc/`

```bash
ln -sf $(pwd)/Caddyfile /opt/homebrew/etc/Caddyfile
```

### 3. Start or restart the Caddy service

```bash
brew services start caddy
# or restart if already running
brew services restart caddy
```

### 4. Access your services

Open your browser and navigate to:

* `https://pgadmin.localhost/`
* `https://mongo.localhost/`
* ... (depending on your `Caddyfile` configuration)

---

## 📝 Additional Notes

* **Caddy** will automatically provide HTTPS certificates for your local domains – no manual SSL setup required.
* Want to add a new service? Simply add its compose file to this folder and update the README if needed.
* If you run into port or domain issues, double-check your compose and Caddyfile configurations.

---

## 💡 Contributions

* Got a new service or a helpful tip? Feel free to submit a PR or open an issue!

---

Happy coding and enjoy your streamlined local environment! 🚀

---
