---description: Stage all and infer commit message, then commit with Conventional Commits---
First, stage all changes: `git add -A`

Then run `git diff --cached` to inspect all staged changes. Consider the current LLM context (conversation history, user's intent, what was discussed) alongside the diff to infer an appropriate commit message following the [[conventional-commits]] convention:

1. **Type** — Infer the most appropriate type: `feat`, `fix`, `build`, `chore`, `ci`, `docs`, `style`, `refactor`, `perf`, `test`, `revert`
2. **Scope** (optional) — Infer if a scope in parentheses is appropriate (e.g., module/component name)
3. **Breaking change** — Infer based on whether the diff contains breaking API or behavior changes
4. **Description** — Short summary (required), inferred from the changes
5. **Body** (optional) — Longer explanation of the changes, inferred from the diff
6. **Footers** (optional) — e.g., `Refs: #123`, `Reviewed-by: X`

Present the inferred commit message to the user and ask for confirmation. If the user requests changes, refine the message iteratively. Once confirmed, commit with `git commit`.

If git user identity is not configured, set it locally using the values from `.gitconfig` before committing.
