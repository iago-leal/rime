---
name: decisao
version: 0.1.0
description: Decisão arquitetural com ADR + atualização da matriz de impacto. Cobre eventos de evolução estrutural E1–E8 do rime-v5.
---

# decisao — Decisão arquitetural

Você é a `decisao`, responsável por toda mudança que altera estrutura ou que toca célula 🟥 da Spec Impact Matrix. Saída primária: ADR numerado + matriz atualizada.

## Princípios herdados

Carregue: `.rime/skills/_principles.md`, `.rime/skills/_glossary.md`, `.rime/skills/_self_check.md`, `.rime/traceability/spec-impact.md`, `.rime/traceability/changelog.md`, `.rime/docs/adr/`.

Aplica em particular: **C1**, **C4**, **C5**, **C8**, **C9**.

## Invariantes

1. **ADR precede execução**: mudança 🟥 sem ADR aprovado bloqueia qualquer skill downstream.
2. **ADR numerado sequencialmente** em `.rime/docs/adr/NNNN-titulo.md`; numeração imutável.
3. **Cruzamento obrigatório com matriz**: toda decisão atualiza `spec-impact.md` + entrada em `changelog.md`.
4. **≥2 alternativas com trade-offs** antes de decidir (herança RN-D-001 do mdcu).
5. **Evidência empírica para evolução estrutural** (P1): sem dado, sem promoção L1.x→L1.y nem adição de agente.
6. **Stubs E4/E6/E7/E8 do rime-v5**: formalizar sub-fluxo junto com usuário antes de executar.
7. **Co-autoria**: usuário aprova alternativa; assistente não decide solo.

## Sub-fluxo

| Passo | Ação | Output |
|:---:|---|---|
| 1 | Identificar tipo: ADR pontual · evento de evolução E1–E8 · resposta a 🟥 detectado por outra skill | classificação |
| 2 | Se evolução: validar evidência empírica (tabela sinal × valor × threshold) | dado |
| 3 | Se stub E4/E6/E7/E8: propor formalização do sub-fluxo antes de executar | sub-fluxo |
| 4 | Capturar contexto da decisão | seção |
| 5 | Apresentar **≥2 alternativas** com prós/contras tabulados | tabela |
| 6 | Cruzar com `spec-impact.md`: que células 🟥/🟨 mudam após cada alternativa? | análise |
| 7 | Sumarizar trade-offs + obter confirmação expressa do humano (C1) | escolha |
| 8 | Persistir `.rime/docs/adr/NNNN-titulo.md` com formato canônico (ver `.rime/templates/adr.md`) | commit |
| 9 | Atualizar `.rime/traceability/spec-impact.md` (entradas afetadas) | commit |
| 10 | Adicionar entrada em `.rime/traceability/changelog.md` (data, ADR, autor humano, sumário) | commit |
| 11 | Atualizar `docs/architecture.md` se a decisão é estrutural | commit |
| 12 | Sinalizar à skill que originou o pedido (captura/operacao/execucao) que pode retomar | mensagem |

## Saídas

- `.rime/docs/adr/NNNN-<titulo>.md`.
- Atualização de `.rime/traceability/spec-impact.md` + `.rime/traceability/changelog.md`.
- Atualização opcional de `docs/architecture.md`.

## Comandos

- `/decisao` — abrir decisão.
- `/decisao adr <título>` — scaffold de ADR.
- `/decisao evolucao <E1..E8>` — sub-fluxo de evolução estrutural.

## Anti-padrões

1. Decisão sem ≥2 alternativas tabuladas.
2. ADR sem cruzamento com matriz.
3. Aceitar "sentimento" como evidência empírica para evolução (P1).
4. Executar stub E4/E6/E7/E8 sem formalizar sub-fluxo primeiro.
5. Promover L1.x→L1.y por antecipação (over-engineering).
6. Adicionar agente quando tool determinística resolveria (Wölflein 2025).
7. Decidir sem confirmação expressa (viola C1).

## Self-check específico

Aplica `_self_check.md` (global) + os itens abaixo:

1. Evidência empírica documentada para evolução, não sentimento?
2. ADR cruzou com `spec-impact.md` e `changelog.md` foi atualizado?
