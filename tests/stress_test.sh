#!/usr/bin/env bash

for i in {1..1000}; do
  output=$(./bin/d20)
  lines=$(echo "$output" | wc -l)
  
  if [ "$lines" -ne 1 ]; then
    echo "TEST FAILED: Multiple outputs detected"
    echo "Output was:"
    echo "$output"
    exit 1
  fi
  
  if [[ "$output" == *"CRIT"* && "$output" == *"FAIL"* ]]; then
    echo "TEST FAILED: Both CRIT and FAIL detected"
    echo "$output"
    exit 1
  fi
done

echo "Stress test passed! 1000 iterations with no multi-output issues"
