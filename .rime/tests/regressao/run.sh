#!/usr/bin/env bash
# run.sh — runner da suíte de regressão do framework rime.
#
# Uso: .rime/tests/regressao/run.sh
# Saída: exit 0 se todos os tests passam, ≠0 caso contrário.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

TESTS=(
  "test-sync-skills.sh"
  "test-traceability-check.sh"
  "test-operacao-status.sh"
)

TOTAL_FAIL=0
for t in "${TESTS[@]}"; do
  echo "=== $t ==="
  if ! bash "$SCRIPT_DIR/$t"; then
    TOTAL_FAIL=$((TOTAL_FAIL+1))
  fi
  echo ""
done

if [[ $TOTAL_FAIL -eq 0 ]]; then
  echo "✓ todos os tests passaram"
  exit 0
else
  echo "✗ $TOTAL_FAIL test(s) falharam"
  exit 1
fi
