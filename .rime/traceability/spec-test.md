# Spec-Test Matrix

Mapeamento 1:N entre cada spec e os testes que a validam.

**Invariante**: spec sem teste em pelo menos 1 entrada é problema de severidade média (subespecificação comportamental). `.rime/bin/traceability-check.sh` reporta como warning; pode virar fail conforme MVES amadurecer.

## Convenção

Cada bloco tem o formato (h3 reservado a specs; h2 reservado a meta-docs):

```
### <nome-da-spec>
- teste: `tests/<arquivo>::<caso>` — <descrição curta>
- teste: `.rime/tests/regressao/<arquivo>::<caso>` — <descrição>
- comando de validação alternativo: `<comando>`
- link de issue (caso teste ainda não exista): `#<N>`
```

Uma spec pode ter múltiplas entradas. A coluna "como validar" do critério de aceitação (skill `captura`, passo 9) **deve** apontar para algo que entre nesta matriz. Nome da spec coincide com `code-spec.md` e `spec-impact.md`.

---

### layout-de-diretorios
- teste: `.rime/tests/regressao/test-sync-skills.sh` (todos os 5 casos exercitam fonte em `.rime/skills/`)
- teste: `.rime/tests/regressao/test-traceability-check.sh` (paths esperados em `.rime/traceability/`)
- comando: `bash .rime/tests/regressao/run.sh`

### contrato-harness
- teste: `.rime/tests/regressao/test-sync-skills.sh::"--check após geração"`
- teste: `.rime/tests/regressao/test-sync-skills.sh::"--check detecta drift manual"`
- teste: `.rime/tests/regressao/test-sync-skills.sh::"canônicos _*.md não viram adaptador"`
- comando: `.rime/bin/sync-skills.sh --check`

### operacao-status
- teste: `.rime/tests/regressao/test-operacao-status.sh::"5 seções na ordem correta"`
- teste: `.rime/tests/regressao/test-operacao-status.sh::"fixture vazio degrada graciosamente"`
- teste: `.rime/tests/regressao/test-operacao-status.sh::"última sessão é a mais recente"`
- teste: `.rime/tests/regressao/test-operacao-status.sh::"ADRs em ordem decrescente até 5"`
- comando: `bash .rime/bin/operacao-status.sh`
