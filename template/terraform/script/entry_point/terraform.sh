#!/bin/bash
set -euo pipefail

source ./script/core/logger.sh

main() {
  INPUT_ENVIRONMENT="$1"
  WORKSPACE="environments/$INPUT_ENVIRONMENT/$2"
  shift 2

  if [ "$INPUT_ENVIRONMENT" != "$SHELL_ENVIRONMENT" ]; then
    err "Shellの環境($INPUT_ENVIRONMENT) とTerraform($SHELL_ENVIRONMENT) の環境が一致していません"
    exit 1
  fi

  log "ワークスペースを特定しました: $WORKSPACE"
  cd "$WORKSPACE"

  if terraform "$@"; then
    ok "リソース操作に成功しました"
    return 0
  else
    err "リソース操作に失敗しました"
    return 1
  fi
}

main "$@"

