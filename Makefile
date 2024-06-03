TAG ?= traefik-wasm
SRCDIRS := ./plugins/src
.PHONY := all clean plugins tars brew-deps

BUILDX_PLATFORMS ?= linux/arm64,linux/arm/v7,linux/amd64
BUILDX_BUILDER_NAME ?= $(TAG)-multiarch-builder

plugins: FORCE
	$(MAKE) -C $(SRCDIRS)/wasm-go
	$(MAKE) -C $(SRCDIRS)/wasm-wat
	$(MAKE) -C $(SRCDIRS)/wasm-grain

clean: 
	$(MAKE) -C $(SRCDIRS)/wasm-go clean 
	$(MAKE) -C $(SRCDIRS)/wasm-wat clean
	$(MAKE) -C $(SRCDIRS)/wasm-grain clean

tars:
	rm *.tar
	docker build --no-cache --platform=linux/amd64 --output=type=docker --tag $(TAG)-x86:latest .
	docker save $(TAG)-x86 > $(TAG)-x86.tar 
	docker build --no-cache --platform=linux/arm64 --output=type=docker --tag $(TAG)-arm64:latest .
	docker save $(TAG)-arm64 > $(TAG)-arm64.tar 
	docker build --no-cache --platform=linux/arm/v7 --output=type=docker --tag $(TAG)-arm:latest .
	docker save $(TAG)-arm > $(TAG)-arm.tar 

brew-deps:
	brew install wabt
	brew install go
	brew tap tinygo-org/tools
	brew install tinygo
	brew install --no-quarantine --cask grain-lang/tap/grain

include Makefile.routeros
include Makefile.cli

FORCE:
