# Formato canônico do selo de commit

## Estrutura

```
<type>(<scope>): <subject>

A: <ação curta — o que foi feito>
P: <plano sintético — como/por quê>
Refs: <ADRs, issues, registros, PRs separados por vírgula>
```

## Tipos aceitos (Conventional Commits + extensão `prompt`)

| Tipo | Quando usar |
|---|---|
| `feat` | nova funcionalidade |
| `fix` | bug fix |
| `docs` | documentação ou ADR |
| `refactor` | mudança estrutural sem alterar comportamento (M2 da `operacao`) |
| `test` | adicionar/corrigir testes |
| `chore` | tarefa de manutenção que não afeta usuário (deps menores, lint, etc.) |
| `perf` | otimização de performance |
| `ci` | mudanças em CI/workflows |
| `build` | mudanças em sistema de build, dependências major |
| `prompt` | mudança em prompt registry (`.rime/docs/prompts/` ou `.rime/skills/`) — herdado do rime-v5 |

## Convenções

- `<scope>` é a skill afetada (`captura`, `decisao`, `execucao`, `operacao`, `salvaguarda`, `bootstrap`) ou o módulo do projeto (`auth`, `billing`, `traceability`, etc.). Quando atinge múltiplos, omite escopo.
- `<subject>` imperativo, ≤72 caracteres, sem ponto final.
- **A** (Ação): o que foi feito, em uma linha curta. Telegráfico (RN-D-002 herdado).
- **P** (Plano): como/por quê em uma linha. Pode mencionar testes, gates, validação.
- **Refs**: lista separada por vírgula. Aceita prefixos `ADR-NNNN`, `#issue`, `PR #M`, `.rime/registro/sessoes/<arquivo>.md`, `.rime/docs/postmortems/<arquivo>.md`.

## Exemplos

### Bug fix com ADR de causa raiz

```
fix(auth): corrigir vazamento de sessão em logout duplo

A: invalidar token JWT no logout antes de retornar 200
P: teste de reprodução em tests/auth/logout.test.ts; gate verde
Refs: ADR-0042, #189, .rime/registro/sessoes/2026-05-05.md
```

### Refactor sem mudança comportamental

```
refactor(billing): extrair módulo de cobrança recorrente

A: mover cálculo recorrente de billing.ts para billing/recurring.ts
P: testes existentes verdes; cobertura mantida; sem mudança de API
Refs: .rime/registro/sessoes/2026-05-06.md
```

### Mudança em prompt

```
prompt(captura): ajustar redirecionamento por blast radius

A: separar passos 7a (🟥) e 7b (cross-módulo) na sub-rotina
P: prompt revalidado contra evals/captura/; nenhuma regressão
Refs: ADR-0058, #234
```

### Atualização de model card

```
docs(captura): atualizar model card após drift M6

A: re-medir métricas primárias e fairness contra test set atualizado
P: deltas < limiar; sem trigger de Evolution
Refs: ADR-0061, docs/model-cards/captura-2026-05.md
```

## Anti-padrões

1. Trailer `Co-Authored-By: Claude...` ou similar — proibido (preferência global do user; RN-D-013 herdado).
2. `subject` vago (`"update"`, `"fix bugs"`, `"changes"`).
3. Bloco A/P/Refs ausente quando o commit fecha sessão de `operacao`.
4. Misturar mudança comportamental + refactor no mesmo commit (separar — invariante M2 da `operacao`).
5. Mega-commit com diff grande sem decomposição (viola C2; usar `git rebase -i` para decompor antes de PR).

## Quando A/P/Refs é dispensável

Micro-commits durante `execucao` (commits atômicos no meio do trabalho) podem ter só `<type>(<scope>): <subject>` sem o bloco. O selo completo só é obrigatório no commit que **fecha** uma sessão de `operacao` (selo longitudinal — herança commit-soap do mdcu).
