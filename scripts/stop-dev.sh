#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$ROOT_DIR"
echo "Stopping frontend..."
./scripts/stop-frontend.sh

echo "Stopping backend..."
./scripts/stop-backend.sh

echo "Stopping MySQL and Redis..."
docker compose -f infra/docker-compose.yml down

echo "Development environment stopped."

