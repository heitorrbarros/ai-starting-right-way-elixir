# Semantic Versioning (SemVer)

A versioning scheme defined at [semver.org](https://semver.org) that communicates meaning about underlying changes through version numbers.

## Format

```
MAJOR.MINOR.PATCH
```

- **MAJOR** — incompatible API changes
- **MINOR** — backward-compatible new functionality
- **PATCH** — backward-compatible bug fixes

## Relationship to Conventional Commits

The [[conventional-commits]] specification maps directly to SemVer:
- `fix` → PATCH
- `feat` → MINOR
- `BREAKING CHANGE` or `!` → MAJOR

## Project Convention

This project uses SemVer for versioning its library releases, with Conventional Commits driving automated version bumps.

## Related

- [[conventional-commits]] — commit message convention that maps to SemVer
- [[jameswebb-architecture]] — the project applying these conventions
