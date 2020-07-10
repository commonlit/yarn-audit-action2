FROM alpine:3.10

LABEL "maintainer"="Jamie McDonald <jamie@qwyck.net>"
LABEL "repository"="https://github.com/jrmcdonald/yarn-audit-action"
LABEL "homepage"="https://github.com/yarn-audit-action"

LABEL "com.github.actions.name"="yarn-audit"
LABEL "com.github.actions.description"="Run yarn audit with ignore"
LABEL "com.github.actions.icon"="terminal"
LABEL "com.github.actions.color"="purple"

RUN apk add --no-cache jq

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
