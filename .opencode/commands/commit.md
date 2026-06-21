---description: Stage all and commit with Conventional Commits---
First, stage all changes: `git add -A`

Then ask the user for a commit message following the [[conventional-commits]] convention:

1. **Type** — Ask the user to choose: `feat`, `fix`, `build`, `chore`, `ci`, `docs`, `style`, `refactor`, `perf`, `test`, `revert`
2. **Scope** (optional) — Ask if they want a scope in parentheses
3. **Breaking change** — Ask if this is breaking (append `!` after type/scope)
4. **Description** — Short summary (required)
5. **Body** (optional) — Longer explanation
6. **Footers** (optional) — e.g., `Refs: #123`, `Reviewed-by: X`

Construct the final message and commit with `git commit`.

If git user identity is not configured, set it locally using the values from `.gitconfig` before committing.
