#!/usr/bin/env bash
# sync-skills.sh — gera adaptadores de .skills/*.md para cada harness alvo.
#
# Uso:
#   bin/sync-skills.sh             # gera/atualiza adaptadores
#   bin/sync-skills.sh --check     # apenas verifica sincronia (CI gate)
#   bin/sync-skills.sh --inline    # inlina canônicos no início de cada adaptador
#
# Compatível com Bash 3.2+ (default macOS) — sem associative arrays.

set -euo pipefail

SOURCE_DIR=".skills"
HEADER_TPL="<!-- Gerado de .skills/<NOME>.md por bin/sync-skills.sh — não editar diretamente -->"

# Arrays paralelos: TARGET_IDS[i] e TARGET_PATHS[i]
TARGET_IDS=("claude" "agents" "generic")
TARGET_PATHS=(".claude/skills" ".agents/skills" ".harness-generic")
# Para ativar Codex: TARGET_IDS+=("codex"); TARGET_PATHS+=(".codex/skills")

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

  # Skip arquivos canônicos com prefixo _ ; lidos por path relativo (ou inlinados via --inline).
  case "$skill_name" in _*) return 0 ;; esac

  local target_file
  case "$harness_id" in
    claude|agents) target_file="$target_root/$skill_name/SKILL.md" ;;
    generic|codex) target_file="$target_root/$skill_name.md" ;;
    *) echo "harness desconhecido: $harness_id" >&2; return 2 ;;
  esac

  local header="${HEADER_TPL//<NOME>/$skill_name}"
  local generated_content
  if [[ $INLINE_MODE -eq 1 ]]; then
    local canonicos
    canonicos="$(cat "$SOURCE_DIR"/_principles.md "$SOURCE_DIR"/_glossary.md "$SOURCE_DIR"/_self_check.md)"
    generated_content="$(printf '%s\n\n%s\n\n%s\n' "$header" "$canonicos" "$(cat "$skill_path")")"
  else
    generated_content="$(printf '%s\n\n%s\n' "$header" "$(cat "$skill_path")")"
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
  i=0
  while [[ $i -lt ${#TARGET_IDS[@]} ]]; do
    generate_for "$skill_path" "${TARGET_PATHS[$i]}" "${TARGET_IDS[$i]}" || EXIT=1
    i=$((i + 1))
  done
done

exit $EXIT
