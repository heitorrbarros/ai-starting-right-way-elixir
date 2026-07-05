# HTTP Server: Bandit vs Cowboy

## Decision

Use **Bandit** as the HTTP server for Jameswebb.

## Context

Jameswebb is an OTP-native HTTP load balancer. It needs an HTTP server to:
- Accept client connections on port 8080
- Route requests to backend servers
- Support future HTTP/2 for efficient multiplexing (valuable in a load balancer)

## Alternatives Considered

| Criterion | Bandit | Cowboy |
|---|---|---|
| HTTP/2 | ✅ Native support | ❌ Not supported |
| API style | Elixir-native (AST-based config) | Erlang-style (proplists) |
| Speed | Faster (NIF-based HPACK parser) | Fast (pure Erlang) |
| Ecosystem fit | Default in modern Phoenix, active development | Mature, stable |
| WebSocket | Via `websock_adapter` | Native |
| Maturity | Newer but stable | Very mature |

## Rationale

1. **HTTP/2** — A load balancer benefits significantly from HTTP/2 multiplexing. Bandit's native HTTP/2 support is a strategic advantage.
2. **Elixir alignment** — Bandit's Elixir-native API integrates more naturally with the project's OTP-first approach.
3. **Active development** — Bandit is the default in Phoenix 1.8+, receiving active ecosystem investment.
4. **Sufficient maturity** — Production-tested in the Phoenix ecosystem; well-documented.

## Current Implementation

- `Jameswebb.Router` — a `Plug.Router` module mounted in Bandit
- Bandit started in the supervision tree via `{Bandit, plug: Jameswebb.Router, port: 8080}`
- Single `GET /` route returning a status message; 404 catch-all for unknown routes

## Related

- [[jameswebb-architecture]] — overall architecture, supervision tree
- [[ousterhout-philosophy]] — deep modules principle applied to clean router separation
- [[wiki-commands]] — opencode commands for wiki maintenance
