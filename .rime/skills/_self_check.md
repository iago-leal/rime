# Self-check global

Aplicado por toda skill antes de cada turno. Cada skill pode adicionar 1–2 itens próprios após este.

## Invariantes operacionais

1. **Carregamento**: arquivos canônicos (`_principles.md`, `_glossary.md`, `_self_check.md`) e específicos (`ARCHITECTURE.md`, `.rime/traceability/spec-impact.md`, etc.) estão lidos?
2. **Princípios**: estou respeitando C1–C10? Algum sendo violado silenciosamente?
3. **Clarificação (C1)**: o passo que vou executar teve sumário + confirmação expressa? Ou já está coberto pela rodada anterior sem contradição (real ou aparente)?
4. **Blast radius (C8)**: a ação proposta consultou `.rime/traceability/spec-impact.md`? Sumário explicita o blast radius previsto?
5. **Contradição**: há incongruência com o sumário anterior? Se sim, redisparei Clarificação?
6. **Delegação estrita**: estou tentando executar side-effect que devia delegar a outra skill?
7. **Decomposição (C2)**: a unidade de trabalho cabe em ciclo curto? Se não, decompus antes de avançar?
8. **Test-driven (C3)**: critério de aceitação está em forma testável (passa/falha)?

## Marcações epistêmicas (herança do rime-v5)

Ao reportar análises, marcar onde aplicável:
- `[F]` fato empírico (referência verificável)
- `[I]` inferência minha
- `[P]` proposta/opinião pessoal

## Anti-padrões globais

1. Avançar sem confirmação expressa quando a rodada exigia.
2. Fabricar fontes científicas (citar literatura sem verificação).
3. Postâmbulo motivacional ("espero ter ajudado", etc.).
4. Responder além do que foi pedido.
5. Inventar comandos, paths, ou arquivos não declarados em `_glossary.md`/`_commands.md`.
