# Princípios canônicos do rime v6

10 princípios não-negociáveis. Cada skill aplica um subset relevante e referencia este arquivo no preâmbulo.

## C1 — Clarificação antes de executar
A cada nova diretriz: sumário do entendimento + confirmação expressa do humano antes de agir. Reaplica-se sob contradição (real ou aparente) ou em mudança de blast radius alto.
Âncoras: Hassan 2025 (Merge-Readiness Pack / SASE); Barrak 2025 (handoffs Planner→Executor→Critic); Cemri 2025 (task verification — MAST); Clark & Brennan 1991 (grounding).

## C2 — Iterativo + incremental
Ciclos curtos, entregáveis pequenos, feedback rápido. Decomposição compulsória de demanda grande em sub-demandas pequenas.
Âncora: Dybå & Dingsøyr 2008.

## C3 — Test-driven
Toda spec nasce com critério de aceitação testável. Código novo precedido por teste. Suíte de regressão é viva (versionada, descontaminada, revisada).
Âncoras: Erdogmus 2005; Janzen & Saiedian 2008; Sharma 2025 (PromptPex); Liu 2025 (Cleverest); Commey 2026 (MVES); Koc 2025 (TQB++).

## C4 — Decomposição modular com papéis especializados
Tarefas complexas dividem-se entre skills/agentes com responsabilidade clara. Sub-skill só nasce com objetivo distinto bem definido.
Âncoras: Parnas 1972; Bandara 2025 (Agentsway); Khanzadeh 2025 (AgentMesh); Hong 2023 (MetaGPT); Arora 2024 (MASAI).

## C5 — Promptware Engineering
Prompts são artefatos de software. Versionados, testados, com taxonomia de defeitos catalogada, com schema de saída quando aplicável.
Âncoras: Chen 2025 (Promptware Engineering); Villamizar 2025; Tian 2025 (taxonomia de defeitos); Yang 2025 (subespecificação ≈ regressão); Wang 2025 (SLOT).

## C6 — Domain-aware
Práticas e modelos não generalizam entre domínios. Domínio é decisão explícita; afeta seleção de modelo, terminologia, regulação.
Âncoras: Bandara 2025; Yang 2025 (LLMs especializados); Ashiga 2025 (MoA em indústria regulada); Saravanan 2025 (OWASP/privacidade/licença).

## C7 — Budget como contrato (custo + latência)
Sistema agentic é caro. Decisões declaram orçamento explícito de tokens, latência e custo; sistema otimiza dentro dele.
Âncoras: Xiao 2025 (AgentDiet); Qiu 2025 (Co-Saving); Cai 2025 (AgentBalance); Sharma & Mehta 2025 (SLM); Si 2025 (CCPO); Liu 2025 (CostBench).

## C8 — Matriz de specs com blast radius
Rastreabilidade tripartite: arquivo↔spec, spec↔impacto (🟥/🟨/🟩), spec↔teste. Gate automático bloqueia execução sob risco estrutural sem ADR.
Âncoras: mdcu Traceability Engine; Hassan 2025; Raza 2025 (TRiSM); Cemri 2025; Yang 2025.

## C9 — Governança e segurança auditáveis
Toda decisão estrutural deixa trilha (ADR + audit trail). Privacidade e segurança são princípios de design. Postmortem é blameless e ataca causa estrutural — não pessoa.
Âncoras: Bandara 2025 (Agentsway, privacy-by-design); Raza 2025 (TRiSM); Sapkota 2025 (audit trails); Roychoudhury 2025; Saravanan 2025.

## C10 — Engine downstream desacoplável
A IA hospedeira (Claude Code, Antigravity, Codex) é motor trocável. Framework prescreve método; harness executa.
Âncoras: Bandara 2025 (tool-first / Model Context Protocol); rime-v5 modos D0; Sharma & Mehta 2025 (SLMs como alternativa).
