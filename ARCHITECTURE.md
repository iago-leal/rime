# ARCHITECTURE.md — rime v6 (framework, não projeto-cliente)

> Contrato técnico do **próprio framework** `rime` v6. Para projetos-cliente que adotam o framework, este arquivo é o template a ser preenchido por `bootstrap` na inicialização.

## Identificação

- **Nome**: rime v6
- **Propósito (1 frase)**: framework lean, harness-agnóstico, iterativo+incremental e test-driven para produção de software com agentes LLM, com matriz de specs anti-regressão.
- **Responsável**: @iagoleal
- **Stakeholders**: usuários do framework (engenheiros adotando para projetos-cliente).
- **Diretório raiz**: `/Users/iagoleal/dev/rime/` (repo público em `iago-leal/rime`)

## Decisões fundacionais

| # | Decisão | Resolução |
|:---:|---|---|
| D0 | Modo de execução | **B (Harness-first)** — o framework é desenhado para operar via harness (Claude Code, Antigravity, Codex). Em projetos-cliente, D0 é decisão própria. |
| D1 | Provider/harness | Claude Code (referência); Antigravity e harness genérico via adaptadores. |
| D2 | Stack do projeto-framework | Bash puro (script de sync) + markdown (skills/docs). Sem Node/Python para o framework em si. |
| D3 | Estrutura de testes do framework | Smoke test E2E em projeto-cliente fictício (ver `output/relatorio-smoke-test.md` quando rodado). |
| D4 | Scanner de segurança | N/A para o framework (markdown puro); skill `salvaguarda` cobre projetos-cliente. |

## Stack

- **Linguagem primária**: markdown (skills, docs, templates, registro).
- **Script utilitário**: Bash 4+ (sync-skills.sh, traceability-check.sh).
- **Versionamento**: Git local; remote opcional.
- **Lock file**: N/A (sem dependências de pacote).

## Estrutura de diretórios

```
rime/
├── ARCHITECTURE.md              # este arquivo
├── README.md                    # visão geral para adotantes
├── .skills/                     # FONTE DE VERDADE
│   ├── _principles.md           # 10 princípios C1–C10
│   ├── _glossary.md             # léxico mínimo
│   ├── _commands.md             # cheatsheet
│   ├── _self_check.md           # invariantes de auto-verificação
│   ├── bootstrap.md
│   ├── captura.md
│   ├── decisao.md
│   ├── execucao.md
│   ├── operacao.md
│   └── salvaguarda.md
├── .claude/skills/              # adaptador Claude Code (gerado)
├── .agents/skills/              # adaptador Antigravity (gerado)
├── .harness-generic/            # adaptador genérico (gerado)
├── traceability/
│   ├── code-spec.md             # arquivo ↔ spec
│   ├── spec-impact.md           # spec ↔ blast radius
│   ├── spec-test.md             # spec ↔ teste
│   └── changelog.md             # audit trail
├── docs/
│   ├── adr/                     # ADRs numerados
│   │   └── 0001-adoption-rime-v6.md
│   ├── templates/
│   │   ├── adr.md
│   │   └── commit.md
│   ├── threat-models/
│   ├── postmortems/
│   └── prompts/                 # prompt registry (par modelo+prompt)
├── registro/
│   ├── lista-problemas.md
│   ├── passivos.md
│   └── sessoes/
├── tests/regressao/             # MVES quando aplicável
├── .ci/
│   └── traceability-check.sh    # smoke test (≤10s)
└── bin/
    └── sync-skills.sh           # gera adaptadores
```

## Comandos canônicos do framework

- **Sincronizar adaptadores**: `bin/sync-skills.sh` (regenera `.claude/skills/`, `.agents/skills/`, `.harness-generic/`).
- **Verificar sincronia**: `bin/sync-skills.sh --check` (CI gate).
- **Smoke test da matriz**: `.ci/traceability-check.sh` (≤10s).
- **Skills**: ver `.skills/_commands.md`.

## Guardrails

- **Lean**: skills cabem em 80–150 linhas. Excesso é sinal para decompor.
- **Sem co-autoria de IA em commits** (RN-D-013 herdado).
- **Linguagem clínica não aparece na interface** do framework (preservada apenas como lente cognitiva implícita).
- **PT-BR para operação** (preferência do autor); inglês onde a literatura usa termos consagrados.

## Domínio

- **Classificação**: meta — é um framework para construir software, não software de domínio específico.
- **Regulação aplicável**: nenhuma direta. Projetos-cliente podem aplicar (`salvaguarda` cobre LGPD/HIPAA/OWASP).

## Criticidade

Interno (uso pelo autor). Adoção pública vem depois de validação em ≥3 projetos-cliente reais.

## Referências

- ADR-0001: adoção do framework.
- Sessão de design: `/Users/iagoleal/dev/_rime/output/`.
- Memória de decisões: `~/.claude/projects/-Users-iagoleal-dev--rime/memory/project_decisoes_design_rime_v6.md`.
