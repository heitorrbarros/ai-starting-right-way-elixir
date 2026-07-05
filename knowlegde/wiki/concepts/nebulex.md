# Nebulex Distributed Cache

A distributed caching library for Elixir that provides a local and distributed cache abstraction on top of various backends (ETS, Redis, etc.). Used in this project for multi-node load balancer state.

## Usage in Jameswebb

`Jameswebb.Cache` is a Nebulex cache using the `:partitioned` adapter. It stores three namespaces:
- `:backends` — health status, connection counts, uptime per backend URL
- `:strategy` — algorithm state (round-robin counter, least-connections per node)
- `:metrics` — rolling request counts, error rates

For single-node operation it falls back to ETS (Nebulex's local backend).

## Related

- [[jameswebb-architecture]] — architecture using Nebulex for distributed state
- [[ousterhout-philosophy]] — deep modules principle applied to the cache abstraction
