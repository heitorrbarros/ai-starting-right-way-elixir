## [2026-06-21] concept | Conventional Commits

Created concept page for Conventional Commits 1.0.0 specification, establishing it as the project's commit message convention.

## [2026-06-21] concept | Ousterhout Philosophy of Software Design

Created concept page for John Ousterhout's *A Philosophy of Software Design*, establishing it as the project's primary design principle. Covers deep modules, information hiding, strategic vs tactical programming, and related tenets.

## [2026-06-21] synthesis | Jameswebb Load Balancer Architecture

Planned the Jameswebb Elixir load balancer: two-level supervision tree, Strategy behaviour (RoundRobin + LeastConnections), YAML config, health checks via ETS, telemetry events. Ready for implementation.

## [2026-06-21] concept | Ops Page (Phoenix + Tailwind)

Added ops management page: Phoenix LiveView at root path with Tailwind CSS. Full management capabilities — view/alter backends live, toggle algorithm, trigger health checks, view metrics.

## [2026-06-21] concept | Nebulex Distributed Cache

Added `Jameswebb.Cache` — Nebulex partitioned cache for backends health, strategy state, and metrics. Enables multi-node LB deployments with shared distributed state. Falls back to ETS for single-node. Updated supervision tree and config schema.

## [2026-07-04] synthesis | HTTP Server Decision (Bandit)

Chose Bandit over Cowboy for the HTTP server. Created [[http-server-decision]] synthesis page with comparison and rationale. Updated [[jameswebb-architecture]] supervision tree and data flow to reflect Bandit + Plug.Router. Added `bandit` and `plug` deps to mix.exs; implemented `Jameswebb.Router` (Plug.Router). App now listens on port 8080.

## [2026-07-04] synthesis | Wiki Commands

Created three opencode custom commands for wiki maintenance: `/wiki-ingest`, `/wiki-lint`, `/wiki-log`. Encodes the Karpathy LLM wiki ingest/lint/log operations from AGENTS.md into reusable commands. Created [[wiki-commands]] synthesis page with decision rationale and usage. Updated index.md and README.md.

## [2026-07-04] lint | Health check

Ran structured lint pass over all wiki pages. Report: 2 contradictions (ops page status, cache status), 2 stale claims, 0 orphans, 3 broken wikilinks (semver, nebulex, AGENTS.md), 5 missing cross-references suggested, 4 coverage gaps identified.

## [2026-07-04] lint | Fixes applied

Fixed all lint issues per user approval:
- Updated stale claims in [[jameswebb-architecture]] (ops page decision, cache status)
- Created [[semver]] and [[nebulex]] concept pages
- Replaced broken `[[AGENTS.md]]` wikilink with [[index]] link in [[wiki-commands]]
- Added cross-references: ousterhout-philosophy → jameswebb-architecture + http-server-decision; conventional-commits → ousterhout-philosophy; http-server-decision → wiki-commands
- Updated [[index]] with new pages
