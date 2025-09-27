#!/bin/bash
set -euo pipefail

source script/core/logger.sh

TOOLS=(uv python task shfmt shellcheck)
for tool in "${TOOLS[@]}"; do
    ok "$tool => $($tool --version)"
done
