#!/usr/bin/env bats

load '../lib/dice.sh'

@test "roll_d20 returns number between 1-20" {
  run roll_d20
  [ "$status" -eq 0 ]
  [[ "$output" =~ ^[0-9]+$ ]]
  [ "$output" -ge 1 ]
  [ "$output" -le 20 ]
}

@test "show_result outputs correct format" {
  run show_result 20
  [ "$status" -eq 0 ]
  [[ "$output" == *"CRIT! 🎯"* ]]
  [[ "$output" != *"FAIL!"* ]]

  run show_result 1
  [ "$status" -eq 0 ]
  [[ "$output" == *"FAIL! 💀"* ]]
  [[ "$output" != *"CRIT!"* ]]

  run show_result 10
  [ "$status" -eq 0 ]
  [[ "$output" == *"🎲 10"* ]]
  [[ "$output" != *"CRIT!"* ]]
  [[ "$output" != *"FAIL!"* ]]
}

@test "main outputs single line" {
  # Мокаем roll_d20 для предсказуемого теста
  function roll_d20 { echo 20; }
  run main
  [ "$status" -eq 0 ]
  [ "${#lines[@]}" -eq 1 ]
  [[ "${lines[0]}" == *"CRIT!"* ]]
}

@test "animation shows only predefined numbers" {
  run show_animation
  for line in "${lines[@]}"; do
    [[ "$line" == *"5"* || "$line" == *"12"* || 
       "$line" == *"8"* || "$line" == *"15"* || 
       "$line" == *"3"* ]] || return 1
  done
}

@test "result cannot be both CRIT and FAIL" {
  function roll_d20 { echo 1; }
  run main
  [[ "$output" != *"CRIT!"* ]]
  
  function roll_d20 { echo 20; }
  run main
  [[ "$output" != *"FAIL!"* ]]
}
