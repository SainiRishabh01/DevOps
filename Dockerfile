# --- Stage 1: Scraper (Node.js + Chromium) ---
  FROM node:18.19.1-slim as scraper

  ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
  WORKDIR /app
  
  # Install Chromium & Puppeteer dependencies
  RUN apt-get update && apt-get install -y \
      chromium \
      fonts-liberation \
      --no-install-recommends && \
      rm -rf /var/lib/apt/lists/*
  
  COPY package.json ./
  RUN npm install
  COPY scrape.js ./
  
  # Use a build-time variable to pass the URL
  ARG SCRAPE_URL
  ENV SCRAPE_URL=${SCRAPE_URL}
  
  RUN node scrape.js
  
  # --- Stage 2: Python Server ---
  FROM python:3.10.13-slim
  
  WORKDIR /app
  COPY --from=scraper /app/scraped_data.json ./
  COPY server.py requirements.txt ./
  
  RUN pip install --no-cache-dir -r requirements.txt
  
  EXPOSE 5000
  CMD ["python", "server.py"]
  