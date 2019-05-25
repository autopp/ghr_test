THIS_GOVERSION=$(shell go version)
THIS_GOOS=$(word 1,$(subst /, ,$(lastword $(THIS_GOVERSION))))
THIS_GOARCH=$(word 2,$(subst /, ,$(lastword $(THIS_GOVERSION))))
GOOS=$(THIS_GOOS)
GOARCH=$(THIS_GOARCH)

PRODUCT=ghr_test
VERSION=$(patsubst "%",%,$(lastword $(shell grep 'const Version' main.go)))

RELEASE_DIR=releases
TARGET_DIR=$(RELEASE_DIR)/$(PRODUCT)_$(GOOS)_$(GOARCH)
TARGET=$(TARGET_DIR)/$(PRODUCT)$(SUFFIX)

.PHONY: build

build: $(TARGET)

$(TARGET):
	go build -o $@ .
