@echo off
REM Insurance AI Agent - Setup Script for Windows
REM This script sets up the project and installs all dependencies

setlocal enabledelayedexpansion
cd /d "%~dp0"

echo.
echo ==========================================
echo  Insurance AI Agent - Setup Script
echo ==========================================
echo.

REM Color codes for output
REM Reset is not directly available in batch, we use color codes via findstr
REM Green check mark and red X
set "CHECK=[OK]"
set "ERROR=[ERROR]"

REM Check for Node.js
echo Checking for Node.js...
node --version >nul 2>&1
if !errorlevel! neq 0 (
    echo %ERROR% Node.js is not installed or not in PATH
    echo Please install Node.js 18 or higher from https://nodejs.org/
    pause
    exit /b 1
)
echo %CHECK% Node.js found: 
node --version
echo.

REM Check for npm
echo Checking for npm...
npm --version >nul 2>&1
if !errorlevel! neq 0 (
    echo %ERROR% npm is not installed
    pause
    exit /b 1
)
echo %CHECK% npm found: 
npm --version
echo.

REM Check for Docker (optional but recommended)
echo Checking for Docker...
docker --version >nul 2>&1
if !errorlevel! neq 0 (
    echo [WARNING] Docker is not installed or not in PATH
    echo Docker is required for PostgreSQL and Redis
    echo Install Docker from https://www.docker.com/products/docker-desktop
    echo.
) else (
    echo %CHECK% Docker found: 
    docker --version
    echo.
)

REM Check for .env file
echo Checking for .env configuration...
if not exist ".env" (
    echo [WARNING] .env file not found
    echo Creating .env template...
    (
        echo # Insurance AI Agent Configuration
        echo.
        echo # Claude API Key (get free credits at https://console.anthropic.com/
        echo CLAUDE_API_KEY=your_api_key_here
        echo.
        echo # Database Configuration
        echo DATABASE_URL=postgresql://postgres:postgres@localhost:5432/insurance_ai
        echo POSTGRES_USER=postgres
        echo POSTGRES_PASSWORD=postgres
        echo POSTGRES_DB=insurance_ai
        echo.
        echo # Redis Configuration
        echo REDIS_URL=redis://localhost:6379
        echo.
        echo # Server Configuration
        echo BACKEND_PORT=3001
        echo FRONTEND_PORT=3000
        echo MCP_SERVER_PORT=3002
    ) > .env
    echo %CHECK% .env file created. Please add your Claude API key.
    echo.
) else (
    echo %CHECK% .env file exists
    echo.
)

REM Install root dependencies (if package.json exists)
if exist "package.json" (
    echo Installing root dependencies...
    call npm install
    if !errorlevel! neq 0 (
        echo %ERROR% Failed to install root dependencies
        pause
        exit /b 1
    )
    echo %CHECK% Root dependencies installed
    echo.
)

REM Install backend dependencies
echo Installing backend dependencies...
if not exist "backend\node_modules" (
    cd backend
    call npm install
    if !errorlevel! neq 0 (
        echo %ERROR% Failed to install backend dependencies
        cd ..
        pause
        exit /b 1
    )
    cd ..
    echo %CHECK% Backend dependencies installed
) else (
    echo %CHECK% Backend dependencies already installed
)
echo.

REM Install MCP server dependencies
echo Installing MCP server dependencies...
if not exist "mcp-server\node_modules" (
    cd mcp-server
    call npm install
    if !errorlevel! neq 0 (
        echo %ERROR% Failed to install MCP server dependencies
        cd ..
        pause
        exit /b 1
    )
    cd ..
    echo %CHECK% MCP server dependencies installed
) else (
    echo %CHECK% MCP server dependencies already installed
)
echo.

REM Install frontend dependencies
echo Installing frontend dependencies...
if not exist "frontend\node_modules" (
    cd frontend
    call npm install
    if !errorlevel! neq 0 (
        echo %ERROR% Failed to install frontend dependencies
        cd ..
        pause
        exit /b 1
    )
    cd ..
    echo %CHECK% Frontend dependencies installed
) else (
    echo %CHECK% Frontend dependencies already installed
)
echo.

REM Setup complete
echo ==========================================
echo  Setup Complete!
echo ==========================================
echo.
echo Next steps:
echo.
echo 1. Configure your .env file with your Claude API key
echo    Edit: .env
echo    Get API key: https://console.anthropic.com/
echo.
echo 2. Start Docker services (PostgreSQL and Redis):
echo    docker-compose up -d
echo.
echo 3. Start the services:
echo    Option A - Start all services (run in separate terminals):
echo       Terminal 1 - Backend:  cd backend ^& npm run dev
echo       Terminal 2 - Frontend: cd frontend ^& npm start
echo       Terminal 3 - MCP:      cd mcp-server ^& npm run dev
echo.
echo    Option B - Use start-all.bat (if available)
echo.
echo 4. Access the application:
echo    Frontend: http://localhost:3000
echo    Backend:  http://localhost:3001
echo    MCP:      http://localhost:3002
echo.
echo ==========================================
echo.

pause
