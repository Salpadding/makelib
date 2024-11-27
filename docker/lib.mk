# maybe replaced as podman
$(obj).docker ?= docker
# sudo is enabled by default
$(obj).sudo ?= sudo
$(obj).log_option ?= --log-driver local --log-opt max-size=512m
$(obj).docker_run ?= $($(obj).docker) run $($(obj).log_option)

# wait_port container port network
$(obj).wait_port = i=0; while [[ $$i -lt 24 ]]; do nc -z `$($(obj).sudo) $($(obj).docker) inspect --format '{{ .NetworkSettings.Networks.$(3).IPAddress }}' $1` $2 && exit 0 || let i++; sleep 1; done; exit 1

# keep container running
$(obj).docker_run_nx = if $($(obj).docker) ps | awk '$$NF == "$1"' | grep -q . ; then \
	[[ -z '$(FORCE)' ]] && exit 0 || $($(obj).docker) stop '$1'; \
	fi; \
	if $($(obj).docker) ps -a | awk '$$NF == "$1"' | grep -q . ; then \
		[[ -z '$(FORCE)' ]] && $($(obj).docker) restart '$(1)' && \
		exit 0 || $($(obj).docker) rm '$1'; \
	fi; \
	$(2)
