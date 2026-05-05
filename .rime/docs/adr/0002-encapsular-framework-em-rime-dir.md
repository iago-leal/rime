# ADR-0002 — Encapsular framework em `.rime/`

## Status
Aceito

## Data
2026-05-05

## Autor humano
@iagoleal

## Contexto

Após adoção inicial do framework (ADR-0001), o autor reportou poluição visual no workspace de desenvolvimento: ao adotar o `rime` num projeto-cliente, o conteúdo do framework (skills, scripts, matrizes, registro, docs, suíte de regressão) aparece misturado na raiz com o conteúdo do projeto.

Decisão tomada para isolar o framework em diretório dedicado `.rime/`, mantendo na raiz **apenas** o que é exigido por contrato externo (harness ou GitHub).

## Alternativas consideradas

| # | Opção | Prós | Contras |
|:---:|---|---|---|
| 1 | Manter estrutura atual (status quo) | sem trabalho de migração | poluição visual real; conflito com nomes/paths do projeto-cliente; viola princípio C4 (separação clara de responsabilidades) |
| 2 | Encapsular **só skills + scripts** em `.rime/`, deixando matrizes/registro/docs na raiz | menos arquivos a mover | inconsistente — `.rime/bin/sync-skills.sh` referencia `traceability/` na raiz, mistura framework e dados |
| 3 | **Encapsular tudo do framework em `.rime/`**, exceto exigências externas (`.claude/`, `.agents/`, `.harness-generic/`, `.github/workflows/`, `README.md`, `LICENSE`, `CONTRIBUTING.md`) | framework auto-contido em uma pasta; backup/exclusão atômica; convivência limpa com projeto-cliente | trabalho maior de reescrita de paths; mudança de blast radius alto |

## Decisão

`[P]` Adotar **opção 3 — encapsular tudo em `.rime/`**.

Estrutura final:

```
<projeto>/
├── .claude/                    # raiz — exigência Claude Code
├── .agents/                    # raiz — exigência Antigravity
├── .harness-generic/           # raiz — adaptador genérico
├── .github/workflows/          # raiz — convenção GitHub Actions
├── README.md                   # raiz — GitHub detecta
├── LICENSE                     # raiz — GitHub detecta
├── CONTRIBUTING.md             # raiz — GitHub detecta
└── .rime/
    ├── ARCHITECTURE.md
    ├── skills/                 # antes  .skills/
    ├── bin/                    # antes bin/
    ├── ci/                     # antes .ci/
    ├── templates/              # antes docs/templates/
    ├── traceability/           # antes traceability/
    ├── registro/               # antes registro/
    ├── docs/                   # antes docs/ (sem templates)
    └── tests/regressao/        # antes tests/regressao/
```

Migração via `git mv` (preserva histórico) + sed em massa para reescrita de paths.

## Consequências

- **Positivas**:
  - Workspace do dev fica limpo: só `.claude/`/`.agents/`/`.harness-generic/`/`.github/`/3 arquivos meta na raiz.
  - Framework auto-contido — `.rime/` pode ser deletado/atualizado/substituído como unidade.
  - Convivência limpa com `src/`, `tests/`, etc. do projeto-cliente.
- **Negativas / custo aceito**:
  - Mudança breaking: clones anteriores ficam com paths antigos; precisam migrar (issue documentada).
  - 26 arquivos com paths reescritos; risco de divergência entre paths em scripts e docs até gates verdes.
  - Adaptadores `.claude/skills/<nome>/SKILL.md` referenciam `.rime/skills/_*.md` (path canônico passa a depender de `.rime/`).
- **Neutras**:
  - `.github/workflows/gates.yml` continua na raiz mas comandos apontam para `.rime/bin/sync-skills.sh` etc.

## Blast radius

Células de `.rime/traceability/spec-impact.md` afetadas:

- 🟥 Layout de diretórios do framework — toda referência interna precisou ser reescrita.
- 🟥 Contrato com harness (Claude Code, Antigravity, genérico) — adaptadores agora apontam para `.rime/skills/`.
- 🟨 README/CONTRIBUTING/ARCHITECTURE — referências a paths atualizadas.
- 🟨 Smoke test do projeto-cliente (`smoke-test-otp/`) — fica desatualizado até ser regenerado em ciclo separado (não bloqueante; smoke é exemplo isolado).

## Referências

- ADR-0001: adoção do framework.
- Branch: `refactor/rime-folder`.
- PR: a ser criado após este ADR.

## Changelog desta ADR

- 2026-05-05 — criada (status: Aceito).
