#!/bin/bash
set -euo pipefail

source ./script/core/logger.sh
source ./script/setup/google.sh

log "Google SDK の準備を開始します"
google_login
google_app_default_login
google_set_project_id
echo "🎉 セットアップが完了しました"

TOOLS=(gcloud shellcheck task terraform tflint treefmt)
for tool in "${TOOLS[@]}"; do
    ok "$tool => $($tool --version)"
done

