ifndef GOARCH
	GOARCH=$(shell go env GOARCH)
endif

ifndef GOOS
	GOOS := $(shell go env GOOS)
endif

REPOSITORY := github.com/gihyodocker/print-version
VERSION_PACKAGE := "$(REPOSITORY)/pkg/version"
LDFLAG_VERSION := "$(VERSION_PACKAGE).version"

.PHONY: build
build:
	$(eval GIT_COMMIT := $(shell git describe --tags --always))
	CGO_ENABLED=0 GO111MODULE=on GOOS=$(GOOS) GOARCH=$(GOARCH) \
		go build -ldflags "-s -w -X $(LDFLAG_VERSION)=$(GIT_COMMIT)" \
		-o ./bin/print-version main.go