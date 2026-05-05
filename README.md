# rime v6

Framework lean, harness-agnóstico, iterativo+incremental e test-driven para produção de software com agentes LLM, com matriz de specs anti-regressão.

Fusão deliberada de dois frameworks anteriores do mesmo autor (`mdcu-framework` + `_rime-v5`), ancorada em revisão sistemática de literatura agentic 2019–2026.

## Em uma frase

`rime` v6 prescreve um método em 6 skills + 1 motor de matriz, executável por qualquer harness (Claude Code, Antigravity, Codex), em que toda execução é precedida por clarificação humana e toda mudança estrutural deixa trilha auditável.

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

Detalhe e ancoragem em [.skills/_principles.md](.skills/_principles.md).

## As 6 skills

| Skill | Função |
|---|---|
| [bootstrap](.skills/bootstrap.md) | Inicialização de projeto (greenfield) |
| [captura](.skills/captura.md) | Captura de demanda em projeto operacional |
| [decisao](.skills/decisao.md) | Decisão arquitetural (ADR + matriz) |
| [execucao](.skills/execucao.md) | Delegação técnica disciplinada (test-first, gates) |
| [operacao](.skills/operacao.md) | Manutenção M1–M6 + fechamento |
| [salvaguarda](.skills/salvaguarda.md) | Segurança auditável + F0 + postmortem blameless |

E 1 motor (não-skill): [traceability/](traceability/) — matriz tripartite (`code-spec` × `spec-impact` × `spec-test`) + audit trail + smoke test em CI.

## Como adotar num projeto novo

1. Clonar/copiar este diretório para a raiz do projeto-cliente.
2. Rodar `bin/sync-skills.sh` para gerar adaptadores do harness escolhido.
3. Invocar a skill `bootstrap` (`/bootstrap` no harness) para extrair o contrato técnico.
4. Seguir o fluxo `captura → decisao? → execucao → operacao` para cada demanda.

## Modos de execução (D0)

| Modo | Quem opera o loop agentic | Default para |
|---|---|---|
| **A · API-first** | GitHub Actions + bots chamando provider LLM | times com squad de DevOps; operação 24/7 |
| **B · Harness-first** | sessão local com harness comercial | solo founder, MVP, time pequeno |
| **C · Híbrido** | misto | times intermediários |

Decisão tomada na fase 2 do `bootstrap`. Default recomendado para perfil não-engenheiro: **B**.

## Estrutura

```
v6/
├── .skills/                  # fonte de verdade — markdown universal
├── .claude/skills/           # adaptador Claude Code (gerado)
├── .agents/skills/           # adaptador Antigravity (gerado)
├── .harness-generic/         # adaptador genérico (gerado)
├── traceability/             # matriz tripartite + changelog
├── docs/{adr,templates,threat-models,postmortems,prompts}/
├── registro/{lista-problemas,passivos,sessoes/}
├── tests/regressao/
├── .ci/traceability-check.sh
└── bin/sync-skills.sh
```

Detalhe em [ARCHITECTURE.md](ARCHITECTURE.md).

## Documentação de design

Diretório `/Users/iagoleal/dev/_rime/output/` contém o material de design da fusão:

- `comparativo-mdcu-rime-v5.md` — comparativo dos antecessores.
- `principios-cientificos.md` — destilação científica dos princípios.
- `matriz-specs.md` — desenho da rastreabilidade tripartite.
- `esqueleto-framework.md` — árvore de diretórios e decisões.
- `skill-captura-poc.md`, `skills-restantes-poc.md`, `canonicos-poc.md` — POCs das skills e arquivos canônicos.
- `templates-adr-commit-poc.md` — templates do ADR e do selo de commit.
- `adaptadores-harness-poc.md` — script `sync-skills.sh` e CI.

## Status

Versão **0.1.0** — instanciação inicial em 2026-05-05. Smoke test E2E pendente.

## Licença

[AGPL-3.0](LICENSE) — quem usar (inclusive em SaaS) deve manter o código derivado aberto sob a mesma licença.
