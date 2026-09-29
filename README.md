# AI-Based Multilingual Chatbot for Welfare Scheme Awareness

A complete, production-grade conversational assistant designed to help rural beneficiaries in India discover welfare schemes, evaluate eligibility, review document checklists, and resolve queries across low-bandwidth channels (SMS, WhatsApp, and IVR).

---

## Folder Structure

* `backend/`: FastAPI Python server containing models, database logic, custom NLP translator, eligibility engines, RAG pipeline, and low-bandwidth payload formatters.
* `frontend/`: Vite-powered React single page application with modern glassmorphism UI, simulation components for voice, SMS interfaces, checklists, and admin panel telemetry.
* `data/`: Mock dataset containing 15 seeded welfare schemes and FAQs.
* `tests/`: End-to-end integration and load-testing configurations (Pytest + Locust).

---

## Tech Stack & Core Libraries

1. **Backend**: FastAPI, SQLAlchemy, SQLite (default, PostgreSQL compatible).
2. **AI / ML & RAG**: FAISS (in-memory L2 index), `sentence-transformers` (all-MiniLM-L6-v2), LLMs (Llama-3, Gemma via API/Groq).
3. **Frontend**: React (Vite), Lucide-React, custom dark-mode CSS styling.
4. **DevOps**: Docker, Docker-compose, Nginx.

---

## Deployment & Setup Instructions

### 1. Local Development Setup

#### Backend Setup:
```bash
# Navigate to backend directory
cd backend

# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install requirements
pip install -r requirements.txt

# Create database and build FAISS index
python -m app.seed_data

# Start FastAPI server
uvicorn app.main:app --reload --port 8000
```
API Documentation will be active at: http://localhost:8000/docs

#### Frontend Setup:
```bash
# Navigate to frontend directory
cd frontend

# Install package dependencies
npm install

# Start Vite dev server
npm run dev
```
Open browser: http://localhost:3000

---

### 2. Multi-Container Deployment via Docker Compose

Build and launch the complete stack:
```bash
# In the root directory containing docker-compose.yml
docker-compose up --build
```
* **Frontend UI**: http://localhost:3000
* **API Endpoints**: http://localhost:8000

---

### 3. Deploying to Cloud Platforms

#### Replit Setup:
1. Import this repository into Replit.
2. Select "Python" template.
3. Add environment variables under "Secrets":
   - `GROQ_API_KEY`: Groq API key for Llama 3 execution.
4. Run commands `python -m backend.app.seed_data` and start server.

#### Render Deployment:
1. Create a **Web Service** on Render connecting to your git repository.
2. For backend, set:
   - Build Command: `pip install -r backend/requirements.txt && python -m backend.app.seed_data`
   - Start Command: `uvicorn backend.app.main:app --host 0.0.0.0 --port $PORT`
3. Create a **Static Site** on Render for the frontend:
   - Build Command: `cd frontend && npm install && npm run build`
   - Publish Directory: `frontend/dist`
   - Set environment variable `VITE_BACKEND_URL` to point to your backend Render URL.

#### HuggingFace Spaces:
1. Create a new Space on HuggingFace, choose **Docker** SDK.
2. Put the `Dockerfile` and directories at the root, or deploy the backend container as the space endpoint.

---

## Testing Strategy
* **Unit & End-to-End Tests**: Run `pytest` inside the root or tests folder:
  ```bash
  pytest tests/
  ```
* **Load Performance Testing**: Run `locust` to evaluate API performance:
  ```bash
  locust -f tests/locustfile.py
  ```
  Open http://localhost:8089 to start simulating users.
