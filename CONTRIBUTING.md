# Contribuindo para o `rime`

Obrigado pelo interesse. `rime` é um framework prescritivo: é dele mesmo que precisamos para evoluí-lo. Logo, contribuições passam pelo próprio fluxo do framework.

## Antes de abrir issue ou PR

1. **Leia os 10 princípios canônicos** em [.skills/_principles.md](.skills/_principles.md). Toda contribuição é avaliada por eles.
2. **Releia o glossário** em [.skills/_glossary.md](.skills/_glossary.md) — vocabulário do framework é específico (blast radius, clarificação, contradição, F0).
3. **Identifique o tipo de contribuição** abaixo.

## Tipos de contribuição

### Reportar bug

Abra issue com label `type:bug`. Forneça:

- Versão do `rime` (commit ou tag).
- Harness em uso (Claude Code, Antigravity, Codex, etc.).
- D0 do projeto-cliente (A, B ou C).
- Passos de reprodução em teste mínimo (idealmente, faça um repo-cliente fictício).
- Comportamento esperado × observado.

Bugs **sem teste de reprodução** podem ser triados mas não são merged sem teste — invariante M1 da skill `operacao`.

### Sugerir feature

Abra issue com label `type:product`. Antes:

- Verifique se a feature toca célula 🟥 da matriz — se sim, vai precisar de ADR.
- Verifique se é manutenção (M1–M6) ou evolução (E1–E8) — eventos de evolução exigem evidência empírica.

### Abrir PR

1. Use a skill `captura` para estruturar a demanda (passos 1–13).
2. Use `execucao` para implementar test-first (commits separando teste e implementação).
3. Use `operacao` para fechar com selo canônico.

## Convenção de commits

Conventional Commits no título + bloco `A:`/`P:`/`Refs:` no body. Detalhe em [docs/templates/commit.md](docs/templates/commit.md).

```
<type>(<scope>): <subject>

A: <ação curta>
P: <plano sintético>
Refs: <ADRs, issues, registros>
```

**Tipos aceitos**: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, `perf`, `ci`, `build`, `prompt`.

**Vetado**: trailer `Co-Authored-By: Claude...` ou similar (preferência do mantenedor; RN-D-013 herdado do mdcu).

## Convenção de skill

- ≤150 linhas por SKILL.md (alvo: 80–150). Excesso é sinal para decompor.
- Princípios herdados em referência (não duplicar conteúdo de `_principles.md`).
- Sub-fluxo prescritivo em tabela `Passo · Ação · Output`.
- Self-check específico: 1–2 itens próprios + referência a `_self_check.md` global.

## Convenção de ADR

Use [docs/templates/adr.md](docs/templates/adr.md). Mínimo 2 alternativas com prós/contras. Sem alternativas, o ADR é prematuro — provavelmente ainda não há decisão genuína a tomar.

## Convenção de spec na matriz

Specs usam **h3** (`### <nome-da-spec>`); h2 reservado a meta-doc. `<nome-da-spec>` em `kebab-case`. Detalhe em [traceability/code-spec.md](traceability/code-spec.md).

## Gates antes de merge

- `bin/sync-skills.sh --check` (sincronia dos adaptadores).
- `.ci/traceability-check.sh` (invariantes da matriz).
- Suíte de regressão do framework quando existir (`tests/regressao/`).

## Linguagem

PT-BR para operação interna. Inglês onde a literatura usa termos consagrados (ex.: "blast radius", "test-driven", "Conventional Commits"). Sem mistura forçada.

## Code of Conduct

Tratamento respeitoso, técnico, sem ataques pessoais. Postmortem é blameless: ataca causa estrutural, nunca a pessoa.
