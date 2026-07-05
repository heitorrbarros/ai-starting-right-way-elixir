# Conventional Commits

A lightweight convention on top of Git commit messages that provides an easy set of rules for creating an explicit commit history. This convention dovetails with SemVer by describing the features, fixes, and breaking changes made in commit messages.

## Specification

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Core Types

- **`fix`** — patches a bug (correlates with `PATCH` in SemVer)
- **`feat`** — introduces a new feature (correlates with `MINOR` in SemVer)

### Breaking Changes

Indicated by either:
- `BREAKING CHANGE:` in the footer, or
- `!` after the type/scope (e.g., `feat!:`, `feat(api)!:`)

Correlates with `MAJOR` in SemVer.

### Additional Types

`build:`, `chore:`, `ci:`, `docs:`, `style:`, `refactor:`, `perf:`, `test:`, and others are allowed.

### Structure

- Commits MUST be prefixed with a type, followed by optional scope, optional `!`, and REQUIRED colon and space
- Description is a short summary immediately after `type: `
- Body MAY follow one blank line after description
- Footers MAY follow one blank line after body, using `token: value` or `token #value` format
- `BREAKING CHANGE` MUST be uppercase

## Project Convention

This project uses Conventional Commits 1.0.0 for all commit messages.

Related: [[semver]], [[ousterhout-philosophy]]
