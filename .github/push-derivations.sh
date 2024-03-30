#!/usr/bin/env bash
OLDPATHS=$(cat /tmp/store-paths | jq -r 'keys | .[]')
NEWPATHS=$(nix path-info --all --json | jq -r 'keys | .[]')

PUSHPATHS=$(comm -13 <(printf '%s\n' "${OLDPATHS[@]}" | sort) <(printf '%s\n' "${NEWPATHS[@]}" | sort) | egrep -v '(.drv|.drv.chroot|.check|.lock)$')

tries=0
while IFS= read -r line; do
    echo Pushing $line...
    if attic push $CACHE $line ; then
        tries=0
    else
        tries=$((tries+1))
    fi

    if [ $tries -eq 5 ]; then
        echo "Repeated failure while pushing to attic cache!"
        exit 1
    fi
done <<< $PUSHPATHS

