# Spec-Impact Matrix (Blast Radius)

Declara o raio de impacto de cada entidade do projeto. Eixos: `Alvo de Mudança` × `Componente Impactado`.

## Pesos

- 🟥 **Impacto direto (quebra)** — aciona Gate Disjuntor; exige ADR.
- 🟨 **Impacto indireto (atenção)** — requer adaptação local, sem necessidade formal de ADR; exige revisão manual.
- 🟩 **Sem impacto** — fluxo livre.

## Comportamento do Gate

No início do ciclo de fechamento (`/operacao fechar`) ou em `bin/sync-skills.sh --check` em CI:

1. Cruzar diff do PR com esta matriz.
2. Se ≥1 célula 🟥 e não houver ADR criado/atualizado nesta sessão em `docs/adr/` → falha (Exit Code 1).
3. Se 🟨 → warning (revisão recomendada, não bloqueante).

## Convenção

Cada bloco tem o formato:

```
## <nome-da-spec>
- impacto em <componente A>: 🟥 — <descrição>
- impacto em <componente B>: 🟨 — <descrição>
- impacto em <componente C>: 🟩
```

---

(Vazio neste momento. Entradas crescem conforme `decisao` registra ADRs e `bootstrap`/`captura` mapeiam superfícies de quebra.)
