# Spec-Test Matrix

Mapeamento 1:N entre cada spec e os testes que a validam.

**Invariante**: spec sem teste em pelo menos 1 entrada é problema de severidade média (subespecificação comportamental). `bin/traceability-check.sh` reporta como warning; pode virar fail conforme MVES amadurecer.

## Convenção

Cada bloco tem o formato:

```
## <nome-da-spec>
- teste: `tests/<arquivo>::<caso>` — <descrição curta>
- teste: `tests/regressao/<arquivo>::<caso>` — <descrição>
- comando de validação alternativo: `<comando>`
- link de issue (caso teste ainda não exista): `#<N>`
```

Uma spec pode ter múltiplas entradas. A coluna "como validar" do critério de aceitação (skill `captura`, passo 9) **deve** apontar para algo que entre nesta matriz.

---

(Vazio neste momento. Entradas crescem conforme `execucao` adiciona testes novos.)
