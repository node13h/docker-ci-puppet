#!/usr/bin/env bash

set -euo pipefail

TEMP_DIR=$(mktemp -d)


cleanup () {
    rm -rf "${TEMP_DIR%/}/puppet"
    rmdir "$TEMP_DIR"
}


trap cleanup EXIT


main () {
    mkdir -p "${TEMP_DIR%/}/puppet"

    cp Puppetfile.in "${TEMP_DIR%/}/puppet/Puppetfile"

    ( cd "${TEMP_DIR%/}/puppet"; librarian-puppet install --clean --verbose )

    # shellcheck disable=SC2094
    (
        cd "${TEMP_DIR%/}/puppet"
        printf '# This file was auto-generated from Puppetfile.in.\n'
        printf '# See build-puppetfile.sh for more info.\n'
        printf '\n'
        grep '^forge ' Puppetfile
        printf '\n'
        librarian-puppet show | sed "s/^\(\(-\?[a-z][a-z0-9_]*\)\+\) (\([0-9.]\+\))\$/mod '\1', '\3'/" | sort
    ) >Puppetfile

}


main "$@"
