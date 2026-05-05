# Comandos canônicos do rime v6

Convenção: `/<skill>` é o entry-point; `/<skill> <subcomando>` é variante. Comandos invocados pelo usuário ou por outra skill via mecanismo do harness.

## bootstrap
- `/bootstrap` — inicializar projeto (greenfield); produz `ARCHITECTURE.md` + estrutura inicial + smoke test E2E.
- `/bootstrap --refresh` — re-executar fases sem apagar contrato; registra mudança em ADR.
- `/bootstrap --check` — validar que disco reflete `ARCHITECTURE.md`; falha em divergência.
- `/bootstrap --no-hooks` — pular instalação de hook pre-commit (modo B).

## captura
- `/captura` — capturar nova demanda em projeto operacional.
- `/captura status` — listar capturas em curso (rascunhos não confirmados).
- `/captura redirect` — redirecionar captura ativa para `decisao` ou `execucao`.

## decisao
- `/decisao` — abrir decisão arquitetural ou evento de evolução.
- `/decisao adr <título>` — gerar scaffold de ADR numerado em `.rime/docs/adr/`.
- `/decisao evolucao <E1..E8>` — abrir sub-fluxo de evolução estrutural.

## execucao
- `/execucao` — receber plano (de `captura` ou `decisao`); executar com gates de integração.
- `/execucao gate` — rodar smoke test da matriz (`.rime/ci/traceability-check.sh`).
- `/execucao fechar` — encerrar bloco; transferir para `operacao`.

## operacao
- `/operacao` — operação cotidiana; classifica em M1–M6 (bug · refactor · débito · deps · drift · model card).
- `/operacao lista` — listar problemas ativos em `.rime/registro/lista-problemas.md`.
- `/operacao revisar` — revisar problemas, mover ativos↔passivos, classificar severidade.
- `/operacao fechar` — fechar sessão; gera selo longitudinal e atualiza `.rime/registro/sessoes/`.

## salvaguarda
- `/salvaguarda` — auditoria periódica (canônica a cada 90d) ou rastreio em fase específica.
- `/salvaguarda threat-model` — modelar ameaças antes de implementar.
- `/salvaguarda incidente` — F0: SUSPENDE sessão em curso; abre protocolo de incidente.
- `/salvaguarda postmortem` — blameless, após resolução.

## traceability (motor, não-skill)
- `.rime/bin/traceability-check` — smoke test em CI; valida invariantes da matriz tripartite (≤10s).
- `.rime/bin/sync-skills` — gerar adaptadores por harness a partir de `.rime/skills/`.
