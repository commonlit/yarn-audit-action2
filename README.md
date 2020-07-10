# Yarn Audit Action ![build](https://github.com/jrmcdonald/yarn-audit-action/workflows/build/badge.svg)

This yarn audit action executes the `yarn audit` command with the option to ignore certain advisories. To ignore advisories add a `.yarn-audit-known-issues` file in the repository root:

```shell
yarn audit --json | grep auditAdvisory > .yarn-audit-known-issues
```

### Success Criteria

An exit code of `0` is considered a successful execution.

## Usage


```yaml
steps:
  - uses: jrmcdonald/yarn-audit-action@main
```
