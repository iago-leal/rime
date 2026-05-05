# Code-Spec Matrix

Mapeamento 1:1 ou 1:N entre arquivos físicos do projeto e suas especificações de design (SDDs).

**Invariante**: nenhum arquivo lógico (skill, script vital, framework markdown) pode existir sem correspondência aqui apontando para sua SDD.

## Convenção

Cada entrada tem o formato (h3 reservado a specs; h2 reservado a meta-docs):

```
### <nome-da-spec>
- arquivo: `<caminho>`
- spec: `<caminho da SDD ou seção>`
- responsável: @<handle>
- última revisão: YYYY-MM-DD
```

`<nome-da-spec>` é o identificador estável usado também em `spec-impact.md` e `spec-test.md`. Sem espaços, formato `kebab-case`.

---

Para o framework rime v6 em si: as 6 skills + 4 canônicos vivem em `.rime/skills/` e seguem o template `.rime/skills/_*.md`. Não há SDDs separadas — as próprias SKILL.md são as specs.

### layout-de-diretorios
- arquivo: estrutura inteira de diretórios do framework
- spec: `.rime/ARCHITECTURE.md` (seção "Estrutura de diretórios") + ADR-0002
- responsável: @iagoleal
- última revisão: 2026-05-05

### contrato-harness
- arquivo: `.rime/bin/sync-skills.sh` + saídas em `.claude/skills/<skill>/SKILL.md`, `.agents/skills/<skill>/SKILL.md`, `.harness-generic/<skill>.md`
- spec: `.rime/skills/_glossary.md` (entrada "Engine downstream") + `.rime/ARCHITECTURE.md`
- responsável: @iagoleal
- última revisão: 2026-05-05

### operacao-status
- arquivo: `.rime/bin/operacao-status.sh` + entrada `/operacao status` na tabela "Comandos" de `.rime/skills/operacao.md`
- spec: `.rime/skills/operacao.md` (seção "Comandos") — script é agregador determinístico de 5 fontes do registro
- responsável: @iagoleal
- última revisão: 2026-05-05
