---description: Ingest a new source into the LLM wiki from knowlegde/raw/---
Follow the **Ingest** operation defined in AGENTS.md § LLM Wiki Schema.

The user added a new source to `knowlegde/raw/`. Pass the filename as the argument.

Usage: `/wiki-ingest <filename>` (e.g. `/wiki-ingest my-article.md`)

## Procedure

1. **Read the source** at `knowlegde/raw/$1`. Understand its content thoroughly.
2. **Discuss takeaways** — Summarize the key points to the user and ask what to emphasize, what to connect, and whether to create entities, concepts, or both.
3. **Write a summary page** — Create a page in `knowlegde/wiki/sources/` named after $1 (strip extension) with:
   - Title derived from the document
   - Brief description
   - Link back to `knowlegde/raw/$1`
   - Relevant `[[wikilinks]]` to existing wiki pages
4. **Update `index.md`** — Add an entry in `knowlegde/wiki/index.md` under the appropriate category (concept, entity, source, synthesis) with a one-line summary.
5. **Update entity/concept pages** — Find and update relevant pages in `knowlegde/wiki/entities/` and `knowlegde/wiki/concepts/` that this source touches. Add cross-references and update content as needed.
6. **Log the ingest** — Append an entry to `knowlegde/wiki/log.md`:
   ```
   ## [YYYY-MM-DD] ingest | $1
   
   (brief description of what was ingested and what pages were created/updated)
   ```

## Conventions

- Use `[[wikilink]]` syntax for cross-references
- Every page needs a `# Title` and a brief description
- All paths are relative to `knowlegde/`
- Be concise — one paragraph per page is often enough
- Only create pages that add lasting value (per Minimalism priority in AGENTS.md)
