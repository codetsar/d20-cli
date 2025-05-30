#!/usr/bin/env bash
for i in {1..1000}; do
  out=$(./bin/d20)
  if [[ "$out" == *"CRIT"* && "$out" == *"FAIL"* ]]; then
    echo "BUG FOUND: $out"
    exit 1
  fi
done
echo "All 1000 tests passed!"
