#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
JAVA_BIN="$ROOT_DIR/.tools/jdk-21.0.10+7/bin/java"
PID_FILE="$ROOT_DIR/logs/backend.pid"

mkdir -p "$ROOT_DIR/logs/ruoyi" "$ROOT_DIR/uploads"

if [[ -f "$PID_FILE" ]] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
  echo "Backend is already running with PID $(cat "$PID_FILE")."
  exit 0
fi

setsid bash -c "echo \$$ > '$PID_FILE'; exec '$JAVA_BIN' -jar '$ROOT_DIR/backend/ruoyi-admin/target/ruoyi-admin.jar'" \
  > "$ROOT_DIR/logs/backend-console.log" 2>&1 &
for _ in {1..20}; do
  [[ -s "$PID_FILE" ]] && break
  sleep 0.1
done
echo "Backend started with PID $(cat "$PID_FILE")."
