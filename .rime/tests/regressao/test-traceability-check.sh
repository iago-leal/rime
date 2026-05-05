#!/usr/bin/env bash
# test-traceability-check.sh — regressão de .rime/ci/traceability-check.sh
#
# Cobre:
#  1. Matrizes vazias mas presentes: passa.
#  2. Spec h3 em spec-impact.md mas não em code-spec.md: falha.
#  3. Spec sem entrada em spec-test.md: warning (não fail).
#  4. Heurística h3 (não h2 — bug histórico).

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$SCRIPT_DIR/../../.."
SCRIPT="$ROOT/.rime/ci/traceability-check.sh"

PASS=0
FAIL=0
fail() { echo "  FAIL: $*" >&2; FAIL=$((FAIL+1)); }
pass() { echo "  pass: $*"; PASS=$((PASS+1)); }

setup_fixture() {
  local fixture
  fixture="$(mktemp -d -t rime-test-trace-XXXXXX)"
  ( cd "$fixture" && git init -q -b main )
  mkdir -p "$fixture/.rime/traceability" "$fixture/.rime/docs/adr" "$fixture/.rime/ci"
  cp "$SCRIPT" "$fixture/.rime/ci/traceability-check.sh"
  chmod +x "$fixture/.rime/ci/traceability-check.sh"
  for f in code-spec spec-impact spec-test changelog; do
    cat > "$fixture/.rime/traceability/$f.md" <<EOF
# $f
## Convenção
(meta-doc)
EOF
  done
  echo "$fixture"
}

# Caso 1: matrizes vazias passam
echo "1. matrizes vazias mas presentes"
F="$(setup_fixture)"
( cd "$F" && ./.rime/ci/traceability-check.sh ) >/dev/null 2>&1 \
  && pass "vazias verde" \
  || fail "vazias vermelho (esperado verde)"

# Caso 2: spec em spec-impact mas não em code-spec → fail
echo "2. spec em spec-impact ausente em code-spec → fail"
F="$(setup_fixture)"
cat >> "$F/.rime/traceability/spec-impact.md" <<'EOF'

### my-orphan-spec
- impacto em foo: 🟩
EOF
( cd "$F" && ./.rime/ci/traceability-check.sh ) >/dev/null 2>&1 \
  && fail "passou apesar de órfã (esperado fail)" \
  || pass "detectou órfã"

# Caso 3: spec sem entrada em spec-test → warning não-fatal
echo "3. spec sem teste correspondente → warning"
F="$(setup_fixture)"
cat >> "$F/.rime/traceability/spec-impact.md" <<'EOF'

### consistente
- impacto em x: 🟩
EOF
cat >> "$F/.rime/traceability/code-spec.md" <<'EOF'

### consistente
- arquivo: src/x.ts
EOF
output=$( cd "$F" && ./.rime/ci/traceability-check.sh 2>&1 || true )
exit_code=$( cd "$F" && ./.rime/ci/traceability-check.sh >/dev/null 2>&1; echo $? )
if [[ $exit_code -eq 0 ]] && echo "$output" | grep -q "WARN"; then
  pass "warning emitido sem fail"
else
  fail "esperado exit 0 + WARN; obtido exit=$exit_code, output: $output"
fi

# Caso 4: regressão da heurística — h2 não deve ser tomado como spec
echo "4. h2 (meta-doc) não deve ser tratado como spec"
F="$(setup_fixture)"
# Adiciona seção meta com h2 contendo palavra arbitrária
cat >> "$F/.rime/traceability/spec-impact.md" <<'EOF'

## Pesos
explicação...
EOF
# code-spec não menciona "Pesos" porque é meta-doc, não spec
( cd "$F" && ./.rime/ci/traceability-check.sh ) >/dev/null 2>&1 \
  && pass "h2 corretamente ignorado" \
  || fail "h2 'Pesos' tratado como spec (regressão da heurística)"

# Caso 5: regressão da heurística — h3 dentro de fence markdown não deve ser spec
echo "5. h3 dentro de fence markdown (exemplo de meta-doc) deve ser ignorado"
F="$(setup_fixture)"
cat >> "$F/.rime/traceability/spec-impact.md" <<'EOF'

## Convenção
Cada spec usa este formato:

```
### <nome-da-spec>
- impacto em foo: 🟩
```
EOF
# code-spec NÃO contém "<nome-da-spec>" — se a heurística pegar, vai falhar
( cd "$F" && ./.rime/ci/traceability-check.sh ) >/dev/null 2>&1 \
  && pass "h3 dentro de fence corretamente ignorado" \
  || fail "h3 dentro de fence markdown foi tratado como spec (regressão)"

# Cleanup
rm -rf /tmp/rime-test-trace-*

echo ""
echo "test-traceability-check: $PASS passed, $FAIL failed"
exit $FAIL
