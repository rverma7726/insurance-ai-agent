@echo off
REM Insurance AI Agent - Start All Services Script
REM This script starts all required services in separate terminal windows

setlocal enabledelayedexpansion
cd /d "%~dp0"

echo.
echo ==========================================
echo  Insurance AI Agent - Starting Services
echo ==========================================
echo.

REM Check if docker-compose is running
echo Checking Docker services...
docker ps >nul 2>&1
if !errorlevel! neq 0 (
    echo [WARNING] Docker daemon is not running
    echo Please start Docker Desktop before continuing
    echo.
    pause
    exit /b 1
)

REM Check if containers are running
docker-compose ps >nul 2>&1
if !errorlevel! neq 0 (
    echo Starting Docker services (PostgreSQL and Redis)...
    call docker-compose up -d
    if !errorlevel! neq 0 (
        echo [ERROR] Failed to start Docker services
        pause
        exit /b 1
    )
    echo [OK] Docker services started
    echo Waiting for services to be ready...
    timeout /t 5 /nobreak
) else (
    echo [OK] Docker services already running
)
echo.

REM Start Backend
echo Starting Backend service...
start "Insurance AI - Backend" cmd /k "cd backend && npm run dev"
echo [OK] Backend started in new window
echo.

REM Wait a moment for backend to start
timeout /t 2 /nobreak

REM Start MCP Server
echo Starting MCP Server service...
start "Insurance AI - MCP Server" cmd /k "cd mcp-server && npm run dev"
echo [OK] MCP Server started in new window
echo.

REM Start Frontend
echo Starting Frontend service...
start "Insurance AI - Frontend" cmd /k "cd frontend && npm start"
echo [OK] Frontend started in new window
echo.

echo ==========================================
echo  All Services Started!
echo ==========================================
echo.
echo Access the application:
echo   Frontend:  http://localhost:3000
echo   Backend:   http://localhost:3001
echo   MCP:       http://localhost:3002
echo.
echo Database:   localhost:5432
echo Redis:      localhost:6379
echo.
echo To stop all services:
echo   1. Close the terminal windows
echo   2. Run: docker-compose down
echo.
echo ==========================================
echo.

REM Keep this window open
pause
