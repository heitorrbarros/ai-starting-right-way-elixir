---description: View the LLM wiki log (last N entries or filtered by operation)---
Display entries from `knowlegde/wiki/log.md`, the append-only chronological record defined in AGENTS.md § Log.

## Usage

- `/wiki-log` — show the last 10 entries
- `/wiki-log --tail 5` — show last N entries
- `/wiki-log --op ingest` — show only ingest entries
- `/wiki-log --op lint` — show only lint entries
- `/wiki-log --op synthesis` — show only synthesis entries
- `/wiki-log --since 2026-06-01` — show entries after a date
- `/wiki-log --search "keyword"` — show entries matching keyword

## Procedure

1. Read `knowlegde/wiki/log.md`
2. Apply any filters from arguments ($ARGUMENTS)
3. Present the matching entries to the user in a readable format with entry dates, operations, and subject lines
4. If no arguments are given, show the last 10 entries by default

Each log entry follows the format:
```
## [YYYY-MM-DD] operation | Subject
```

Operations: `ingest`, `query`, `lint`, `synthesis`.

Entries are parseable with: `grep "^## \[" knowlegde/wiki/log.md`
