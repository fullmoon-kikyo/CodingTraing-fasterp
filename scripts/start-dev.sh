#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$ROOT_DIR"
echo "Starting MySQL and Redis..."
docker compose -f infra/docker-compose.yml up -d

echo "Starting backend..."
./scripts/start-backend.sh

echo "Starting frontend..."
./scripts/start-frontend.sh

echo
./scripts/status-dev.sh
echo
echo "Development environment is ready:"
echo "  Frontend: http://localhost:5173"
echo "  Backend:  http://localhost:8080"

