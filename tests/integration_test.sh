#!/usr/bin/env bash

for i in {1..100}; do
  output=$(./bin/d20)
  lines=$(echo "$output" | wc -l)
  
  if [ "$lines" -ne 1 ]; then
    echo "FAIL: Multiple lines detected"
    echo "$output"
    exit 1
  fi
  
  if [[ "$output" == *"CRIT"* && "$output" == *"FAIL"* ]]; then
    echo "FAIL: Both CRIT and FAIL detected"
    echo "$output"
    exit 1
  fi
done

echo "SUCCESS: All tests passed"
chmod +x tests/integration_test.sh
