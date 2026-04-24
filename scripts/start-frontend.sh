#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PID_FILE="$ROOT_DIR/logs/frontend.pid"

mkdir -p "$ROOT_DIR/logs"

if [[ -f "$PID_FILE" ]] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
  echo "Frontend is already running with PID $(cat "$PID_FILE")."
  exit 0
fi

cd "$ROOT_DIR/frontend"
setsid bash -c "echo \$$ > '$PID_FILE'; exec npm run dev" \
  > "$ROOT_DIR/logs/frontend.log" 2>&1 &
echo "Frontend started with PID $(cat "$PID_FILE")."
