#!/usr/bin/env bash
# operacao-status.sh — foto consolidada do projeto para re-orientação após pausa.
#
# Imprime 5 seções fixas em ordem:
#   1. Última sessão (de .rime/registro/sessoes/)
#   2. Problemas ativos (de .rime/registro/lista-problemas.md)
#   3. ADRs recentes (até 5 mais recentes, ordem decrescente)
#   4. Drift de specs (últimas 3 entradas de .rime/traceability/changelog.md)
#   5. Atividade git (últimos 10 commits)
#
# Operação somente leitura. Degrada graciosamente quando fontes estão ausentes.
# Compatível com Bash 3.2 (macOS).

set -u

ROOT="${RIME_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null || pwd)}"
SESSOES_DIR="$ROOT/.rime/registro/sessoes"
LISTA="$ROOT/.rime/registro/lista-problemas.md"
ADR_DIR="$ROOT/.rime/docs/adr"
CHANGELOG="$ROOT/.rime/traceability/changelog.md"

PLACEHOLDER="—"

echo "# Status do projeto"
echo ""

# 1. Última sessão
echo "## Última sessão"
echo ""
if [[ -d "$SESSOES_DIR" ]]; then
  latest=$(ls -1 "$SESSOES_DIR" 2>/dev/null | grep '\.md$' | sort -r | head -1 || true)
  if [[ -n "${latest:-}" ]]; then
    echo "- arquivo: \`.rime/registro/sessoes/$latest\`"
    echo ""
    head -10 "$SESSOES_DIR/$latest"
  else
    echo "$PLACEHOLDER (nenhuma sessão fechada; rode \`/operacao fechar\` ao final do trabalho)"
  fi
else
  echo "$PLACEHOLDER (diretório \`.rime/registro/sessoes/\` ausente)"
fi
echo ""

# 2. Problemas ativos
echo "## Problemas ativos"
echo ""
if [[ -f "$LISTA" ]]; then
  ativos=$(grep -E '^## #[0-9]+' "$LISTA" 2>/dev/null || true)
  if [[ -n "$ativos" ]]; then
    echo "$ativos"
  else
    echo "$PLACEHOLDER (nenhum problema ativo registrado)"
  fi
else
  echo "$PLACEHOLDER (\`lista-problemas.md\` ausente)"
fi
echo ""

# 3. ADRs recentes (até 5, ordem decrescente)
echo "## ADRs recentes"
echo ""
if [[ -d "$ADR_DIR" ]]; then
  recentes=$(ls -1 "$ADR_DIR" 2>/dev/null | grep -E '^[0-9]{4}-.*\.md$' | sort -r | head -5 || true)
  if [[ -n "$recentes" ]]; then
    while IFS= read -r adr; do
      title=$(head -1 "$ADR_DIR/$adr" | sed 's/^# *//')
      echo "- $adr — $title"
    done <<< "$recentes"
  else
    echo "$PLACEHOLDER (nenhum ADR em \`.rime/docs/adr/\`)"
  fi
else
  echo "$PLACEHOLDER (diretório \`.rime/docs/adr/\` ausente)"
fi
echo ""

# 4. Drift de specs (últimas 3 entradas do changelog, mais recente primeiro)
echo "## Drift de specs"
echo ""
if [[ -f "$CHANGELOG" ]]; then
  recent=$(awk '
    /^## [0-9]{4}-[0-9]{2}-[0-9]{2}/ { lines[NR] = $0; last = NR }
    END {
      count = 0
      for (i = last; i >= 1 && count < 3; i--) {
        if (lines[i] != "") {
          print "- " substr(lines[i], 4)
          count++
        }
      }
    }
  ' "$CHANGELOG")
  if [[ -n "$recent" ]]; then
    echo "$recent"
  else
    echo "$PLACEHOLDER (changelog sem entradas datadas)"
  fi
else
  echo "$PLACEHOLDER (\`changelog.md\` ausente)"
fi
echo ""

# 5. Atividade git (últimos 10 commits)
echo "## Atividade git"
echo ""
if git -C "$ROOT" rev-parse --git-dir >/dev/null 2>&1; then
  log=$(git -C "$ROOT" log --oneline -10 2>/dev/null || true)
  if [[ -n "$log" ]]; then
    echo '```'
    echo "$log"
    echo '```'
  else
    echo "$PLACEHOLDER (repo sem commits)"
  fi
else
  echo "$PLACEHOLDER (\`$ROOT\` não é repo git)"
fi
