# Web Scraper + Flask Server (Multi-Stage Docker)

## 🧾 Description
- Scrapes a webpage using Puppeteer (Node.js)
- Serves the data via Flask (Python)
- Lightweight, secure multi-stage Docker build

---

## 🚀 Build the Docker Image

```bash
docker build --build-arg SCRAPE_URL=https://example.com -t scraper-server .
