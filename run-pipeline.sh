#!/usr/bin/env sh

set -eu

unset CI_COMMIT_TAG UNSET_COMMIT_BRANCH ENABLE_PUBLISH_JOB

case "${1:-}" in
    tag)
        if [ -z "${2:+notempty}" ]; then
            >&2 printf 'Tag pipeline needs a tag name, but none was supplied\n'
            exit 1
        fi
        CI_COMMIT_TAG="$2"
        UNSET_COMMIT_BRANCH=1
        ;;

    branch)
        if [ "${2:-}" = '--with-publish' ]; then
            ENABLE_PUBLISH_JOB=1
        fi
        ;;

    *)
        exit 1
        ;;
esac

gitlab-ci-local \
    ${CONTAINER_EXECUTABLE:+--container-executable "$CONTAINER_EXECUTABLE"} \
    ${CONTAINER_NETWORK:+--network "$CONTAINER_NETWORK"} \
    ${CI_COMMIT_TAG:+--variable CI_COMMIT_TAG="$CI_COMMIT_TAG"} \
    ${UNSET_COMMIT_BRANCH:+--variable CI_COMMIT_BRANCH=} \
    ${ENABLE_PUBLISH_JOB:+--manual publish --manual publish-image}
