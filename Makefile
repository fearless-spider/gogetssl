PROJECT_NAME = gogetssl
SHELL := /bin/sh
help:
	@echo "Please use 'make <target>' where <target> is one of"
	@echo "  all                      to setup environment for the project and test"
	@echo "  deps             				install deps"
	@echo "  test                			run tests"

.PHONY: deps test

all: deps test

# Command variables
MANAGE_CMD = mix

# Helper functions to display messagse
ECHO_BLUE = @echo "\033[33;34m $1\033[0m"
ECHO_RED = @echo "\033[33;31m $1\033[0m"

deps:
	( \
		$(MANAGE_CMD) deps.get; \
	)

test:
	( \
		export GGSSL_AUTH_USERNAME=test; \
		export GGSSL_AUTH_PASSWORD=test; \
		$(MANAGE_CMD) test; \
	)
