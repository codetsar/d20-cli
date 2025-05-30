#!/usr/bin/env bash

DICE_VERSION="1.0.1"

validate_version() {
    if [[ "$1" != "$DICE_VERSION" ]]; then
        echo "⚠️ Версия скрипта не совпадает с библиотекой!" >&2
        return 1
    fi
}

roll_d20() {
  echo $((0x$(xxd -l1 -p /dev/urandom) % 20 + 1))
}

show_animation() {
  # Фиксированный набор безопасных чисел
  local animation_numbers=(5 12 8 15 3)
  
  for num in "${animation_numbers[@]}"; do
    echo -ne "\r🎲 $num "
    sleep 0.1
  done
  echo -ne "\r"
}

show_result() {
  local result=$1
  # Полная очистка строки перед выводом
  echo -ne "\r\033[K"
  case "$result" in
    20) echo -e "\033[1;31mCRIT! 🎯\033[0m" ;;
    1)  echo -e "\033[1;33mFAIL! 💀\033[0m" ;;
    *)  echo -e "🎲 $result" ;;
  esac
}

main() {
  local result=$(roll_d20)
  show_animation
  show_result "$result"
}
