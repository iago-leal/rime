# rime

> Framework lean, harness-agnóstico, iterativo+incremental e test-driven para produção de software com agentes LLM, com matriz de specs anti-regressão.

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![status](https://img.shields.io/badge/status-v0.1.0-orange)](#status)

`rime` prescreve um método em 6 skills + 1 motor de matriz, executável por qualquer harness (Claude Code, Antigravity, Codex), em que toda execução é precedida por **clarificação humana** e toda mudança estrutural deixa **trilha auditável**.

Fusão de dois frameworks anteriores do mesmo autor (`mdcu` clínico-baseado + `rime` v5 agentic-arquitetural), ancorada em revisão sistemática de literatura agentic 2019–2026.

---

## Quick start (5 min)

Pré-requisitos: Bash 3.2+, Git, e um harness compatível (Claude Code, Antigravity, ou Codex via destino genérico).

```bash
# 1. Clonar
git clone https://github.com/iago-leal/rime.git meu-projeto
cd meu-projeto

# 2. Gerar adaptadores para o harness (1 vez por máquina)
./.rime/bin/sync-skills.sh

# 3. Validar sincronia (sanity check)
./.rime/bin/sync-skills.sh --check

# 4. No harness, invocar bootstrap para extrair contrato técnico do seu projeto
#    (em Claude Code: digite /bootstrap; em Antigravity: equivalente)

# 5. Seguir o fluxo padrão para cada demanda nova
#    /captura → /decisao? → /execucao → /operacao
```

Detalhe completo do fluxo em [`.rime/skills/_commands.md`](.rime/skills/_commands.md).

---

## Filosofia em 3 bullets

1. **Clarificação antes de execução** — nenhuma ação técnica acontece sem sumarização do entendimento e confirmação humana expressa. O agente que ouve a demanda nunca a executa sozinho.
2. **Matriz de specs com gate automático** — toda mudança que toca superfície marcada 🟥 exige ADR; o gate bloqueia merge sem isso.
3. **Engine downstream desacoplável** — o harness é motor trocável; o framework prescreve método universal, adaptadores específicos por harness são gerados por script.

---

## Os 10 princípios canônicos

| # | Nome |
|:---:|---|
| C1 | Clarificação antes de executar |
| C2 | Iterativo + incremental |
| C3 | Test-driven |
| C4 | Decomposição modular com papéis especializados |
| C5 | Promptware Engineering |
| C6 | Domain-aware |
| C7 | Budget como contrato (custo + latência) |
| C8 | Matriz de specs com blast radius |
| C9 | Governança e segurança auditáveis |
| C10 | Engine downstream desacoplável |

Detalhe e ancoragem científica em [.rime/skills/_principles.md](.rime/skills/_principles.md).

---

## As 6 skills

| Skill | Função |
|---|---|
| [bootstrap](.rime/skills/bootstrap.md) | Inicialização de projeto (greenfield) |
| [captura](.rime/skills/captura.md) | Captura de demanda em projeto operacional |
| [decisao](.rime/skills/decisao.md) | Decisão arquitetural (ADR + matriz) |
| [execucao](.rime/skills/execucao.md) | Delegação técnica disciplinada (test-first, gates) |
| [operacao](.rime/skills/operacao.md) | Manutenção M1–M6 + fechamento |
| [salvaguarda](.rime/skills/salvaguarda.md) | Segurança auditável + F0 + postmortem blameless |

E 1 motor (não-skill): [.rime/traceability/](.rime/traceability/) — matriz tripartite (`code-spec` × `spec-impact` × `spec-test`) + audit trail + smoke test em CI.

---

## Modos de execução (D0)

| Modo | Quem opera o loop agentic | Default para |
|---|---|---|
| **A · API-first** | GitHub Actions + bots chamando provider LLM | times com squad de DevOps; operação 24/7 |
| **B · Harness-first** | sessão local com harness comercial | solo founder, MVP, time pequeno |
| **C · Híbrido** | misto | times intermediários |

Decisão tomada na fase 2 do `bootstrap`. Default recomendado para perfil não-engenheiro: **B**.

---

## Estrutura

```
rime/
├── .rime/skills/                  # fonte de verdade — markdown universal
├── .claude/skills/           # adaptador Claude Code (gerado)
├── .agents/skills/           # adaptador Antigravity (gerado)
├── .harness-generic/         # adaptador genérico (gerado)
├── .rime/traceability/             # matriz tripartite + changelog
├── docs/{adr,templates,threat-models,postmortems,prompts}/
├── .rime/registro/{lista-problemas,passivos,sessoes/}
├── .rime/tests/regressao/
├── .rime/ci/traceability-check.sh
└── .rime/bin/sync-skills.sh
```

Detalhe em [ARCHITECTURE.md](ARCHITECTURE.md).

---

## Status

**v0.1.0** — instanciação inicial em 2026-05-05. Smoke test E2E aprovado (3/3 testes verdes em projeto-cliente fictício). Próximas iterações trazem `.rime/bin/setup`, suíte de testes do próprio framework, e mais exemplos de adoção real.

Ver [CHANGELOG quando existir; histórico em commits].

---

## Como contribuir

Ver [CONTRIBUTING.md](CONTRIBUTING.md).

---

## Licença

[MIT](LICENSE) — uso permissivo. Pode ser incorporado em projetos comerciais ou fechados sem obrigação de abrir derivados.
