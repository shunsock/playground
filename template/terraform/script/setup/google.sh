#!/bin/bash
set -euo pipefail

source ./script/core/logger.sh

google_login() {
  log "Google Cloudにログインが必要か確認します"
  if gcloud auth list --filter=status:ACTIVE --format="value(account)" &>/dev/null; then
    ok "Google Cloudはすでにログイン状態でした。"
    return 0
  fi

  log "Google Cloudにログインします"
  if gcloud auth login; then
    ok "Google Cloudのログインが完了しました"
  else
    err "Google Cloudのログインに失敗しました"
    exit 1
  fi
}

google_app_default_login() {
  log "Google Cloud アプリケーションデフォルトログインが必要か確認します"
  if gcloud auth application-default print-access-token &>/dev/null; then
    ok "Google Cloudアプリケーションデフォルト認証はすでに設定されていました"
    return 0
  fi

  log "Google Cloudアプリケーションデフォルト認証を設定します"
  if gcloud auth application-default login; then
    ok "Google Cloudアプリケーションデフォルト認証の設定が完了しました"
  else
    err "Google Cloudアプリケーションデフォルト認証の設定に失敗しました"
    exit 1
  fi
}


google_set_project_id() {
  log "Google Cloudのプロジェクトを設定します: $PROJECT_ID"
  if gcloud config set project "$PROJECT_ID"; then
    ok "Google Cloudのプロジェクトを設定しました: $PROJECT_ID"
  else
    err "Google Cloudのプロジェクト設定に失敗しました: $PROJECT_ID"
    exit 1
  fi
}

