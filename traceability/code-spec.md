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

(Vazio neste momento. `bootstrap` deixa o arquivo vazio; entradas são adicionadas conforme módulos do projeto-cliente nascerem.)

Para o framework rime v6 em si: as 6 skills + 4 canônicos vivem em `.skills/` e seguem o template `.skills/_*.md`. Não há SDDs separadas — as próprias SKILL.md são as specs.
