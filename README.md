# ai-starting-right-way-elixir

This repository uses [opencode](https://opencode.ai) as the AI coding assistant. We've set up an **AI dome** to sandbox the AI — it operates within a controlled environment that prevents direct access to the host system.

## Local Development

### Prerequisites

- [Docker](https://docker.com)
- [Docker Compose](https://docs.docker.com/compose/) (v2)

### Commands

```bash
# Build & run the Elixir app (development environment)
make app

# Build & run the AI dome (opencode sandboxed environment)
make opencode

# Or manually:
docker compose up --build -d app    # start the app
docker compose up --build -d ai      # start the AI agent
```

Both services mount the project directory and run as the `ai-dome` (uid=1001) non-root user for security.

## Wiki Commands

The project maintains a persistent wiki at `knowlegde/` following the [LLM Wiki pattern described by Andrej Karpathy](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f). As Karpathy puts it:

> *"The wiki is a persistent, compounding artifact. The cross-references are already there. The contradictions have already been flagged. The synthesis already reflects everything you've read."*

Three opencode commands automate wiki operations:

| Command | Description |
|---|---|
| `/wiki-ingest <file>` | Ingest a source from `knowlegde/raw/` into the wiki |
| `/wiki-lint` | Health-check the wiki for contradictions, orphans, stale claims |
| `/wiki-log` | View the wiki log, filtered by operation, date, or keyword |