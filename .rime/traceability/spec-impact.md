# Spec-Impact Matrix (Blast Radius)

Declara o raio de impacto de cada entidade do projeto. Eixos: `Alvo de Mudança` × `Componente Impactado`.

## Pesos

- 🟥 **Impacto direto (quebra)** — aciona Gate Disjuntor; exige ADR.
- 🟨 **Impacto indireto (atenção)** — requer adaptação local, sem necessidade formal de ADR; exige revisão manual.
- 🟩 **Sem impacto** — fluxo livre.

## Comportamento do Gate

No início do ciclo de fechamento (`/operacao fechar`) ou em `.rime/bin/sync-skills.sh --check` em CI:

1. Cruzar diff do PR com esta matriz.
2. Se ≥1 célula 🟥 e não houver ADR criado/atualizado nesta sessão em `.rime/docs/adr/` → falha (Exit Code 1).
3. Se 🟨 → warning (revisão recomendada, não bloqueante).

## Convenção

Cada bloco tem o formato (h3 reservado a specs; h2 reservado a meta-docs):

```
### <nome-da-spec>
- impacto em <componente A>: 🟥 — <descrição>
- impacto em <componente B>: 🟨 — <descrição>
- impacto em <componente C>: 🟩
```

O nome da spec deve coincidir com a entrada em `code-spec.md` e (se houver) em `spec-test.md`.

---

### layout-de-diretorios
- impacto em todas as skills (`.rime/skills/*.md`): 🟥 — paths internos referenciam `.rime/skills/_*.md`, `.rime/traceability/`, etc. Mudança força reescrita.
- impacto em scripts (`.rime/bin/sync-skills.sh`, `.rime/ci/traceability-check.sh`): 🟥 — `SOURCE_DIR`, `TRACE_DIR`, `ADR_DIR` apontam para `.rime/...`.
- impacto em adaptadores (`.claude/skills/`, `.agents/skills/`, `.harness-generic/`): 🟨 — gerados a partir de `.rime/skills/`; conteúdo idêntico; só path da fonte muda.
- impacto em workflow CI (`.github/workflows/gates.yml`): 🟨 — comandos invocam `.rime/bin/...` em vez de raiz.

### contrato-harness
- impacto em adaptadores: 🟥 — qualquer mudança nos paths de carregamento dos canônicos (ex.: `.skills/_principles.md` → `.rime/skills/_principles.md`) força regeneração.
- impacto em harness não-mapeado (Codex etc.): 🟨 — destino genérico em `.harness-generic/` cobre.

### operacao-status
- impacto em `.rime/skills/operacao.md`: 🟨 — adição de comando à tabela "Comandos"; aditivo, não quebra fluxos existentes.
- impacto em `.rime/bin/`: 🟩 — novo script standalone; não renomeia nem altera scripts existentes.
- impacto em `.rime/registro/` (lista-problemas, sessoes, passivos): 🟩 — apenas leitura; script não escreve.
- impacto em `.rime/traceability/` e `.rime/docs/adr/`: 🟩 — apenas leitura.
- impacto em adaptadores e harness: 🟩 — operacao.md é canônica; sync-skills regenera adaptadores normalmente.
