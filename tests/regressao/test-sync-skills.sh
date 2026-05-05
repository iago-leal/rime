#!/usr/bin/env bash
# test-sync-skills.sh — regressão de bin/sync-skills.sh
#
# Cobre:
#  1. Geração funciona em fixture mínimo (compat Bash 3.2 — bug histórico).
#  2. --check passa logo após geração.
#  3. --check falha quando adaptador é editado manualmente (drift detecção).
#  4. --inline produz arquivo maior contendo conteúdo dos canônicos.
#  5. Arquivos canônicos `_*.md` NÃO viram adaptador.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$SCRIPT_DIR/../.."
SCRIPT="$ROOT/bin/sync-skills.sh"

PASS=0
FAIL=0
fail() { echo "  FAIL: $*" >&2; FAIL=$((FAIL+1)); }
pass() { echo "  pass: $*"; PASS=$((PASS+1)); }

setup_fixture() {
  local fixture
  fixture="$(mktemp -d -t rime-test-sync-XXXXXX)"
  mkdir -p "$fixture/.skills"
  cp "$ROOT/.skills/_principles.md" "$fixture/.skills/_principles.md"
  cp "$ROOT/.skills/_glossary.md" "$fixture/.skills/_glossary.md"
  cp "$ROOT/.skills/_self_check.md" "$fixture/.skills/_self_check.md"
  cp "$ROOT/.skills/captura.md" "$fixture/.skills/captura.md"
  cp "$SCRIPT" "$fixture/sync-skills.sh"
  chmod +x "$fixture/sync-skills.sh"
  echo "$fixture"
}

# Caso 1: geração em fixture mínimo
echo "1. geração em fixture mínimo"
F="$(setup_fixture)"
( cd "$F" && SOURCE_DIR=.skills ./sync-skills.sh ) >/dev/null 2>&1 \
  && pass "geração ok" \
  || fail "geração falhou (regressão de Bash 3.2 compat?)"

# Caso 2: --check passa logo após geração
echo "2. --check após geração"
( cd "$F" && ./sync-skills.sh --check ) >/dev/null 2>&1 \
  && pass "--check verde" \
  || fail "--check vermelho logo após geração (esperado verde)"

# Caso 3: --check falha em drift
echo "3. --check detecta drift manual"
echo "edição manual" >> "$F/.claude/skills/captura/SKILL.md"
( cd "$F" && ./sync-skills.sh --check ) >/dev/null 2>&1 \
  && fail "--check verde apesar de drift (esperado vermelho)" \
  || pass "--check detectou drift"

# Caso 4: --inline inclui canônicos
echo "4. --inline inclui canônicos"
F2="$(setup_fixture)"
( cd "$F2" && ./sync-skills.sh --inline ) >/dev/null 2>&1
size_inline=$(wc -c < "$F2/.harness-generic/captura.md")
size_normal=$(wc -c < "$F/.harness-generic/captura.md")
if [[ $size_inline -gt $size_normal ]]; then
  pass "--inline produz arquivo maior ($size_inline > $size_normal)"
else
  fail "--inline não aumentou tamanho ($size_inline ≤ $size_normal)"
fi

# Caso 5: canônicos não viram adaptador
echo "5. canônicos _*.md não viram adaptador"
if [[ ! -f "$F/.claude/skills/_principles/SKILL.md" && ! -f "$F/.claude/skills/_glossary/SKILL.md" ]]; then
  pass "canônicos preservados em .skills/"
else
  fail "canônico virou adaptador (esperado: ignorar prefix _)"
fi

# Cleanup
rm -rf "$F" "$F2"

echo ""
echo "test-sync-skills: $PASS passed, $FAIL failed"
exit $FAIL
