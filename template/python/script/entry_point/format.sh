#!/bin/bash
set -euo pipefail

source script/core/logger.sh

shfmt
nix format
uv run 
