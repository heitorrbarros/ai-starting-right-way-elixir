# LLM Wiki Schema

This document defines how the LLM maintains this wiki. The wiki is a persistent, interlinked collection of markdown files that sits between raw sources and queries. Knowledge is compiled once and kept current — not re-derived on every question.

## Directory Structure

```
raw/              # Immutable source documents (articles, papers, notes)
wiki/             # LLM-generated markdown files — the wiki
  index.md        # Content-oriented catalog of every page
  log.md          # Append-only chronological record
  entities/       # Pages for people, places, organizations, etc.
  concepts/       # Pages for ideas, theories, patterns
  sources/        # Pages summarizing individual sources
  synthesis/      # Cross-cutting analyses, comparisons, overviews
```

## Conventions

- All wiki pages are markdown with `.md` extension
- Use `[[wikilink]]` syntax for cross-references between wiki pages
- Every page has a title (`# Title`), a brief description, and relevant wikilinks
- Source pages link back to the raw file path
- Entity and concept pages list related sources and related entities/concepts
- The LLM writes and updates all wiki pages; the user reads and curates

## Operations

### Ingest

When the user adds a new source to `raw/` and asks to ingest:

1. Read the source document
2. Discuss key takeaways with the user
3. Write a summary page in `wiki/sources/`
4. Update `wiki/index.md` — add the new page with a one-line summary
5. Update relevant entity and concept pages across `wiki/entities/` and `wiki/concepts/`
6. Append an entry to `wiki/log.md` with prefix: `## [YYYY-MM-DD] ingest | Title`

### Query

When the user asks a question:

1. Read `wiki/index.md` to find relevant pages
2. Read those pages
3. Synthesize an answer with citations to wiki pages
4. If the answer produces valuable new knowledge (comparison, analysis, connection), file it as a new page in `wiki/synthesis/` and update `index.md`

### Lint

Periodically or on request, health-check the wiki:

- Find contradictions between pages
- Flag stale claims that newer sources have superseded
- Identify orphan pages with no inbound links
- Spot important concepts mentioned but lacking their own page
- Note missing cross-references
- Suggest new questions and sources to investigate

## Index (`wiki/index.md`)

A catalog listing every wiki page with:
- Link to the page
- One-line summary
- Category (entity, concept, source, synthesis)
- Source count or date

Updated on every ingest. The LLM reads this first when answering queries.

## Log (`wiki/log.md`)

Append-only chronological record. Each entry starts with:
```
## [YYYY-MM-DD] operation | Subject
```

Operations: `ingest`, `query`, `lint`, `synthesis`.

Parseable with: `grep "^## \[" wiki/log.md | tail -5`

## Priorities

1. Accuracy — don't invent claims. Cite wiki pages. Flag uncertainty.
2. Consistency — when updating pages, update all related pages and cross-references.
3. Compounding — every interaction should make the wiki richer. File useful answers back into the wiki.
4. Minimalism — don't create pages for trivial or obvious things. Use judgment.
