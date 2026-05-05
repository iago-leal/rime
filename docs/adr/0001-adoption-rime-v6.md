# ADR-0001 — Adotar framework rime v6

## Status
Aceito

## Data
2026-05-05

## Autor humano
@iagoleal

## Contexto

Este projeto é o próprio framework `rime` v6. ADR-0001 é o ADR caso-base previsto pela invariante 7 da skill `bootstrap`: registra a adoção do framework e estabelece a baseline para os ADRs subsequentes (que vão pela skill `decisao`).

O framework é fusão deliberada de dois antecessores construídos pelo mesmo autor:

- `mdcu-framework` — método baseado em prática clínica (MCCP), com Spec Impact Matrix, disjuntor 2/2, F0 de incidente, prontuário longitudinal RSOP. Pontos fortes em rastreabilidade, gate humano e segurança.
- `_rime-v5` — arquitetura agentic em 4 camadas com 4 Leads (Init, Requirements, Maintenance, Evolution), modos D0 (A/B/C) e ancoragem científica explícita em literatura de 2019–2026.

A fusão foi conduzida em sessão de design de 2026-05-05, com mapeamento de evidência científica → decisões. Detalhes em `output/` do diretório de design (`/Users/iagoleal/dev/_rime/output/`).

## Alternativas consideradas

| # | Opção | Prós | Contras |
|:---:|---|---|---|
| 1 | Manter os dois frameworks separados | nenhuma migração | duplicação; nenhum dos dois cobre tudo |
| 2 | Adotar só o mdcu | rastreabilidade forte (Spec Impact); F0; disjuntor | sem lifecycle estendido (M1–M6, E1–E8); sem ancoragem científica explícita |
| 3 | Adotar só o rime-v5 | ancoragem científica forte; modos D0; lifecycle | sem matriz com blast radius; sem F0 formal; sem disjuntor formal |
| 4 | **Fundir (rime v6)** | herda Spec Impact + disjuntor + F0 do mdcu; lifecycle + modos D0 + ancoragem do rime; lean (6 skills) | esforço de fusão; iteração inicial em uso real |

## Decisão

`[P]` Adotar **opção 4 — fusão como rime v6**, com:

- 6 skills modulares (`bootstrap`, `captura`, `decisao`, `execucao`, `operacao`, `salvaguarda`) + 1 motor de matriz (`traceability/`).
- Princípios canônicos C1–C10 ancorados em literatura, derivados de revisão sistemática de 8 papers/PDFs em `input/docs/`.
- Fonte da verdade em `.skills/` (markdown universal); adaptadores por harness gerados via `bin/sync-skills.sh`.
- Linguagem clínica do mdcu **removida da interface** (preservada como lente cognitiva implícita, não imposta ao usuário).
- Pipeline runtime do rime-v5 (7 agentes em workflows) como **addon opcional** ativado por evento E1 quando houver evidência empírica de saturação.

Ver `output/esqueleto-framework.md` para detalhe estrutural; `output/principios-cientificos.md` para princípios; `output/matriz-specs.md` para matriz tripartite.

## Consequências

- **Positivas**:
  - Anti-regressão estrutural via Spec Impact Matrix com gate automático.
  - Clarificação humana antes de qualquer execução (C1) — fecha o modo de falha *task verification* de Cemri 2025.
  - Harness-agnóstico (C10) por design.
  - Lean: 6 skills curtas + arquivos canônicos centrais (DRY).

- **Negativas / custo aceito**:
  - Curva de adoção inicial — vocabulário próprio (blast radius, clarificação, contradição, F0).
  - Hook pre-commit em modo B requer Bash disponível (Windows precisa Git Bash/WSL).
  - Adaptador Codex específico ainda não validado (mitigado pelo destino genérico `.harness-generic/`).

- **Neutras / efeitos secundários**:
  - Modo C (Híbrido) gera complexidade intermediária — usuário precisa entender qual papel roda em qual canal.
  - `addon-pipeline/` gerado em D0=A/C adiciona superfície que precisa manutenção própria.

## Blast radius

Decisão de adoção do framework: **define** a matriz inicial; portanto, blast radius vazio neste ADR (caso-base). ADRs subsequentes serão referenciados em `traceability/spec-impact.md` à medida que evoluírem o framework.

## Referências

- Diretório de design: `/Users/iagoleal/dev/_rime/`
- Sessão de design: `/Users/iagoleal/dev/_rime/output/` (10 documentos POC)
- Comparativo mdcu × rime-v5: `output/comparativo-mdcu-rime-v5.md`
- Princípios canônicos: `output/principios-cientificos.md`
- Esqueleto do framework: `output/esqueleto-framework.md`
- Memória persistente das decisões: `~/.claude/projects/-Users-iagoleal-dev--rime/memory/project_decisoes_design_rime_v6.md`

## Changelog desta ADR

- 2026-05-05 — criada (status: Aceito)
