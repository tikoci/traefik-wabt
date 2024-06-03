
ENV ?=
OPTS ?= --no-gc --no-wasm-tail-call $(ENV)

all: .traefik.yml plugin.wasm 

plugin.wasm: plugin.gr
	grain compile $(OPTS) --wat plugin.gr  plugin.gr -o plugin.wasm

include ../Makefile.meta

clean:
	rm -v -f *.wasm
	rm -v -f *.wat