#!/bin/bash
set -e -o pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"

for f in */test.sh; do
  echo "== Running $f"
  cd "$(dirname "$f")"
  bash "../$f"
  cd - &>/dev/null
done
