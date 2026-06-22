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