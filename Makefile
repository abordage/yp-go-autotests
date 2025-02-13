SHELL=/bin/bash

AUTOTESTS = gophermarttest metricstest devopstest shortenertest shortenertestbeta devopsmastertest
UTILS = random statictest shortenerstress

.PHONY: clear prep perm

all: prep autotests utils perm

clear:
	rm -rf bin/*

prep:
	go mod tidy

autotests:
	$(foreach TARGET,$(AUTOTESTS),GOOS=linux GOARCH=amd64 go test -c -o=bin/$(TARGET)-linux-amd64 -o=bin/$(TARGET) ./cmd/$(TARGET)/... ;)
	$(foreach TARGET,$(AUTOTESTS),GOOS=windows GOARCH=amd64 go test -c -o=bin/$(TARGET)-windows-amd64.exe ./cmd/$(TARGET)/... ;)
	$(foreach TARGET,$(AUTOTESTS),GOOS=darwin GOARCH=amd64 go test -c -o=bin/$(TARGET)-darwin-amd64 ./cmd/$(TARGET)/... ;)
	$(foreach TARGET,$(AUTOTESTS),GOOS=darwin GOARCH=arm64 go test -c -o=bin/$(TARGET)-darwin-arm64 ./cmd/$(TARGET)/... ;)

utils:
	$(foreach TARGET,$(UTILS),GOOS=linux GOARCH=amd64 go build -buildvcs=false -o=bin/$(TARGET)-linux-amd64 -o=bin/$(TARGET) ./cmd/$(TARGET)/... ;)
	$(foreach TARGET,$(UTILS),GOOS=windows GOARCH=amd64 go build -buildvcs=false -o=bin/$(TARGET)-windows-amd64.exe ./cmd/$(TARGET)/... ;)
	$(foreach TARGET,$(UTILS),GOOS=darwin GOARCH=amd64 go build -buildvcs=false -o=bin/$(TARGET)-darwin-amd64 ./cmd/$(TARGET)/... ;)
	$(foreach TARGET,$(UTILS),GOOS=darwin GOARCH=arm64 go build -buildvcs=false -o=bin/$(TARGET)-darwin-arm64 ./cmd/$(TARGET)/... ;)

perm:
	chmod -R +x bin

local-install:
	cp bin/gophermarttest-darwin-arm64 /Users/abordage/go/bin/yandex-practicum-gophermarttest
	cp bin/metricstest-darwin-arm64 /Users/abordage/go/bin/yandex-practicum-metricstest
	cp bin/random-darwin-arm64 /Users/abordage/go/bin/yandex-practicum-random
	cp bin/statictest-darwin-arm64 /Users/abordage/go/bin/yandex-practicum-statictest
	chmod -R +x /Users/abordage/go/bin
