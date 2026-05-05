#!/usr/bin/env bash
# traceability-check.sh — smoke test (≤10s) das invariantes da matriz tripartite.
#
# Roda em CI antes de merge ou via pre-commit hook em modo B.
# Falha (exit ≠0) bloqueia.
#
# Invariantes checadas:
#   1. Toda spec listada em spec-impact.md tem entrada em code-spec.md.
#   2. Toda spec listada em spec-impact.md tem ≥1 teste em spec-test.md (warning, não fail por enquanto).
#   3. Diff em curso (vs main) não toca célula 🟥 sem ADR criado/atualizado na sessão.
#   4. Toda mudança em arquivos de matriz tem entrada em changelog.md.

set -euo pipefail

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
TRACE_DIR="$ROOT/.rime/traceability"
ADR_DIR="$ROOT/.rime/docs/adr"

EXIT=0
warn() { echo "WARN: $*" >&2; }
fail() { echo "FAIL: $*" >&2; EXIT=1; }

# Pré-condições
[[ -d "$TRACE_DIR" ]] || { fail ".rime/traceability/ não existe"; exit 1; }
for f in code-spec.md spec-impact.md spec-test.md changelog.md; do
  [[ -f "$TRACE_DIR/$f" ]] || fail ".rime/traceability/$f ausente"
done
(( EXIT == 0 )) || exit $EXIT

# Convenção do framework: specs usam h3 (`### <nome>`), reservado h2 para meta-docs.
# Heurística ignora linhas dentro de fences markdown (``` ... ```) — exemplos de uso
# em meta-doc não devem ser tratados como specs reais.
extract_specs() {
  awk '
    /^```/ { in_block = !in_block; next }
    /^### / && !in_block { print $2 }
  ' "$1" | sort -u
}

specs_impact=$(extract_specs "$TRACE_DIR/spec-impact.md")

has_spec_h3() {
  awk -v target="$2" '
    /^```/ { in_block = !in_block; next }
    /^### / && !in_block { if ($2 == target) found = 1 }
    END { exit (found ? 0 : 1) }
  ' "$1"
}

# Invariante 1: specs em spec-impact.md devem aparecer em code-spec.md.
if [[ -n "$specs_impact" ]]; then
  while IFS= read -r spec; do
    [[ -z "$spec" ]] && continue
    if ! has_spec_h3 "$TRACE_DIR/code-spec.md" "$spec"; then
      fail "spec '$spec' presente em spec-impact.md mas ausente em code-spec.md"
    fi
  done <<< "$specs_impact"
fi

# Invariante 2: warning se spec sem teste correspondente.
if [[ -n "$specs_impact" ]]; then
  while IFS= read -r spec; do
    [[ -z "$spec" ]] && continue
    if ! has_spec_h3 "$TRACE_DIR/spec-test.md" "$spec"; then
      warn "spec '$spec' sem entrada em spec-test.md (subespecificação comportamental)"
    fi
  done <<< "$specs_impact"
fi

# Invariante 3: diff em curso não toca 🟥 sem ADR novo/atualizado.
# Heurística: se git diff (staged ou contra main) altera linhas com 🟥 em spec-impact.md, exigir ADR novo.
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  diff_output=$(git diff --cached "$TRACE_DIR/spec-impact.md" 2>/dev/null || true)
  if echo "$diff_output" | grep -q "🟥"; then
    # Verifica se algum ADR foi modificado/criado nesta sessão.
    adrs_changed=$(git diff --cached --name-only -- "$ADR_DIR" 2>/dev/null || true)
    if [[ -z "$adrs_changed" ]]; then
      fail "diff toca célula 🟥 em spec-impact.md sem ADR criado/atualizado nesta sessão"
    fi
  fi
fi

# Invariante 4: mudança em arquivos da matriz exige entrada em changelog.md.
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  matrix_changes=$(git diff --cached --name-only -- "$TRACE_DIR/code-spec.md" "$TRACE_DIR/spec-impact.md" "$TRACE_DIR/spec-test.md" 2>/dev/null || true)
  changelog_changes=$(git diff --cached --name-only -- "$TRACE_DIR/changelog.md" 2>/dev/null || true)
  if [[ -n "$matrix_changes" && -z "$changelog_changes" ]]; then
    fail "mudança em matriz sem entrada em .rime/traceability/changelog.md"
  fi
fi

exit $EXIT
