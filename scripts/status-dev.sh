#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$ROOT_DIR"

print_pid_status() {
  local name="$1"
  local pid_file="$2"
  local port="$3"

  if [[ -f "$pid_file" ]] && kill -0 "$(cat "$pid_file")" 2>/dev/null; then
    echo "$name: running, PID $(cat "$pid_file"), port $port"
  elif ss -ltn "sport = :$port" | grep -q ":$port"; then
    echo "$name: running on port $port, PID file missing or stale"
  else
    echo "$name: stopped"
  fi
}

echo "Service status"
echo "--------------"
docker compose -f infra/docker-compose.yml ps
echo
print_pid_status "Backend" "$ROOT_DIR/logs/backend.pid" "8080"
print_pid_status "Frontend" "$ROOT_DIR/logs/frontend.pid" "5173"
