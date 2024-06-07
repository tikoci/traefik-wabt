
ENV ?= --release 
OPTS ?= --no-wasm-tail-call $(ENV)

all: .traefik.yml plugin.wasm 

plugin.wasm: plugin.gr http-wasm.gr icon.png
	grain compile $(OPTS) --wat plugin.gr  plugin.gr -o plugin.wasm 
	rm -rf target

include ../Makefile.meta

clean:
	rm -v -f *.wasm
	rm -v -f *.wat
