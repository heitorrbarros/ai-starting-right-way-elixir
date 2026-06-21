# Jameswebb — Elixir Load Balancer Architecture

A simple, OTP-native HTTP load balancer built in Elixir. Named after the James Webb Space Telescope — observing, relaying, and balancing signals.

## Supervision Tree (Two-Level)

```
Application
 └── Jameswebb.Supervisor (top-level)
      ├── Jameswebb.Cache               # Nebulex distributed cache (partitioned)
      ├── Jameswebb.ConfigWatcher       # Reads/reloads YAML config
      ├── Jameswebb.BalancerSupervisor  # Mid-level supervisor
      │    ├── Jameswebb.Proxy          # GenServer per backend — reverse proxy via Finch/Mint
      │    └── Jameswebb.HealthChecker  # Periodic active health checks
      └── Jameswebb.Strategy            # GenServer — picks backend using current algorithm
```

## Core Design Principles

- **OTP-aligned**: Use GenServers, Supervision trees, and `:telemetry` events. No global state — everything lives in processes.
- **Deep modules** (Ousterhout philosophy): Each module has a focused responsibility and a clean, narrow API.
- **Configuration-driven**: YAML file defines backends, port, algorithm, health check parameters.

## Component Responsibilities

### `Jameswebb.ConfigWatcher`
- Reads `jameswebb.yaml` at startup.
- Watches for file changes and hot-reloads config.
- Broadcasts config updates via `:pg` or `Registry`.

### `Jameswebb.Strategy`
- A behaviour (`Jameswebb.Strategy`) with callbacks:
  - `init/1` — initialize state (list of backends, counters, etc.)
  - `pick/1` — select the next backend from available list
- Reads/writes algorithm state via `Jameswebb.Cache` so multi-node deployments stay consistent.
- Initial modules: `Jameswebb.Strategy.RoundRobin`, `Jameswebb.Strategy.LeastConnections`

### `Jameswebb.Proxy`
- A GenServer per backend connection pool.
- Forwards HTTP requests and streams responses back.
- Reports connection counts to Strategy and status to HealthChecker.

### `Jameswebb.Cache`
- A **Nebulex** distributed cache using the `:partitioned` adapter.
- Stores three cache namespaces under a single `Jameswebb.Cache` module:
  - `:backends` — health status (up/down), active connection counts, uptime per backend URL
  - `:strategy` — algorithm state (round-robin counter, least-connections per node)
  - `:metrics` — rolling request counts, error rates
- Provides a unified `Jameswebb.Cache` API for reads/writes across all LB components.
- Allows multi-node LB deployments to share state without a central DB.
- Falls back to ETS for single-node operation (Nebulex uses ETS as local backend).

### `Jameswebb.HealthChecker`
- Periodically pings each backend (`GET /health`).
- Marks backends up/down via `Jameswebb.Cache` (propagated to all nodes via Nebulex).
- Logs and emits telemetry events on status transitions.

## YAML Config (`jameswebb.yaml`)

```yaml
port: 4000
algorithm: round_robin  # round_robin | least_connections
backends:
  - url: http://localhost:3001
    health_check: /health
  - url: http://localhost:3002
    health_check: /health
health_check:
  interval_sec: 10
  timeout_ms: 2000
cache:
  adapter: partitioned        # partitioned | local
  nodes:                      # nil for single-node
    - :node1@127.0.0.1
    - :node2@127.0.0.1
```

## Data Flow

1. Client connects to `Jameswebb.Acceptor` (listens on configured port).
2. Acceptor delegates to `Jameswebb.Router` which calls `Strategy.pick/1`.
3. Strategy returns a backend URL (considering current health status).
4. Request is forwarded to `Jameswebb.Proxy` for that backend.
5. Response is streamed back to the client.
6. Telemetry events fired at each stage.

## Telemetry Events

- `[:jameswebb, :request, :start]` — request received
- `[:jameswebb, :request, :stop]` — response sent
- `[:jameswebb, :health, :up]` — backend came online
- `[:jameswebb, :health, :down]` — backend went offline
- `[:jameswebb, :config, :reload]` — config hot-reloaded

## Web UI: Ops Page (Phoenix + Tailwind)

A management dashboard at the root path (`GET /`) using a single **Phoenix LiveView** with **Tailwind CSS** — no router needed.

### Components

- **`Jameswebb.OpsView`** — LiveView that subscribes to telemetry events and ETS health table
- **`Jameswebb.OpsView.BackendCard`** — rendered component per backend showing URL, status (green/red badge), active connections, uptime
- **`Jameswebb.OpsView.MetricsPanel`** — rendered component with request rate, success/error counts
- **`Jameswebb.OpsView.Controls`** — form to add a new backend (URL + health check path), toggle algorithm, trigger health check refresh

### Data Flow

```
HealthChecker ───> Jameswebb.Cache ──┐
Proxy ───────────> Jameswebb.Cache ──┤
Strategy ────────> Jameswebb.Cache ──┤
                                    ├──> OpsView LiveView (subscribed via :telemetry)
                                    │       ├── renders BackendCard × N
                                    │       ├── renders MetricsPanel
                                    │       └── renders Controls (socket events → ConfigWatcher)
                                    │
                                    └──> Other LB nodes (via Nebulex partitioned adapter)
```

### Tailwind Use

Minimal Tailwind usage for badges, grid layout, status indicators. The Phoenix app includes the standard Tailwind setup from `mix phx.new`.

### OPS Page Capabilities

- View all backends live (up/down, connections, uptime)
- Toggle between `round_robin` and `least_connections` on the fly
- Add a new backend (URL + health check path)
- Remove a backend
- Trigger an immediate health check on all backends
- View request metrics (total requests, current rate)

## Related

- [[ousterhout-philosophy]] — deep modules, information hiding
- [[conventional-commits]] — commit message convention
- [[nebulex]] — Nebulex distributed caching library
