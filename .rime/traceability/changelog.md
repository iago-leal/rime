# Traceability Changelog

Audit trail de mudanças nas três matrizes (`code-spec.md`, `spec-impact.md`, `spec-test.md`).

**Invariante**: toda mudança em qualquer matriz exige entrada aqui (verificada por `.rime/bin/traceability-check.sh`).

## Formato

```
## YYYY-MM-DD — <breve descrição>
- Matriz alterada: code-spec | spec-impact | spec-test
- ADR de origem (se 🟥): ADR-NNNN
- Autor humano: @<handle>
- Sumário: <1–2 linhas>
```

---

## 2026-05-05 — Inicialização do framework rime v6
- Matriz alterada: todas (criadas vazias)
- ADR de origem: ADR-0001
- Autor humano: @iagoleal
- Sumário: bootstrap inicial do framework. Matrizes nascem vazias por design — entradas crescem orgânicamente conforme `decisao`/`execucao` operarem.

## 2026-05-05 — Encapsular framework em `.rime/` (refactor)
- Matriz alterada: code-spec, spec-impact (specs `layout-de-diretorios` e `contrato-harness` adicionadas com células 🟥)
- ADR de origem: ADR-0002
- Autor humano: @iagoleal
- Sumário: framework movido de raiz para `.rime/` para resolver poluição visual no workspace de adoção. Migração via `git mv` + sed em massa em 26 arquivos. Gates locais verdes (sync-skills, traceability-check, regressão 10/10).
