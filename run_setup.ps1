# Welfare Scheme Chatbot Setup and Launch Script for Windows

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host " Starting WelfareAssist Local Environment Setup " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

# 1. Virtual Environment Setup
if (-not (Test-Path "venv")) {
    Write-Host "[1/4] Creating Python Virtual Environment (venv)..." -ForegroundColor Yellow
    python -m venv venv
} else {
    Write-Host "[1/4] Virtual environment (venv) already exists." -ForegroundColor Green
}

# 2. Activate Virtual Environment
Write-Host "[2/4] Activating Virtual Environment..." -ForegroundColor Yellow
# Set execution policy to bypass if blocked
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
. .\venv\Scripts\Activate.ps1

# 3. Install Requirements
Write-Host "[3/4] Installing dependencies from requirements.txt..." -ForegroundColor Yellow
python -m pip install --upgrade pip
pip install -r backend/requirements.txt

# 4. Ingestion Pipeline - Seed SQL & Vector Database
Write-Host "[4/4] Generating FAISS Vector Index and SQL seed records..." -ForegroundColor Yellow
python -m backend.app.seed_data

# Start Server
Write-Host "==========================================================" -ForegroundColor Green
Write-Host " Setup Complete! Starting Welfare Chatbot Server... " -ForegroundColor Green
Write-Host " Open your browser at: http://127.0.0.1:8000 " -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Green
uvicorn backend.app.main:app --host 127.0.0.1 --port 8000
