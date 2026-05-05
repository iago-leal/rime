# Glossário canônico do rime v6

Léxico mínimo. Sem termos clínicos (decisão de design 2026-05-05).

## Atores
- **Usuário**: humano que opera o framework. Coautor das decisões; autoridade única após contradição em Clarificação.
- **Agente / IA hospedeira**: harness (Claude Code, Antigravity, Codex, etc.) que carrega skills e executa fases.
- **Stakeholder**: pessoa afetada pelo sistema, mesmo que não interaja diretamente.
- **DPO / responsável**: owner formal do tratamento de dados (LGPD/HIPAA quando aplicável).

## Conceitos centrais
- **Demanda**: o que o usuário precisa resolver (intenção declarada).
- **Clarificação**: rodada {sumário do entendimento → confirmação expressa do humano} aplicada antes de qualquer execução. Princípio C1.
- **Blast radius**: raio de impacto de uma mudança, classificado em 🟥 (quebra — exige ADR), 🟨 (atenção — revisão manual), 🟩 (livre).
- **Spec / SDD**: especificação ou design document de uma entidade do projeto. **Convenção em `traceability/*.md`**: cada spec aparece como `### <nome-da-spec>` (h3); h2 reservado a meta-doc. `<nome-da-spec>` em `kebab-case` e idêntico nas 3 matrizes.
- **Matriz de specs**: tripla `code-spec` (arquivo↔spec) + `spec-impact` (blast radius) + `spec-test` (spec↔testes). Núcleo do C8.
- **ADR (Architecture Decision Record)**: registro numerado de decisão arquitetural irreversível, em `docs/adr/`.
- **Disjuntor / Gate**: mecanismo que bloqueia execução sob condição (ex.: 🟥 sem ADR; gate de integração; F0) e exige decisão humana.
- **Skill**: unidade modular do framework — markdown curto em `.skills/<nome>.md`.
- **Modo D0 (A/B/C)**: modo de execução do projeto — A=API-first; B=Harness-first; C=Híbrido. Decidido em `bootstrap`.
- **Engine downstream**: o harness do ponto de vista de uma skill orquestradora. Trocável (C10).
- **Registro**: prontuário do projeto em `registro/` — `lista-problemas.md`, `passivos.md`, `sessoes/`.
- **F0 (incidente)**: protocolo de salvaguarda que **suspende** sessão em curso para tratar incidente; contexto de sessão fica preservado.
- **Postmortem blameless**: análise pós-incidente que ataca causas estruturais; vetada redação com nome próprio.
- **Premissa [V] / [H]**: marcação `[V]` para premissa Verificável, `[H]` para Hipótese a validar.
- **Contradição**: incongruência entre sumário anterior e novo evento — real ou aparente. Redispara Clarificação.
- **Telegráfico**: forma de escrita curta (afirmação ≤5 palavras quando possível, reflexão em uma linha). Princípio operacional herdado.
- **Lock file determinístico**: arquivo que congela versões de dependências; sempre commitado, nunca em `.gitignore`.
- **MVES**: Minimum Viable Evaluation Suite (Commey 2026). Suíte de avaliação versionada e mantida viva.

## Termos importados sem alteração
CI · CD · smoke test · regression test · semver · monorepo. Significados padrão da indústria.
