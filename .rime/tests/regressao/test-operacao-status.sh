#!/usr/bin/env bash
# test-operacao-status.sh — regressão de .rime/bin/operacao-status.sh
#
# Cobre:
#  1. 5 seções na ordem correta (mesmo em fixture vazio).
#  2. Fixture vazio degrada graciosamente (exit 0, sem crash).
#  3. Última sessão é a mais recente entre múltiplas.
#  4. ADRs limitados a 5, em ordem decrescente.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$SCRIPT_DIR/../../.."
SCRIPT="$ROOT/.rime/bin/operacao-status.sh"

PASS=0
FAIL=0
fail() { echo "  FAIL: $*" >&2; FAIL=$((FAIL+1)); }
pass() { echo "  pass: $*"; PASS=$((PASS+1)); }

setup_fixture() {
  local fixture
  fixture="$(mktemp -d -t rime-test-status-XXXXXX)"
  ( cd "$fixture" && git init -q -b main )
  mkdir -p "$fixture/.rime/bin" \
           "$fixture/.rime/registro/sessoes" \
           "$fixture/.rime/docs/adr" \
           "$fixture/.rime/traceability"
  cp "$SCRIPT" "$fixture/.rime/bin/operacao-status.sh"
  chmod +x "$fixture/.rime/bin/operacao-status.sh"
  echo "$fixture"
}

# Caso 1: 5 seções na ordem correta
echo "1. 5 seções na ordem correta"
F="$(setup_fixture)"
output=$( cd "$F" && bash .rime/bin/operacao-status.sh )
expected_order=("## Última sessão" "## Problemas ativos" "## ADRs recentes" "## Drift de specs" "## Atividade git")
actual_sections=$(echo "$output" | grep '^## ' || true)
ok=true
i=0
while IFS= read -r line; do
  if [[ "$line" != "${expected_order[$i]}" ]]; then
    ok=false
    break
  fi
  i=$((i+1))
done <<< "$actual_sections"
if $ok && [[ $i -eq 5 ]]; then
  pass "5 seções nomeadas e em ordem"
else
  fail "ordem ou contagem de seções errada (i=$i): $actual_sections"
fi

# Caso 2: fixture vazio degrada graciosamente
echo "2. fixture vazio degrada graciosamente"
F="$(setup_fixture)"
( cd "$F" && bash .rime/bin/operacao-status.sh ) >/dev/null 2>&1 \
  && pass "exit 0 em fixture vazio" \
  || fail "exit não-zero em fixture vazio"

# Caso 3: última sessão é a mais recente
echo "3. última sessão é a mais recente entre múltiplas"
F="$(setup_fixture)"
echo "# Sessão antiga" > "$F/.rime/registro/sessoes/2026-01-01.md"
echo "# Sessão meio" > "$F/.rime/registro/sessoes/2026-03-15.md"
echo "# Sessão atual" > "$F/.rime/registro/sessoes/2026-05-05.md"
output=$( cd "$F" && bash .rime/bin/operacao-status.sh )
if echo "$output" | grep -q '2026-05-05.md' && ! echo "$output" | grep -q '2026-01-01.md'; then
  pass "mostra a sessão mais recente, ignora as antigas"
else
  fail "não detectou sessão mais recente"
fi

# Caso 4: ADRs limitados a 5, ordem decrescente
echo "4. ADRs limitados a 5, ordem decrescente"
F="$(setup_fixture)"
for n in 0001 0002 0003 0004 0005 0006 0007; do
  echo "# ADR-$n — Decisão $n" > "$F/.rime/docs/adr/${n}-decisao-${n}.md"
done
output=$( cd "$F" && bash .rime/bin/operacao-status.sh )
adr_lines=$(echo "$output" | grep -E '^- 00[0-9]{2}-' || true)
adr_count=$(echo "$adr_lines" | grep -c '^-' || true)
first_adr=$(echo "$adr_lines" | head -1)
last_adr=$(echo "$adr_lines" | tail -1)
if [[ $adr_count -eq 5 ]] && echo "$first_adr" | grep -q '0007' && echo "$last_adr" | grep -q '0003'; then
  pass "5 ADRs, primeiro=0007, último=0003"
else
  fail "esperado 5 ADRs (0007..0003); obtido count=$adr_count, first=$first_adr, last=$last_adr"
fi

# Cleanup
rm -rf /tmp/rime-test-status-*

echo ""
echo "test-operacao-status: $PASS passed, $FAIL failed"
exit $FAIL
