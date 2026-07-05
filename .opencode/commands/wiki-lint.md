---description: Health-check the LLM wiki for contradictions, orphans, stale claims---
Run a structured lint pass over the wiki at `knowlegde/wiki/`, following the **Lint** operation defined in AGENTS.md § LLM Wiki Schema.

## Checks

Read every wiki page in `knowlegde/wiki/` (concepts/, entities/, sources/, synthesis/, index.md). For each, run the following checks:

### 1. Contradictions
Find statements across pages that contradict each other. List each contradiction with the two conflicting pages and the conflicting claims.

### 2. Stale claims
Identify claims in older pages that newer sources or synthesis pages have superseded. Flag each stale claim with the newer source that contradicts or refines it.

### 3. Orphan pages
Check every page for inbound `[[wikilinks]]` from other pages. List any page with zero inbound links as an orphan. Suggest which existing pages should link to it.

### 4. Missing concept pages
Scan all pages for `[[wikilinked]]` terms that don't have a corresponding file in `knowlegde/wiki/`. List each broken wikilink.

### 5. Missing cross-references
Find entities/concepts/sources that are related but currently lack cross-references between their pages. Suggest specific wikilinks to add.

### 6. Coverage gaps
Identify important concepts mentioned in pages that lack their own dedicated page. Flag these for potential creation.

## Output

Produce a structured report:

```
# Lint Report — YYYY-MM-DD

## Summary
(overall health: green/yellow/red + counts for each check)

## 1. Contradictions (N found)
...

## 2. Stale Claims (N found)
...

## 3. Orphans (N found)
...

## 4. Broken Wikilinks (N found)
...

## 5. Missing Cross-References (N suggested)
...

## 6. Coverage Gaps (N identified)
...

## Next Steps
(actionable recommendations, ordered by impact)
```

## After the report

- Do NOT make edits without user approval (except fixing obvious broken wikilinks where the target is clear).
- Log the lint pass to `knowlegde/wiki/log.md`:
  ```
  ## [YYYY-MM-DD] lint | Health check
  ```
- Suggest new sources to investigate or questions to explore based on gaps found.
