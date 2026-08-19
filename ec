#!/usr/bin/env bash

set -euo pipefail

# Use a terminal frame when ec is invoked as `ec -t`; Git and other callers
# otherwise get a GUI frame and wait for the edit to finish.
if [[ ${1:-} == "-t" ]]; then
    shift
    exec emacsclient -t -a "" "$@"
fi

exec emacsclient -c -a "" "$@"
