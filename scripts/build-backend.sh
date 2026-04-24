#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export JAVA_HOME="$ROOT_DIR/.tools/jdk-21.0.10+7"
export PATH="$ROOT_DIR/.tools/apache-maven-3.9.11/bin:$JAVA_HOME/bin:$PATH"

cd "$ROOT_DIR/backend"
mvn -s .mvn/settings.xml clean package -DskipTests
