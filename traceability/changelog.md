# Traceability Changelog

Audit trail de mudanças nas três matrizes (`code-spec.md`, `spec-impact.md`, `spec-test.md`).

**Invariante**: toda mudança em qualquer matriz exige entrada aqui (verificada por `bin/traceability-check.sh`).

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
