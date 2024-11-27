# use bash as default shell
SHELL := $(shell which bash)

# search submakes
submake = $(shell find $(1) -maxdepth 1 -type d | while read -r dir; do [[ -f $${dir}/Makefile ]] && [[ $${dir} != '$(1)' ]] && echo "$${dir}"; done)
