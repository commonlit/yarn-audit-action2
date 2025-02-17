#!/usr/bin/env bash

# workaround for missing feature
# https://github.com/yarnpkg/yarn/issues/6669

set -u

set +e
output=$(yarn audit --json --groups dependencies)
result=$?
set -e

if [ $result -eq 0 ]; then
  # everything is fine
  exit 0
fi

# Process the relevant JSONLines rows through jq to get them into an array
# then sort them, then output them again as JSONLines. This processing prevents
# unstable sorting of yarn-audit advisories from causing sorting-only diffs
if [ -f .yarn-audit-known-issues ] && echo "$output" | grep auditAdvisory | jq -cs '. | sort_by(.data.resolution.id)' | jq -c '.[]' | diff -q .yarn-audit-known-issues - > /dev/null 2>&1; then
  echo
  echo Ignorning known vulnerabilities
  exit 0
fi

echo
echo Security vulnerabilities were found that were not ignored.
echo
echo Check to see if these vulnerabilities apply to production
echo and/or if they have fixes available. If they do not have
echo fixes and they do not apply to production, you may ignore them.
echo
echo To ignore these vulnerabilities, run:
echo
echo "yarn audit --json --groups dependencies | grep auditAdvisory |  jq -cs '. | sort_by(.data.resolution.id)' | jq -c '.[]' > .yarn-audit-known-issues"
echo
echo and commit the yarn-audit-known-issues file.
echo
echo Advisories found:
echo
echo "$output" | grep auditAdvisory | jq '{  affects: .data.resolution.path, recommendation: .data.advisory.recommendation, url: .data.advisory.url }'

exit "$result"
