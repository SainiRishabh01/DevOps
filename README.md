# 🕸️ Web Scraper & Content Server using Node.js + Python (Multi-Stage Docker)

This project demonstrates the **combined power of Node.js and Python**, using **Puppeteer** for headless browser automation and **Flask** for serving the scraped content over HTTP. The entire application is packaged in a **lean, multi-stage Docker container**.

---

## 🚀 Project Overview

This containerized application:

- Uses **Node.js** with **Puppeteer** and **Chromium** to scrape dynamic content from a user-provided URL.
- Extracts key information (like the `<title>` and first `<h1>`).
- Saves the output to a JSON file.
- Uses a **Python Flask** server to read and serve the scraped data via a web API.
- Is optimized using a **multi-stage Docker build** to ensure the final image is lightweight and secure.

---

## 🛠️ Technologies Used

| Purpose         | Tech Stack          |
|-----------------|---------------------|
| Web Scraping    | Node.js, Puppeteer  |
| Headless Browser| Chromium            |
| Web Server      | Python, Flask       |
| Containerization| Docker (multi-stage)|
| OS Base         | `node:18.19.1-slim`, `python:3.10.13-slim` |

---

## 🧩 Architecture

       ┌────────────┐       ┌────────────────────┐
       │  Node.js   │──────▶│ scrape.js (Puppeteer)
       └────────────┘       └─────────┬──────────┘
                                      │
                               JSON Output (scraped_data.json)
                                      │
       ┌────────────┐       ┌─────────▼──────────┐
       │  Python    │◀──────│ Flask Web Server   │
       └────────────┘       └────────────────────┘

---

## 📦 Files Included

| File                | Description                                |
|---------------------|--------------------------------------------|
| `scrape.js`         | Node.js script to scrape the target site   |
| `server.py`         | Python Flask server to serve scraped data  |
| `Dockerfile`        | Multi-stage Dockerfile                     |
| `package.json`      | Node dependencies                          |
| `requirements.txt`  | Python dependencies                        |
| `.gitignore`        | Git ignore rules                           |
| `README.md`         | Project documentation                      |

---

## 🔧 Build & Run Instructions

### 📥 1. Clone the Repository

```bash
git clone https://github.com/<your-username>/<your-repo-name>.git
cd <your-repo-name>
🛠 2. Build the Docker Image
Pass the target URL using the SCRAPE_URL build argument:

bash
Copy
Edit
docker build --build-arg SCRAPE_URL=https://example.com -t scraper-server .
▶️ 3. Run the Container
bash
Copy
Edit
docker run -p 5000:5000 scraper-server
🌐 4. Access the Web Server
Visit in browser or curl:

arduino
Copy
Edit
http://localhost:5000
You will see the scraped data returned as JSON.

⚙️ Environment Variables

Variable	Description
SCRAPE_URL	URL of the website to scrape
You can change this by setting it during docker build with --build-arg.

💡 Example Output
For a site like https://example.com, the API might return:

json
Copy
Edit
{
  "title": "Example Domain",
  "heading": "Example Domain"
}
🛡️ Security & Best Practices
Uses specific image tags (python:3.10.13-slim, node:18.19.1-slim) to avoid vulnerabilities.

Final Docker image contains only Python runtime + scraped data.

Puppeteer is configured to use the system-installed Chromium to reduce image size.