THIS_GOVERSION=$(shell go version)
THIS_GOOS=$(word 1,$(subst /, ,$(lastword $(THIS_GOVERSION))))
THIS_GOARCH=$(word 2,$(subst /, ,$(lastword $(THIS_GOVERSION))))
GOOS=$(THIS_GOOS)
GOARCH=$(THIS_GOARCH)
ifeq ($(GOOS),windows)
SUFFIX=.exe
else
SUFFIX=
endif

PRODUCT=ghr_test
VERSION=$(patsubst "%",%,$(lastword $(shell grep 'const Version' main.go)))

ARTIFACT_DIR=$(CURDIR)/artifacts
TARGET_DIR=$(ARTIFACT_DIR)/$(PRODUCT)_$(GOOS)_$(GOARCH)
EXEFILE=$(TARGET_DIR)/$(PRODUCT)$(SUFFIX)

TARGETS=windows-amd64 windows-386 linux-amd64 linux-arm linux-arm64 linux-386 darwin-amd64 darwin-386
BUILD_TARGETS=$(addprefix build-,$(TARGETS))
RELEASE_TARGETS=$(addprefix release-,$(TARGETS))

.PHONY: build all clean

build: $(EXEFILE)

$(EXEFILE):
	go build -o $@ .

build-%:
	$(MAKE) build GOOS=$(word 2,$(subst -, ,$@)) GOARCH=$(word 3,$(subst -, ,$@))

all: $(BUILD_TARGETS)

$(ARTIFACT_DIR):
	mkdir -p $@

clean:
	rm -fR $(ARTIFACT_DIR)
