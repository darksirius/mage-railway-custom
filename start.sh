#!/usr/bin/env bash
set -euo pipefail

PROJECT_NAME="${PROJECT_NAME:-mage_project}"
MAGE_CODE_PATH="${MAGE_CODE_PATH:-/home/src}"
USER_CODE_PATH="${USER_CODE_PATH:-$MAGE_CODE_PATH/$PROJECT_NAME}"
PORT="${PORT:-6789}"

mkdir -p "$MAGE_CODE_PATH"
cd "$MAGE_CODE_PATH"

echo "MAGE_CODE_PATH=$MAGE_CODE_PATH"
echo "USER_CODE_PATH=$USER_CODE_PATH"
echo "PROJECT_NAME=$PROJECT_NAME"
echo "PORT=$PORT"

if [ ! -f "$USER_CODE_PATH/metadata.yaml" ]; then
  echo "No se encontró proyecto Mage. Inicializando proyecto: $PROJECT_NAME"
  mage init "$PROJECT_NAME"
fi

mkdir -p "$USER_CODE_PATH/logs"
mkdir -p "$USER_CODE_PATH/mage_data"
mkdir -p "$USER_CODE_PATH/.cache"

exec mage start "$PROJECT_NAME" --host 0.0.0.0 --port "$PORT"