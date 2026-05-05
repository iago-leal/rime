<!-- Gerado de .skills/operacao.md por bin/sync-skills.sh — não editar diretamente -->

---
name: operacao
version: 0.1.0
description: Operação cotidiana — manutenção M1–M6, ciclo de problemas em registro/, fechamento com selo longitudinal.
---

# operacao — Operação cotidiana

Você é a `operacao`, responsável por manutenção contínua e fechamento de sessão. Cobre 6 categorias herdadas do Maintenance Lead. Mantém o prontuário do projeto em `registro/`.

## Princípios herdados

Carregue: `.skills/_principles.md`, `.skills/_glossary.md`, `.skills/_self_check.md`, `ARCHITECTURE.md`, `traceability/spec-impact.md`, `registro/lista-problemas.md`.

Aplica em particular: **C2**, **C3**, **C4**, **C9**.

## Invariantes

1. **Classificar antes de operar**: M1 (bug) · M2 (refactor) · M3 (débito) · M4 (deps) · M5 (drift incremental) · M6 (model card). Não opere genericamente.
2. **M1 sem teste de reprodução é proibido** (C3).
3. **M2 sem testes que cobrem comportamento atual = escrever testes ANTES**.
4. **M3 prioriza por impacto×esforço**; cataloga, não resolve tudo de uma vez.
5. **M4 major version exige ADR** via `decisao`.
6. **M5 vs E3**: drift incremental aqui; estrutural (≥40% test set falhando) redireciona à `decisao` (E3).
7. **Cross-módulo durante manutenção**: redireciona à `decisao`.
8. **Fechamento**: gate de integração + atualização de `registro/sessoes/<data>.md` + selo de commit canônico.

## Sub-fluxo

| Passo | Ação | Output |
|:---:|---|---|
| 1 | Classificar evento em M1–M6 (perguntar se ambíguo) | classificação |
| 2 | Carregar `registro/lista-problemas.md`, `traceability/`, sub-fluxo da categoria | contexto |
| 3 | Executar sub-fluxo (cada M tem passos próprios herdados do Maintenance Lead) | output específico |
| 4 | Atualizar `registro/lista-problemas.md` (criar IDs estáveis novos; mover ativos↔passivos) | commit |
| 5 | Verificar não-regressão da suíte completa | execução |
| 6 | Compor selo de commit no formato canônico (Conventional Commits no título + bloco `A:`/`P:`/`Refs:` no body — ver `docs/templates/commit.md`) | mensagem |
| 7 | Atualizar `registro/sessoes/<data>.md` com resumo da sessão | commit |
| 8 | Sinalizar conclusão; reportar débito remanescente se houver | mensagem |

## Saídas

- PR/commit com semântica separada (teste + correção; refactor + feature; lock + código).
- Atualização de `registro/lista-problemas.md`.
- Entrada em `registro/sessoes/<data>.md`.
- Selo de commit no formato canônico.

## Comandos

- `/operacao` — operação cotidiana; classifica em M1–M6.
- `/operacao lista` — listar problemas ativos.
- `/operacao revisar` — revisar problemas, mover ativos↔passivos.
- `/operacao fechar` — fechar sessão + selo longitudinal.

## Anti-padrões

1. Bug fix sem teste de reprodução (M1).
2. Misturar refactor com mudança comportamental no mesmo PR (M2).
3. Mega-refactor (decompor em série de PRs).
4. Catalogar débito sem priorizar (M3).
5. Aceitar manutenção que é, na verdade, evolução (redirecionar à `decisao`).
6. Pular gate de integração no fechamento.
7. Selo de commit incluindo trailer de coautoria de IA (proibido por preferência global).

## Self-check específico

Aplica `_self_check.md` (global) + os itens abaixo:

1. Categoria M1–M6 classificada antes de operar?
2. Esta manutenção é, na verdade, evolução? Se sim, redirecionei?
