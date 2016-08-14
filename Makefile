.DEFAULT_GOAL := env

SHELL  := /usr/bin/env bash
VPATH  := src
VENDOR := vendor/src

TAG      = $(shell git describe --tags)
REVISION = $(shell git rev-parse --short HEAD)

.PHONY: init-install env vet lint code-check fmt imports test race-test vendor-restore vendor-fetch vendor-update vendor-clean serve deploy

init-install:
	go get github.com/golang/lint/golint
	go get golang.org/x/tools/cmd/goimports
	go get github.com/constabulary/gb/...
	go get code.palmstonegames.com/gb-gae

env:
	@goapp env

vet:
	@go vet ./$(VPATH)/...

lint:
	@golint -set_exit_status=true ./$(VPATH)/...

code-check: vet lint

fmt:
	@goapp fmt ./$(VPATH)/...

imports:
	@find $(VPATH) -type f -regex ".*\.go" -exec goimports -w {} \;

test:
	@gb gae test -v ./$(VPATH)/...

race-test:
	@gb gae test -v -race ./$(VPATH)/...

vendor-restore:
	@gb vendor restore
	@make vendor-clean

vendor-fetch:
	@read -p "Import path: " pkg; \
	gb vendor fetch $$pkg
	@make vendor-clean

vendor-update:
	@read -p "Import path: " pkg; \
	gb vendor update $$pkg
	@make vendor-clean

vendor-clean:
	@find -E $(VENDOR) -type d -regex ".*\/(_.+|vendor)" | xargs rm -rf
	@find -E $(VENDOR) -type f -regex ".*_test\.go" -delete

serve:
	@gb gae serve .

deploy:
ifndef GAE_APPLICATION_ID
	@read -p "Deploy application id: " appid; \
	gb gae deploy -application $$appid -version $(REVISION) .
else
	gb gae deploy -application $(GAE_APPLICATION_ID) -version $(REVISION) .
endif

deploy-tag:
ifndef GAE_APPLICATION_ID
	@read -p "Deploy application id: " appid; \
	gb gae deploy -application $$appid -version $(TAG) .
else
	gb gae deploy -application $(GAE_APPLICATION_ID) -version $(TAG) .
endif
