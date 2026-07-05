# Wiki Commands for opencode

## Decision

Created three opencode custom commands for wiki maintenance: `/wiki-ingest`, `/wiki-lint`, `/wiki-log`.

## Context

The project follows the Karpathy LLM wiki pattern as defined in [[AGENTS.md]]. The wiki lives at `knowlegde/` with raw sources in `raw/` and compiled pages in `wiki/`. Previously, all wiki operations (ingest, lint, log) required explicit step-by-step instructions. The commands encode those workflows into reusable opencode commands, reducing friction and ensuring consistent execution.

## Commands

| Command | Purpose |
|---|---|
| `/wiki-ingest <file>` | Ingests a source from `knowlegde/raw/` — reads, discusses with user, creates summary page, updates index/entities/concepts, logs |
| `/wiki-lint` | Health-checks the wiki — contradictions, stale claims, orphan pages, broken wikilinks, missing cross-refs, coverage gaps |
| `/wiki-log` | Views and filters the wiki log by operation, date, or keyword |

## Implementation

- Each command is a markdown file in `.opencode/commands/` with YAML frontmatter (`description`) and a prompt body
- Commands reference the AGENTS.md schema conventions (wikilinks, directory structure, log format)
- `/wiki-ingest` accepts a filename argument (`$1`) for the source in `knowlegde/raw/`
- `/wiki-log` parses `$ARGUMENTS` for flags (`--tail`, `--op`, `--since`, `--search`)
- `/wiki-lint` runs 6 structured checks and produces a categorized report, logging to `log.md`

## Related

- [[index]] — content catalog of all wiki pages
- [[http-server-decision]] — prior synthesis page following the same pattern
