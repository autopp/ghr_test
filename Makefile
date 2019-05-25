THIS_GOVERSION=$(shell go version)
THIS_GOOS=$(word 1,$(subst /, ,$(lastword $(THIS_GOVERSION))))
THIS_GOARCH=$(word 2,$(subst /, ,$(lastword $(THIS_GOVERSION))))
GOOS=$(THIS_GOOS)
GOARCH=$(THIS_GOARCH)

PRODUCT=ghr_test
VERSION=$(patsubst "%",%,$(lastword $(shell grep 'const Version' main.go)))

BUILD_DIR=builds
TARGET_DIR=$(BUILD_DIR)/$(PRODUCT)_$(GOOS)_$(GOARCH)
TARGET=$(TARGET_DIR)/$(PRODUCT)$(SUFFIX)

BUILD_TARGETS=build-windows-amd64 build-windows-386 build-linux-amd64 build-linux-arm build-linux-arm64 build-linux-386 build-darwin-amd64 build-darwin-386

.PHONY: build all

build: $(TARGET)

$(TARGET):
	go build -o $@ .

build-windows-amd64:
	$(MAKE) build GOOS=windows GOARCH=amd64 SUFFIX=.exe

build-windows-386:
	$(MAKE) build GOOS=windows GOARCH=386 SUFFIX=.exe

build-linux-amd64:
	$(MAKE) build GOOS=linux GOARCH=amd64

build-linux-arm:
	$(MAKE) build GOOS=linux GOARCH=arm

build-linux-arm64:
	$(MAKE) build GOOS=linux GOARCH=arm64

build-linux-386:
	$(MAKE) build GOOS=linux GOARCH=386

build-darwin-amd64:
	$(MAKE) build GOOS=darwin GOARCH=amd64

build-darwin-386:
	$(MAKE) build GOOS=darwin GOARCH=386

all: $(BUILD_TARGETS)
