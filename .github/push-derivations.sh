#!/usr/bin/env bash
set -eo pipefail

OLDPATHS=$(jq -r 'keys | .[]' < /tmp/store-paths)
NEWPATHS=$(nix path-info --all --json | jq -r 'keys | .[]')

PUSHPATHS=$(comm -13 <(printf '%s\n' "${OLDPATHS[@]}" | sort) <(printf '%s\n' "${NEWPATHS[@]}" | sort) | grep -Ev '(.drv|.drv.chroot|.check|.lock)$')

function push_paths() {
    tries=0
    while [ $tries -lt 5 ]; do
        if attic push "$CACHE" "$@" ; then
            exit 0
        fi

        tries=$((tries+1))
        sleep ${tries}m
    done

    echo "Repeated failure while pushing to attic cache!"
    exit 1
}

export -f push_paths

echo "$PUSHPATHS" | xargs -L20 bash -c 'push_paths "$@"' {}
