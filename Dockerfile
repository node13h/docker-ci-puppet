ARG BASE_IMAGE
FROM $BASE_IMAGE

RUN useradd puppet

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends ca-certificates bash git ruby \
    && rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock ./

RUN apt-get update \
    && apt-get install --no-install-recommends -y ruby-bundler ruby-dev build-essential \
    && bundler install \
    && apt-get purge -y ruby-bundler ruby-dev build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY scripts/* /usr/local/bin/

USER puppet

# https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.revision=${GIT_COMMIT_SHA}
