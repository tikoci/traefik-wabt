TAG ?= traefik-wasm
SRCDIRS := ./plugins/src
.PHONY := all clean plugins brew-deps

BUILDX_PLATFORMS ?= linux/arm64,linux/arm/v7,linux/amd64
BUILDX_BUILDER_NAME ?= $(TAG)-multiarch-builder

ROS_SSH ?= skyfi@bigdude.skyfi.link
ROS_PATH ?= raid1-part1/dev-traefik-wasm

plugins: FORCE
	$(MAKE) -C $(SRCDIRS)/wasm-go 
	$(MAKE) -C $(SRCDIRS)/wasm-wat 
    
tars: Dockerfile	
	rm *.tar
	docker build --no-cache --platform=linux/arm64 --output=type=docker --tag $(TAG)-arm64:latest .
	docker save $(TAG)-arm64 > $(TAG)-arm64.tar 
	docker build --no-cache --platform=linux/arm/v7 --output=type=docker --tag $(TAG)-arm:latest .
	docker save $(TAG)-arm > $(TAG)-arm.tar 

scpros:
	scp *.tar $(ROS_SSH):/$(ROS_PATH)-images

clean: 
	$(MAKE) -C $(SRCDIRS)/wasm-go clean 
	$(MAKE) -C $(SRCDIRS)/wasm-wat clean

brew-deps:
	brew install wabt
	brew install go
	brew tap tinygo-org/tools
	brew install tinygo

FORCE:
