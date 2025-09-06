#!/bin/bash
set -euo pipefail

source ./script/core/logger.sh
source ./script/setup/google.sh

ASCII_ART="
        .__                                             __
  ______|  |__   __ __   ____    ______  ____    ____  |  | __
 /  ___/|  |  \ |  |  \ /    \  /  ___/ /  _ \ _/ ___\ |  |/ /
 \___ \ |   Y  \|  |  /|  | |  \\____ \ (  <_> )\  \___ |    <
/______>|___|  /|____/ |__| |__//______>\____/  \_____>|__|__\.
"
echo "$ASCII_ART"

log "Google SDK の準備を開始します"
google_login
google_app_default_login
google_set_project_id
echo "🎉 セットアップが完了しました"

TOOLS=(gcloud shellcheck task terraform tflint treefmt)
for tool in "${TOOLS[@]}"; do
    ok "$tool => $($tool --version)"
done

