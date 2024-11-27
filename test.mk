obj := docker
include docker/lib.mk

$(info $(call docker.docker_run_nx,container,docker restart container))

test:
	: