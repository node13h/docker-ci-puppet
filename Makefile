export CONTAINER_EXECUTABLE ?= docker
export CONTAINER_NETWORK ?= localci

GIT_TAG = $(shell git tag --points-at HEAD | tail -n 1)

.PHONY: pipeline pipeline-with-publish tag-pipeline reformat

pipeline: .gitlab-ci-local-variables.yml
	./run-pipeline.sh branch

pipeline-with-publish: .gitlab-ci-local-variables.yml
	./run-pipeline.sh branch --with-publish

tag-pipeline: .gitlab-ci-local-variables.yml
	./run-pipeline.sh tag $(GIT_TAG)

update-bundle:
	./run-local-task.sh update-bundle
