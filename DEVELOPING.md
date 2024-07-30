## Setting up a local development environment

Setup instructions should work for both Docker and (rootless)
Podman (tested on Fedora 39 with Podman 4.9.0).

### Install prerequisites

- [gitlab-ci-local](https://github.com/firecow/gitlab-ci-local).
- Podman or Docker
- GNU Make
- `qemu-user-static` to enable cros-platform builds.

### Set up a container network for builds

To run CI jobs locally, a container network with DNS for container names enabled
is necessary. The default network has it disabled, so not suitable.
To create a new network named `localci` run

```shell
docker network create localci
```

### Set up a local container registry

Container builds need a registry to store and pass built images between jobs.
To start a local registry container named `localci-registry` in background run

```
docker run -d --restart=on-failure -p 5000:5000 --name localci-registry --network localci \
    docker.io/library/registry:2
```

### Define local CI variables

Use the following example to create `.gitlab-ci-local-variables.yml`. Note
the `localci-registry` address matching the name of the local registry container
created earlier.

```shell
{
    read -rp 'DockerHub username: ' dockerhub_user
    read -rsp 'DockerHub token: ' dockerhub_token
    dockerhub_auth=$(printf '%s:%s' "$dockerhub_user" "$dockerhub_token" | base64)

    cat <<EOF >.gitlab-ci-local-variables.yml
---
PUBLISH_IMAGE: 'docker.io/alikov/ci-puppet'
CI_REGISTRY: 'localci-registry:5000'
CI_REGISTRY_IMAGE: 'localci-registry:5000/ci-puppet'
TRIVY_INSECURE: 'true'
CONTAINERS_REGISTRIES_CONF:
  type: file
  values:
    '*': |
      [[registry]]
      location = "localci-registry:5000"
      insecure = true

REGISTRY_AUTH_FILE:
  type: file
  values:
    '*': |
      {"auths": {
        "docker.io": {
          "auth": "${dockerhub_auth}"
        }
      }}
EOF
}
```

## Running builds locally

Run `make pipeline` to run the pipeline defined in [.gitlab-ci.yml](.gitlab-ci.yml).
Run `make publish-pipeline` to run the pipeline including the manual `publish` job.

See [Makefile](Makefile) for more details. Override `CONTAINER_NETWORK` if the
default `localci` is different from the network name created earlier.


## Local tasks

- `make update-bundle` updates versions in [Gemfile.lock](Gemfile.lock).

See `.local-tasks.yml` for more information.

## Releasing

- Create an annotated (to track the release date) Git tag using `vX.Y.Z` format.
  `X.Y.Z` must match the version in [VERSION](VERSION).
- Push the tag.
- Ensure the Git working tree is clean.
- Run `make tag-pipeline`.
- Increment the version number in [VERSION](VERSION) keepping the `dev`
  identifier, and commit the change.
