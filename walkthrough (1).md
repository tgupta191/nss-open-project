# Walkthrough: AI-Based Multilingual Chatbot for Welfare Schemes

This document summarizes the codebase implemented for the AI-Based Multilingual Chatbot for Welfare Scheme Awareness. The project is fully structured, contains production-ready Python backend and React frontend code, and is ready for local/containerized launch.

---

## What Was Built

### 1. Backend Core & Database Setup
* [database.py](file:///C:/Users/Tapas/.gemini/antigravity/scratch/multilingual_welfare_chatbot/backend/app/database.py): Initializes the SQLite engine, session wrappers, and session injection dependency.
* [models.py](file:///C:/Users/Tapas/.gemini/antigravity/scratch/multilingual_welfare_chatbot/backend/app/models.py): Declares SQLAlchemy database mappings for `Users`, `Schemes`, `EligibilityRules`, `Documents`, `ChatHistory`, `Applications`, and `Feedback`.
* [schemas.py](file:///C:/Users/Tapas/.gemini/antigravity/scratch/multilingual_welfare_chatbot/backend/app/schemas.py): Implements Pydantic schemas validating user profiles, requests, responses, and citations.

### 2. Seeding & Ingestion Data Pipeline
* [schemes_dataset.json](file:///C:/Users/Tapas/.gemini/antigravity/scratch/multilingual_welfare_chatbot/data/schemes_dataset.json): Contains detailed eligibility rules, document requirements, benefits, and FAQ segments for 15 prominent Indian welfare schemes.
* [seed_data.py](file:///C:/Users/Tapas/.gemini/antigravity/scratch/multilingual_welfare_chatbot/backend/app/seed_data.py): A pipeline script that parses the schemes dataset, inserts SQL records, computes vector embeddings via SentenceTransformers, and saves a local in-memory FAISS index.

### 3. AI pipelines & Adapters
* [nlp.py](file:///C:/Users/Tapas/.gemini/antigravity/scratch/multilingual_welfare_chatbot/backend/app/nlp.py): Detects languages (English, Hindi, Hinglish code-mixed) and translates them using pattern mapping tables and LLM fallback templates.
* [eligibility.py](file:///C:/Users/Tapas/.gemini/antigravity/scratch/multilingual_welfare_chatbot/backend/app/eligibility.py): A hybrid recommendation engine that filters candidates through deterministic rules and ranks them via vector cosine similarity.
* [rag.py](file:///C:/Users/Tapas/.gemini/antigravity/scratch/multilingual_welfare_chatbot/backend/app/rag.py): Orchestrates FAISS database retrieval, compiles context blocks, queries LLMs (Groq/HuggingFace), validates outputs, and returns verified citations.
* [low_bandwidth.py](file:///C:/Users/Tapas/.gemini/antigravity/scratch/multilingual_welfare_chatbot/backend/app/low_bandwidth.py): Formats outputs for low-bandwidth environments, compressing SMS strings (160 characters), styling WhatsApp lists, and sanitizing IVR TTS prompts.

### 4. FastAPI Gateway
* [main.py](file:///C:/Users/Tapas/.gemini/antigravity/scratch/multilingual_welfare_chatbot/backend/app/main.py): Sets up CORS middlewares, logs queries, manages rate-limiting, and houses endpoints for users, eligibility calculations, chat pipelines, and admin analytics.

### 5. React Frontend SPA
* [index.css](file:///C:/Users/Tapas/.gemini/antigravity/scratch/multilingual_welfare_chatbot/frontend/src/index.css): Implements a premium glassmorphic dark-mode style theme with custom keyframe animations.
* [App.jsx](file:///C:/Users/Tapas/.gemini/antigravity/scratch/multilingual_welfare_chatbot/frontend/src/App.jsx): Main router coordinating views and user profile state.
* [Home.jsx](file:///C:/Users/Tapas/.gemini/antigravity/scratch/multilingual_welfare_chatbot/frontend/src/components/Home.jsx): Welcomes users and includes a quick-load playground containing realistic beneficiary personas (Farmer, Woman, Gig Worker).
* [EligibilityForm.jsx](file:///C:/Users/Tapas/.gemini/antigravity/scratch/multilingual_welfare_chatbot/frontend/src/components/EligibilityForm.jsx): Multi-step user profile inputs form.
* [SchemeRecommendations.jsx](file:///C:/Users/Tapas/.gemini/antigravity/scratch/multilingual_welfare_chatbot/frontend/src/components/SchemeRecommendations.jsx): Color-coded recommendations list based on eligibility status.
* [ChatInterface.jsx](file:///C:/Users/Tapas/.gemini/antigravity/scratch/multilingual_welfare_chatbot/frontend/src/components/ChatInterface.jsx): Conversational interface supporting web chat, WhatsApp views with citations, retro SMS views, and micro voice recorders.
* [DocumentChecklist.jsx](file:///C:/Users/Tapas/.gemini/antigravity/scratch/multilingual_welfare_chatbot/frontend/src/components/DocumentChecklist.jsx): Document checklist tracker with progress bars and interactive mock OCR scanning.
* [AdminDashboard.jsx](file:///C:/Users/Tapas/.gemini/antigravity/scratch/multilingual_welfare_chatbot/frontend/src/components/AdminDashboard.jsx): Metrics summary board showing telemetry, language distribution, and channels.

### 6. Deployment & Testing
* Dockerfiles ([backend](file:///C:/Users/Tapas/.gemini/antigravity/scratch/multilingual_welfare_chatbot/backend/Dockerfile), [frontend](file:///C:/Users/Tapas/.gemini/antigravity/scratch/multilingual_welfare_chatbot/frontend/Dockerfile)), [nginx.conf](file:///C:/Users/Tapas/.gemini/antigravity/scratch/multilingual_welfare_chatbot/frontend/nginx.conf), [docker-compose.yml](file:///C:/Users/Tapas/.gemini/antigravity/scratch/multilingual_welfare_chatbot/docker-compose.yml): Multi-container build setups.
* Testing suites: [test_backend.py](file:///C:/Users/Tapas/.gemini/antigravity/scratch/multilingual_welfare_chatbot/tests/test_backend.py), [test_rag.py](file:///C:/Users/Tapas/.gemini/antigravity/scratch/multilingual_welfare_chatbot/tests/test_rag.py), [locustfile.py](file:///C:/Users/Tapas/.gemini/antigravity/scratch/multilingual_welfare_chatbot/tests/locustfile.py).

---

## Verification Commands

### 1. Ingestion / Seeding
To build the FAISS indices and database table records:
```bash
cd C:\Users\Tapas\.gemini\antigravity\scratch\multilingual_welfare_chatbot
pip install -r backend/requirements.txt
python -m backend.app.seed_data
```

### 2. Running Verification Tests
Execute the pytest suite:
```bash
pytest tests/
```

### 3. Launching Application locally
```bash
# Terminal 1: Backend
cd backend && uvicorn app.main:app --reload

# Terminal 2: Frontend
cd frontend && npm run dev
```
