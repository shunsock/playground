#!/bin/bash -euo pipefail

log() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') [INFO] 🚀 - $1"
}

ok() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') [OK] ✅ - $1"
}

err() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') [ERROR] 🚨 - $1"
}
