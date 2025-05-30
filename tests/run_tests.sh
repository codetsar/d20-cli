#!/usr/bin/env bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
TEST_FILE="${SCRIPT_DIR}/test_dice.bats"

# Устанавливаем bats если нужно
if ! command -v bats &>/dev/null; then
  echo "Установка bats..."
  git clone https://github.com/bats-core/bats-core.git
  ./bats-core/install.sh /usr/local
fi

bats "${TEST_FILE}"
