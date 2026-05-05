#!/usr/bin/env bash
# sync-skills.sh — gera adaptadores de .skills/*.md para cada harness alvo.
#
# Uso:
#   bin/sync-skills.sh             # gera/atualiza adaptadores
#   bin/sync-skills.sh --check     # apenas verifica sincronia (CI gate)
#   bin/sync-skills.sh --inline    # inlina canônicos no início de cada adaptador

set -euo pipefail

SOURCE_DIR=".skills"
HEADER="<!-- Gerado de .skills/<NOME>.md por bin/sync-skills.sh — não editar diretamente -->"

declare -A TARGETS=(
  ["claude"]=".claude/skills"
  ["agents"]=".agents/skills"
  ["generic"]=".harness-generic"
  # ["codex"]=".codex/skills"   # formalizar quando primeiro uso real validar o formato
)

CHECK_MODE=0
INLINE_MODE=0
for arg in "$@"; do
  case "$arg" in
    --check)  CHECK_MODE=1 ;;
    --inline) INLINE_MODE=1 ;;
  esac
done

generate_for() {
  local skill_path="$1"
  local target_root="$2"
  local harness_id="$3"

  local skill_name
  skill_name="$(basename "$skill_path" .md)"

  # Skip arquivos canônicos com prefixo _; eles são lidos por path relativo (ou inlinados via --inline).
  [[ "$skill_name" == _* ]] && return 0

  local target_dir="$target_root/$skill_name"
  local target_file
  case "$harness_id" in
    claude|agents) target_file="$target_dir/SKILL.md" ;;
    generic|codex) target_file="$target_root/$skill_name.md" ;;
    *) echo "harness desconhecido: $harness_id" >&2; return 2 ;;
  esac

  local generated_content
  if [[ $INLINE_MODE -eq 1 ]]; then
    local canonicos
    canonicos="$(cat "$SOURCE_DIR"/_principles.md "$SOURCE_DIR"/_glossary.md "$SOURCE_DIR"/_self_check.md)"
    generated_content="$(printf '%s\n\n%s\n\n%s\n' "${HEADER//<NOME>/$skill_name}" "$canonicos" "$(cat "$skill_path")")"
  else
    generated_content="$(printf '%s\n\n%s\n' "${HEADER//<NOME>/$skill_name}" "$(cat "$skill_path")")"
  fi

  if [[ $CHECK_MODE -eq 1 ]]; then
    if [[ ! -f "$target_file" ]] || ! diff -q <(printf '%s\n' "$generated_content") "$target_file" >/dev/null 2>&1; then
      echo "DIVERGÊNCIA: $target_file"
      return 1
    fi
  else
    mkdir -p "$(dirname "$target_file")"
    printf '%s\n' "$generated_content" > "$target_file"
    echo "gerado: $target_file"
  fi
}

EXIT=0
for skill_path in "$SOURCE_DIR"/*.md; do
  [[ -f "$skill_path" ]] || continue
  for harness_id in "${!TARGETS[@]}"; do
    generate_for "$skill_path" "${TARGETS[$harness_id]}" "$harness_id" || EXIT=1
  done
done

exit $EXIT
